import 'dart:io';

import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.publishDate,
    this.thumbnailUrl,
    this.imageCount = 0,
    this.commentCount = 0,
    this.likeCount = 0,
    required this.nickname,
    this.onTap,
    this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String publishDate;
  final String? thumbnailUrl;
  final int imageCount;
  final int commentCount;
  final int likeCount;
  final String nickname;
  final VoidCallback? onTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            Image.asset("assets/icons/user/profile_icon.png")
                                .image,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nickname,
                            style: regularStyle.copyWith(
                                color: Palette.darkGrey,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            publishDate,
                            style: tinyStyle.copyWith(color: Palette.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: regularStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Palette.lightBlack),
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: regularStyle.copyWith(
                        color: Palette.darkGrey),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 12,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/post/like_unselected.png",
                                width: 14,
                                height: 14,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                likeCount.toString(),
                                style: lightStyle.copyWith(
                                    color: Palette.grey,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/post/comment_unselected.png",
                                width: 14,
                                height: 14,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                commentCount.toString(),
                                style: lightStyle.copyWith(
                                    color: Palette.grey,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            imageUrl != null
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.file(File(imageUrl!)).image,
                        fit: BoxFit.cover,
                      ),
                      color: Palette.lightGrey,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 100,
                    width: 100,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
