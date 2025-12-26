import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/custom_widget_controllers/custom_bottom_nav_bar_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/dashboard_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/epaper_list_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/forgot_password_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/login_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/news_detail_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/news_list_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/upload_epaper_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/upload_news_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/controllers/view_profile_screen_controller.dart';
import '../controllers/splash_screen_controller.dart';



class ScreensBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => DashboardScreenController());
    Get.lazyPut(() => ForgotPasswordScreenController());
    Get.lazyPut(() => UploadNewsScreenController());
    Get.lazyPut(() => NewsListScreenController());
    Get.lazyPut(() => NewsDetailScreenController());
    Get.lazyPut(() => ViewProfileScreenController());
    Get.lazyPut(() => CustomBottomNavBarController());
    Get.lazyPut(() => EPaperListScreenController());
    Get.lazyPut(() => UploadEPaperScreenController());
  }

}
