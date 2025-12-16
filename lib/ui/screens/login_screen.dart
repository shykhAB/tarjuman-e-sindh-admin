import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/login_screen_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/text_field_manager.dart';
import '../../utils/text_filter.dart';
import '../custom_widgets/general_button.dart';
import '../custom_widgets/general_text_field.dart';


class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.removeFocus,
      child: Scaffold(key: controller.scaffoldKey,
        backgroundColor: kWhiteColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(child: _getBody()),
        extendBody: true,
      ),
    );
  }

  Widget _getBody(){
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimaryDarkColor, kPrimaryLightColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120,),
              Image.asset('assets/images/app-icon.png', width: 130,),
              Container(
                padding: EdgeInsets.only(top: Get.height * 0.02),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Welcome,\n",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                        children:  [
                          TextSpan(
                              text: "Glad to see you!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 28
                              )
                          )
                        ]
                    )),
              ),
              // SizedBox(height: Get.height * 0.05,),
              const SizedBox(height: 5),
              // GeneralTextField(tfManager: controller.usernameTFMController,
              //   suffixIcon: Icons.mail_outline, labelFont: 20,
              // ),
              _buildGradientTextField(controller.usernameTFMController, icon: Icons.person_outline),
              const SizedBox(height: 5),
              _buildGradientTextField(controller.passwordTFMController, icon: Icons.key_outlined),

              // GeneralTextField(tfManager: controller.passwordTFMController, labelFont: 20,),
              Row(
                children: [
                  Obx(()=> SizedBox(
                    width: 45,
                    child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        trackColor: kGreyColor,
                        activeColor: kButtonColor,
                        value: controller.rememberMe.value,
                        onChanged: (_) => controller.rememberMe.toggle(),
                      ),
                    ),
                  )),
                  const Text('Stay Signed In',style: TextStyle(fontSize: 14,color: kWhiteColor,fontWeight: FontWeight.w400),),
                  const Spacer(),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(kForgetPasswordScreenRoute);
                      },
                      child: const Text('Forgot Password?',style: TextStyle(fontSize: 14,color: kWhiteColor, letterSpacing:0, decorationColor: kWhiteColor, decoration: TextDecoration.underline, ))),
                ],
              ),
              GeneralButton(onPressed: (){Get.toNamed(kDashboardScreenRoute);})
            ],
          ),
        ),
      ),
    );

  }

  Widget _buildGradientTextField(TextFieldManager tfm, {IconData? icon}) {
    RxBool obscureText = RxBool(true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: tfm.fieldName,
            style: const TextStyle(
              color: Color(0xFF8b92a8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: const [TextSpan(text: ' *', style: TextStyle(color: Colors.red),),],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [kCardShadowColor, kPrimaryDarkColor,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kButtonColor.withAlpha(120), width: 1,),
          ),
          child: Obx(
                () => TextField(
              controller: tfm.controller,
              obscureText: obscureText.value && tfm.filter == TextFilter.password,
              focusNode: tfm.focusNode,
              keyboardType: tfm.filter == TextFilter.email ? TextInputType.emailAddress : TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
              onChanged: (_) => tfm.validate(),
              style: const TextStyle(color: kWhiteColor, fontSize: 14,),
              decoration: InputDecoration(
                hintText: tfm.hint,
                hintStyle: TextStyle(color: kGreyColor, fontSize: 14,),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14,),
                border: InputBorder.none,
                prefixIcon: icon != null
                    ? Icon(icon, color: const Color(0xFF6b7280), size: 20,) : null,
                suffixIcon: tfm.filter == TextFilter.password
                    ? IconButton(onPressed: () => obscureText.toggle(),
                  icon: Icon(obscureText.value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                    color: kGreyColor,
                    size: 20,
                  ),
                ) : null,
              ),
            ),
          ),
        ),
        Obx(
              () => Visibility(
            visible: tfm.errorMessage.value.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(tfm.errorMessage.value, style: const TextStyle(color: Colors.red, fontSize: 12),),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

}