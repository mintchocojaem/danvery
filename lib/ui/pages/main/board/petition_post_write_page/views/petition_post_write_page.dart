import 'dart:io';
import 'package:danvery/core/interceptor/dio_interceptor.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_write_model.dart';
import 'package:danvery/ui/pages/main/board/petition_post_write_page/controller/petition_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/board/category_button_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetitionPostWritePage extends GetView<PetitionPostWritePageController> {
  const PetitionPostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: '글 작성하기',
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
            child: Obx(
              () => ModernFormButton(
                isEnabled: !controller.isPosting.value &&
                    controller.titleController.value.text.isNotEmpty &&
                    controller.contentController.value.text.isNotEmpty,
                width: 60,
                coolDownTime: 3,
                text: "등록",
                onPressed: () async {
                  showCupertinoDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text("청원 게시글 등록"),
                        content: const Text(
                            "청원 게시글을 등록하시겠습니까?\n등록 후에는 수정 및 삭제가 불가능합니다."),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text(
                              '취소',
                            ),
                            onPressed: () async {
                              Get.back();
                            },
                          ),
                          CupertinoDialogAction(
                            child: Text(
                              '확인',
                              style: TextStyle(
                                color: Palette.lightRed,
                              ),
                            ),
                            onPressed: () async {
                              PetitionPostWriteModel petitionPostWriteModel =
                                  PetitionPostWriteModel(
                                title: controller.titleController.value.text,
                                body: controller.contentController.value.text,
                                files: controller.imageList
                                    .map((e) => FileModel.fromImagePicker(e))
                                    .toList(),
                                tagIds: [
                                  apiUrl == "https://dev.dkustu.com/api" ? PetitionPostTag.values[controller.selectedTag.value].devServerTagId
                                      : PetitionPostTag.values[controller.selectedTag.value].mainServerTagId
                                ],
                              );
                              Get.back(); //청원은 등록전에 dialog 띄우므로, dialog 닫기
                              await controller.writePetitionPost(
                                  petitionPostWriteModel);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(
                () => CategoryButtonBar(
                  selectedIndex: controller.selectedTag.value,
                  categories:
                      PetitionPostTag.values.map((e) => e.nameKR).toList(),
                  selectedBackGroundColor: Palette.blue,
                  unSelectedBackGroundColor: Palette.white,
                  selectedTextColor: Palette.pureWhite,
                  unSelectedTextColor: Palette.grey,
                  onTap: (value) async {
                    controller.selectedTag.value = value;
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        textInputAction: TextInputAction.next,
                        controller: controller.titleController.value,
                        maxLines: 1,
                        style: regularStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Palette.darkGrey),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "제목",
                          hintStyle: regularStyle.copyWith(
                              fontWeight: FontWeight.bold, color: Palette.grey),
                        ),
                      ),
                      Divider(
                        color: Palette.lightGrey,
                        thickness: 1,
                      ),
                      TextField(
                        controller: controller.contentController.value,
                        style: regularStyle.copyWith(color: Palette.darkGrey),
                        maxLength: 5000,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText: "내용\n\n- 부적절하거나 불쾌감을 줄 수 있는 게시글은 제재를 받을 수 있습니다.\n\n"
                              "- 청원게시글은 하루에 1번 작성할 수 있습니다.\n",
                          hintMaxLines: 10,                          hintStyle: regularStyle.copyWith(
                              color: Palette.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: Palette.lightGrey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "사진 첨부하기",
                        style: regularStyle.copyWith(
                            color: Palette.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              getImageBottomSheet();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.lightGrey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              height: 80,
                              width: 80,
                              child: Icon(
                                Icons.image_outlined,
                                color: Palette.grey,
                              ),
                            ),
                          ),
                          for (int i = 0; i < controller.imageList.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.file(
                                      File(controller.imageList[i].path),
                                    ).image,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                height: 80,
                                width: 80,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 30,
                                    color: Palette.darkWhite.withOpacity(0.6),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.delete,
                                        color: Palette.darkGrey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        controller.imageList.removeAt(i);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImageBottomSheet() async {
    final ImagePicker picker = ImagePicker();

    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text('취소'),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('사진 찍기'),
            onPressed: () async {
              Get.back();
              if (await controller.permissionService.getCameraPermission()) {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 50,
                  maxHeight: 1920,
                  maxWidth: 1080,
                );
                if (image != null) {
                  controller.imageList.add(image);
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              '사진 보관함',
            ),
            onPressed: () async {
              Get.back();
              if (await controller.permissionService.getGalleryPermission()) {
                await picker
                    .pickMultiImage(
                  imageQuality: 50,
                  maxHeight: 1920,
                  maxWidth: 1080,
                )
                    .then((value) {
                  controller.imageList.addAll(value);
                });
              }
            },
          )
        ],
      ),
    );

    //await picker.pickImage(source: ImageSource.camera);
    /*
    // Pick a video.
        final XFile? galleryVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    // Capture a video.
        final XFile? cameraVideo = await picker.pickVideo(source: ImageSource.camera);
    // Pick multiple images.
        final List<XFile> images = await picker.pickMultiImage();

         */
  }
}
