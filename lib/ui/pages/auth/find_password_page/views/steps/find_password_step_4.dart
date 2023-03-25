import 'package:danvery/ui/pages/auth/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../utils/regex/regex.dart';
import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class FindPasswordStep4 extends GetView<FindPasswordPageController> {
  const FindPasswordStep4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 16,),
          ModernFormButton(
            text: "로그인하러 가기",
            onPressed: () {
              Get.back();
              Get.delete<FindPasswordPageController>();
            },
          ),
        ],
      ),
    );
  }
}