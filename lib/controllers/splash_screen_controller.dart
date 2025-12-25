import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/services/users_services.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/user_session.dart';



class SplashScreenController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late Timer _timer;

  @override
  void onInit() {
    _timer = Timer(const Duration(seconds: 5), () {
      _screenNavigation();
    });
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _screenNavigation() async {
    if(await UserSession().getIsRemember()){
      await UserSession().getUserId();
      await UserSession().isUserLoggedIn();
      if(await UserSession().getIsProfileCreated()){
        Get.offAllNamed(kDashboardScreenRoute);
      }else{
        dynamic user = await UserServices().getUser(UserSession.userId.value);
        if (user is Map<String, dynamic> && user.isNotEmpty) {
          UserModel userModel = UserModel.fromJson(user);
          UserSession().createSession(user: userModel);
          UserSession().setIsProfileCreated(true);
          Get.offAllNamed(kDashboardScreenRoute);
        }else{
          Get.offAllNamed(kProfileScreenRoute);
        }
      }
    } else {
      Get.offAllNamed(kLoginScreenRoute);
    }
  }

  void onScreenTap() {
    _timer.cancel();
    _screenNavigation();
  }

}
