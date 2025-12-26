import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/dashboard_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/epaper_list_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/forgot_password_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/login_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/news_detail_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/news_list_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/upload_epaper_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/upload_news_screen.dart';
import 'package:tarjuman_e_sindh_admin/ui/screens/view_profile_screen.dart';
import 'package:tarjuman_e_sindh_admin/utils/screen_bindings.dart';

import '../ui/screens/splash_screen.dart';
import 'constants.dart';


class RouteManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: kSplashScreenRoute,
        page: () => const SplashScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kLoginScreenRoute,
        page: () => const LoginScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kForgetPasswordScreenRoute,
        page: () => const ForgotPasswordScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kDashboardScreenRoute,
        page: () => const DashboardScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kUploadNewsScreenRoute,
        page: () => const UploadNewsScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kNewsListScreenRoute,
        page: () => const NewsListScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kNewsDetailScreenRoute,
        page: () => const NewsDetailScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kProfileScreenRoute,
        page: () => const ViewProfileScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kEPaperListScreenRoute,
        page: () => const EPaperListScreen(),
        binding: ScreensBindings(),
      ),
      GetPage(
        name: kUploadEPaperScreenRoute,
        page: () => const UploadEPaperScreen(),
        binding: ScreensBindings(),
      ),
    ];
  }
}
