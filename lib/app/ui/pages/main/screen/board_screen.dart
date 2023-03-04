import 'package:danvery/app/ui/pages/board/petition_board_page.dart';
import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:danvery/app/ui/widgets/board/board_list.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardScreen extends GetView {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                fillColor: brightGrey,
                filled: true,
                hintText: "게시판 검색",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.search),
                  width: 18,
                )
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          BoardList(
            cards: [
              BoardCard(
                title: "자유 게시판",
                leadingImage: Icon(Icons.push_pin_outlined),
                onTap: () {
                  Get.toNamed(Routes.generalBoard);
                },
              ),
              BoardCard(
                title: "취업 / 진로 게시판",
                leadingImage: Icon(Icons.push_pin_outlined),
                onTap: () {

                },
              ),
              BoardCard(
                title: "졸업생 게시판",
                leadingImage: Icon(Icons.push_pin_outlined),
                onTap: () {

                },
              ),
              BoardCard(
                title: "새내기 게시판",
                leadingImage: Icon(Icons.push_pin_outlined),
                onTap: () {

                },
              ),
              BoardCard(
                title: "비밀 게시판",
                leadingImage: Icon(Icons.push_pin_outlined),
                onTap: () {

                },
              ),
            ],
            title: '자유 게시판',
            showAction: false,
          ),
          const SizedBox(
            height: 16,
          ),
          BoardList(
            cards: [
              BoardCard(
                  title: "시설 게시판", leadingImage: Icon(Icons.push_pin_outlined),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PetitionBoardPage()));
                  }
              ),
              BoardCard(
                  title: "학교생활 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardCard(
                  title: "기타 게시판", leadingImage: Icon(Icons.push_pin_outlined)),
            ],
            title: '청원 게시판',
            showAction: false,
          ),
        ]),
      ),
    );
  }
}
