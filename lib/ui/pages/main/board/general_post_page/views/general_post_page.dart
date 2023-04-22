import 'dart:io';

import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controller/general_post_page_controller.dart';

class GeneralPostPage extends GetView<GeneralPostPageController> {
  const GeneralPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey generalPostHeightKey = GlobalKey();
    controller.generalPostHeightKey = generalPostHeightKey;

    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "자유게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          controller.saveAndGetBack();
        },
        actions: [],
      ),
      body: Obx(
        () => controller.isLoadedGeneralPost.value &&
                controller.isLoadedGeneralComment.value &&
                controller.isLoadedImageList.value
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller
                              .getGeneralPost(controller.generalPost.value.id);
                          await controller.getFirstGeneralComment(
                              controller.generalPost.value.id);
                        },
                        child: SingleChildScrollView(
                          controller: controller.generalPostScrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                key: generalPostHeightKey,
                                children: [
                                  Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: Image.asset(
                                                    "assets/icons/user/profile_icon.png")
                                                .image,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .generalPost.value.author,
                                                style: regularStyle.copyWith(
                                                    color: Palette.darkGrey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller.generalPost.value
                                                    .createdAt,
                                                style: tinyStyle.copyWith(
                                                    color: Palette.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {
                                              generalPostPopup(
                                                  controller.generalPost.value);
                                            },
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Palette.darkGrey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.generalPost.value.title,
                                        style: smallTitleStyle.copyWith(
                                            color: Palette.darkGrey),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Html(
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(
                                                regularStyle.fontSize!),
                                            color: Palette.darkGrey,
                                            padding: EdgeInsets.zero,
                                            margin: Margins.zero,
                                          ),
                                        },
                                        data: controller.generalPost.value.body,
                                        onLinkTap: (String? url,
                                            RenderContext context,
                                            Map<String, String> attributes,
                                            _) {
                                          if (url != null) {
                                            launchUrlString(url);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var i = 0;
                                            i <
                                                controller.generalPost.value
                                                    .files.length;
                                            i++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Palette.lightGrey,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              width: 120,
                                              height: 120,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                child: controller.generalPost
                                                        .value.files[i].mimeType
                                                        .contains('image')
                                                    ? InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              Routes.imageShow,
                                                              arguments: {
                                                                "imagePathList":
                                                                    controller
                                                                        .generalPost
                                                                        .value
                                                                        .files
                                                                        .map((e) =>
                                                                            e.url),
                                                                "index": i,
                                                              });
                                                        },
                                                        child: Image.file(
                                                          File(controller
                                                              .generalPost
                                                              .value
                                                              .files[i]
                                                              .url),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {

                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                controller
                                                                        .generalPost
                                                                        .value
                                                                        .files[
                                                                            i]
                                                                        .originalName ??
                                                                    "file",
                                                                style: const TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              const Icon(Icons
                                                                  .file_download)
                                                            ],
                                                          ),
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
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "댓글 ${controller.generalCommentList.value.totalElements.toString()}",
                                    style: regularStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Palette.black),
                                  ),
                                  Obx(
                                    () => OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        side: BorderSide(
                                          width: 2,
                                          color:
                                              controller.generalPost.value.liked
                                                  ? Palette.lightBlue
                                                  : Palette.lightGrey,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            controller.generalPost.value.liked
                                                ? "assets/icons/post/like_selected.png"
                                                : "assets/icons/post/like_unselected.png",
                                            width: 18,
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "좋아요",
                                            style: lightStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller
                                                      .generalPost.value.liked
                                                  ? Palette.lightBlue
                                                  : Palette.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            controller.generalPost.value.likes
                                                .toString(),
                                            style: lightStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller
                                                      .generalPost.value.liked
                                                  ? Palette.lightBlue
                                                  : Palette.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      onPressed: () async {
                                        controller.likeGeneralPost(
                                            controller.generalPost.value.id);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Palette.lightGrey,
                                thickness: 1,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    controller.generalComments.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index ==
                                      controller.generalComments.length) {
                                    if (controller
                                        .generalCommentList.value.last) {
                                      return const SizedBox();
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  }
                                  return Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: Image.asset(
                                                        "assets/icons/user/profile_icon.png")
                                                    .image,
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .author,
                                                    style:
                                                        regularStyle.copyWith(
                                                            color: Palette
                                                                .darkGrey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .createdAt,
                                                    style: tinyStyle.copyWith(
                                                        color: Palette.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .text,
                                                    style: regularStyle,
                                                  ),
                                                  /*
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/post/like_unselected.png",
                                                      width: 12,
                                                      height: 12,
                                                      color: Palette.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),

                                                    Text(
                                                      "0",
                                                      style: lightStyle.copyWith(
                                                          color: Palette.grey),
                                                    )
                                                  ],
                                                ),

                                                 */
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Divider(
                                            color: Palette.lightGrey,
                                            thickness: 1,
                                          ),
                                        ],
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {
                                              generalCommentPopup(
                                                  controller.generalPost.value,
                                                  controller
                                                      .generalComments[index]);
                                            },
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Palette.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.transparent,
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 1000,
                                    maxLines: 3,
                                    minLines: 1,
                                    controller:
                                        controller.commentTextController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                      counterText: "",
                                      hintText: "댓글을 입력해주세요",
                                      hintStyle: lightStyle.copyWith(
                                        color: Palette.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Palette.lightGrey,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Palette.lightGrey,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Palette.lightGrey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () async {
                                          await controller.writeGeneralComment(
                                              controller.generalPost.value.id);
                                        },
                                        icon: Image.asset(
                                          'assets/icons/post/send_selected.png',
                                          width: 24,
                                          height: 24,
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
                    ),
                  )
                ],
              )
            : const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  void generalCommentPopup(GeneralPostModel generalPostModel,
      GeneralCommentModel generalCommentModel) {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  '신고하기',
                  style: TextStyle(
                    color: Palette.lightRed,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              generalCommentModel.mine
                  ? CupertinoActionSheetAction(
                      child: const Text(
                        '삭제하기',
                      ),
                      onPressed: () {
                        Get.dialog(
                          CupertinoAlertDialog(
                            title: const Text('댓글 삭제'),
                            content: const Text('댓글을 삭제하시겠습니까?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('취소'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('확인'),
                                onPressed: () async {
                                  await controller.deleteGeneralComment(
                                      generalPostModel.id,
                                      generalCommentModel.id);
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ).then((value) => Get.back());
                      },
                    )
                  : const SizedBox(),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
          );
        });
  }

  void generalPostPopup(GeneralPostModel generalPostModel) {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  '신고하기',
                  style: TextStyle(
                    color: Palette.lightRed,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              generalPostModel.mine
                  ? CupertinoActionSheetAction(
                      child: const Text(
                        '삭제하기',
                      ),
                      onPressed: () {
                        Get.dialog(
                          CupertinoAlertDialog(
                            title: const Text('게시글 삭제'),
                            content: const Text('게시글을 삭제하시겠습니까?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('취소'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('확인'),
                                onPressed: () async {
                                  Get.back();
                                  await controller
                                      .deleteGeneralPost(generalPostModel.id);
                                },
                              ),
                            ],
                          ),
                        ).then((value) => Get.back());
                      },
                    )
                  : const SizedBox(),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
          );
        });
  }
}
