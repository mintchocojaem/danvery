import 'package:danvery/ui/pages/user/find_password_page/controller/find_password_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class FindPasswordStep2 extends GetView<FindPasswordPageController> {
  const FindPasswordStep2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("발송된 인증번호를 입력해주세요", style: regularStyle.copyWith(color: Palette.darkGrey)),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: PinCodeTextField(
              textStyle: titleStyle.copyWith(
                color: Palette.darkGrey,
              ),
              autoFocus: true,
              appContext: context,
              showCursor: false,
              length: 6,
              obscureText: false,
              animationType: AnimationType.none,
              pinTheme: PinTheme(
                borderWidth: 1,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 48,
                fieldWidth: 36,
                activeFillColor: Palette.darkWhite,
                inactiveFillColor: Palette.darkWhite,
                activeColor: Palette.blue,
                inactiveColor: Palette.blue,
                selectedColor: Palette.blue,
                selectedFillColor: Palette.darkWhite,
              ),
              animationDuration: const Duration(milliseconds: 0),
              backgroundColor: Palette.transparent,
              enableActiveFill: true,
              //errorAnimationController: controller.errorController,
              //controller: controller.textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                controller.phoneAuthCode.value = value;
              },
            ),
          ),
          const SizedBox(height: 16),
          ModernFormButton(
            text: "확인",
            onPressed: () async{
              if (await controller.verifyAuthCode()){
                controller.currentStep.value = 3;
                FocusManager.instance.primaryFocus?.unfocus();
              }else{
                Get.snackbar("인증번호 오류", "인증번호가 일치하지 않습니다",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Palette.darkGrey,
                    colorText: Palette.pureWhite);
              }
            },
          ),
        ],
      ),
    );
  }
}
