import 'package:danvery/domain/board/post/general_post/controller/general_post_controller.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:get/get.dart';

import '../../../../../../domain/board/post/petition_post/controller/petition_post_controller.dart';

class BoardPageController extends GetxController {
  final RxInt _selectedTap = 0.obs;

  int get selectedTap => _selectedTap.value;

  set selectedTap(index) => _selectedTap.value = index;

  final RxInt _selectedCategory = 0.obs;

  int get selectedCategory => _selectedCategory.value;

  set selectedCategory(index) => _selectedCategory.value = index;

  final GeneralPostController generalPostController =
      Get.find<GeneralPostController>();
  final PetitionController petitionPostController =
      Get.find<PetitionController>();

  final RxList<GeneralPostModel> _generalPostListBoard =
      <GeneralPostModel>[].obs;
  final RxBool _isLoadGeneralPostListBoard = false.obs;

  List<GeneralPostModel> get generalPostListBoard => _generalPostListBoard;

  bool get isLoadGeneralPostListBoard => _isLoadGeneralPostListBoard.value;

  final RxList<PetitionPostModel> _petitionListBoard =
      <PetitionPostModel>[].obs;

  List<PetitionPostModel> get petitionListBoard => _petitionListBoard;

  final RxBool _isLoadPetitionListBoard = false.obs;

  bool get isLoadPetitionListBoard => _isLoadPetitionListBoard.value;

  @override
  void onInit() {
    // TODO: implement onInit
    generalPostController.getGeneralPostListBoard(0, 5).then((value) {
      if (value != null) {
        _generalPostListBoard.value = value;
        _isLoadGeneralPostListBoard.value = true;
      }
    });
    petitionPostController
        .getPetitionListBoard(0, 5, PetitionStatus.active.name.toUpperCase())
        .then((value) {
      if (value != null) {
        _petitionListBoard.value = value;
        _isLoadPetitionListBoard.value = true;
      }
    });
    super.onInit();
  }
}
