import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/app_colors.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import '../../controllers/splash_screen_controller.dart';


class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
        child: GestureDetector(
          onTap: controller.onScreenTap,
          child: Scaffold(
            key: controller.scaffoldKey,
            body: Container(
              width: Get.width,
              height: Get.height,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  kPrimaryLightColor, kPrimaryDarkColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/app-icon.png', width: 160,),
                  Text(kAppFullName, style: TextStyle(color: kWhiteColor, fontFamily: kFontFamilyUrdu, fontWeight: FontWeight.bold, fontSize: 24),),
                ],
              ),
            ),
          ),
        ));
  }
}
