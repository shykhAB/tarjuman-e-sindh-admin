
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/forgot_password_screen_controller.dart';
import '../../utils/constants.dart';
import '../custom_widgets/custom_scaffold.dart';
import '../custom_widgets/general_button.dart';
import '../custom_widgets/general_text_field.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordScreenController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      className: runtimeType.toString(),
      screenName: "Reset Password",
      scaffoldKey: controller.scaffoldKey,
      gestureDetectorOnTap: controller.removeFocus,
      onBackButtonPressed: (){
        Get.offAllNamed(kLoginScreenRoute);
      },
      body: _body(),
    );
  }

  Widget _body(){
    return Column(
      children: [
        const SizedBox(height: 50,),
        GeneralTextField(tfManager: controller.email),
        const SizedBox(height: 20,),
        GeneralButton(onPressed: controller.sendEmail)
      ],

    );
  }
}
