

import 'package:google_fonts/google_fonts.dart';

const String kAppName = "ترجمانِ سنڌ";
const String kAppFullName = "سچائي سان سنڌ جو ترجمان";

String kFontFamilySindhi = GoogleFonts.notoNaskhArabic().fontFamily ?? "";
String kFontFamilyUrdu = GoogleFonts.notoNastaliqUrdu().fontFamily ?? "";

///*********************  Route Names   *********************/

//User Routes
const String kForgetPasswordScreenRoute = "/FORGOT_PASSWORD_SCREEN";
const String kSplashScreenRoute = "/";
const String kLoginScreenRoute = "/LOGIN_SCREEN";
const String kDashboardScreenRoute = "/DASHBOARD_SCREEN";
const String kSettingScreenRoute = "/SETTING_SCREEN";
const String kUploadNewsScreenRoute = "/UPLOAD_NEWS_SCREEN";
const String kNewsListScreenRoute = "/NEWS_LIST_SCREEN";
const String kNewsDetailScreenRoute = "/NEWS_DETAIL_SCREEN";
const String kProfileScreenRoute = "/PROFILE_SCREEN";


///*********************  Firebase Collections   *********************///
const String kUserCollection = "users";
const String kNewsCollection = "news";



///*********************  User Messages   *********************///
const String kPermissionPermanentlyDenied =  "Permission is Permanently Denied\nPlease allow permission from settings and try again.";
const String kStoragePermissionDenied = "Allow Storage Permission to Save photos.";
const String kStoragePermissionDeniedForCamera = "Allow Storage Permission to Select photos.";
const String kCameraPermissionDenied = "Allow Camera Permission to Capture photos.";
const String kManageStoragePermissionDenied = "Allow Manage Storage Permission to Save photos.";
const String kPermissionDenied = "Permission Denied";
// const String kNoInternetMsg = 'No Internet Connection!';
const String kNoInternetMsg = 'Please Check Your Internet!';
const String kInternetDisconnectMsg = 'Your internet connection was lost. Sync will pause.';
const String kPoorInternetConnection = "Poor network connection detected. Please check your internet connection!";
const String kNetworkError = "Network Error. Please change your internet connection!";
// const String kServiceError = "Service Currently Unavailable, Our technical team is working on it. Please try again later.";
const String kServiceError = "Could not Connect with Server.\nPlease try later.";
const String kErrorMessage = "Something went wrong, Please try again later.";
const String kCnicFrontErrorMsg = "CNIC Front Image is required!";
const String kCnicBackErrorMsg = "CNIC Back Image is required!";
const String kSessionExpireMsg = 'Session Expired\nPlease login Again.';




const double kFieldRadius = 25;
const double kFieldVerticalMargin = 4;
const int kScreenListingDataLimit = 10;
