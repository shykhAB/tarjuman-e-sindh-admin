import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/dashboard_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/forgot_password_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/login_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/upload_news_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/login_screen.dart';

import '../controllers/splash_screen_controller.dart';



class ScreensBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => DashboardScreenController());
    Get.lazyPut(() => ForgotPasswordScreenController());
    Get.lazyPut(() => UploadNewsScreenController());
  }

}
