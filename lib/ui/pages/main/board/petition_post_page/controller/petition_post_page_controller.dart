import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_statistic_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PetitionPostPageController extends GetxController {
  final PetitionPostRepository _petitionPostRepository =
      PetitionPostRepository();

  final LoginService loginService = Get.find<LoginService>();

  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  late Rx<PetitionPostModel> petitionPost;

  final RxBool isLoadedPetitionPost = false.obs;

  final int id = Get.arguments;

  final RxBool isLoadedImageList = false.obs;

  @override
  void onInit() {
    getPetitionPost();
    super.onInit();
  }

  Future<void> getPetitionPost() async {
    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.getPetitionPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      final PetitionPostModel petitionPostModel =
          apiResponseDTO.data as PetitionPostModel;
      petitionPost = petitionPostModel.obs;
      await getImageList();
      isLoadedPetitionPost.value = true;
    }
  }

  Future<void> agreePetition() async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      barrierDismissible: false,
    );

    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.agreePetitionPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      petitionPost.update((val) {
        val!.agreeCount += 1;
        val.agree = true;
        final userDepartment = loginService.userInfo.value.department;
        if (val.statisticList
            .where((element) => element.department == userDepartment)
            .isEmpty) {
          val.statisticList.add(PetitionStatisticModel(
              agreeCount: 1, department: userDepartment));
        } else {
          val.statisticList
              .firstWhere((element) => element.department == userDepartment)
              .agreeCount += 1;
        }
        Get.back();
        Get.back();
      });
    } else {
      GetXSnackBar(
        title: '청원게시글 동의 오류',
        content: apiResponseDTO.message,
        type: GetXSnackBarType.customError,
      ).show();
    }
  }

  Future<void> reportPetitionPost(String categoryName) async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      barrierDismissible: false,
    );

    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.reportPetitionPost(
            token: loginService.token.value.accessToken,
            postId: id,
            categoryName: categoryName);
    if (apiResponseDTO.success) {
      Get.back();
      GetXSnackBar(
        title: '게시글 신고',
        content: '신고가 접수되었습니다. 검토까지는 최대 24시간이 소요됩니다.',
        type: GetXSnackBarType.info,
      ).show();
    } else {
      Get.back();
      GetXSnackBar(
        title: '게시글 신고 오류',
        content: apiResponseDTO.message,
        type: GetXSnackBarType.customError,
      ).show();
    }
  }

  Future<void> blindPetitionPost() async {
    final ApiResponseDTO apiResponseDTO =
        await _petitionPostRepository.blindPetitionPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      await boardPageController.getPetitionPostBoardWithRefresh(true);
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              content: "게시글이 정상적으로 블라인드 처리되었습니다",
              title: "게시글 블라인드")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 블라인드 오류")
          .show();
    }
  }

  void saveAndGetBack() {
    if (isLoadedPetitionPost.value) {
      petitionPost.value.agreeCount = petitionPost.value.agreeCount;
      petitionPost.value.agree = petitionPost.value.agree;
      Get.back(result: petitionPost.value);
    } else {
      Get.back();
    }
  }

  Future<void> getImageList() async {
    for (FileModel j in petitionPost.value.files) {
      if (j.mimeType.contains('image')) {
        j.url =
            (await fileFromImageUrl(j.url, j.originalName ?? "image$j")).path;
      }
    }
    isLoadedImageList.value = true;
  }
}
