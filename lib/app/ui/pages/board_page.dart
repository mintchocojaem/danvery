import 'package:danvery/app/data/dto/board_list_dto.dart';
import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/widgets/board_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardPage extends GetView {
  const BoardPage({super.key});

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
                )),
          ),
          const SizedBox(height: 16,),
          BoardList(
            data: [
              BoardListDTO(
                  title: "자유 게시판", leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "취업 / 진로 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "졸업생 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "새내기 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "비밀 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "꿀팁 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
            ],
            title: '자유 게시판',
            showAction: false,
          ),
          const SizedBox(
            height: 16,
          ),
          BoardList(
            data: [
              BoardListDTO(
                  title: "시설 게시판", leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "학교생활 게시판",
                  leadingImage: Icon(Icons.push_pin_outlined)),
              BoardListDTO(
                  title: "기타 게시판", leadingImage: Icon(Icons.push_pin_outlined)),
            ],
            title: '청원 게시판',
            showAction: false,
          ),
          const SizedBox(
            height: 16,
          ),
          BoardList(
            data: [
              BoardListDTO(
                  title: "단냥펀치 게시판",
                  leadingImage: Icon(Icons.star_border_outlined)),
              BoardListDTO(
                  title: "동아리 게시판",
                  leadingImage: Icon(Icons.star_border_outlined)),
              BoardListDTO(
                  title: "새내기 게시판",
                  leadingImage: Icon(Icons.star_border_outlined)),
            ],
            title: '즐겨찾기',
            showAction: false,
          ),
        ]),
      ),
    );
  }
}
