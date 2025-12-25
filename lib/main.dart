
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/app_colors.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/route_management.dart';
import 'package:tarjuman_e_sindh_admin/utils/screen_bindings.dart';

import 'firebase_options.dart';


void main() async {

  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          details.summary.name??'',
          style: TextStyle(
            fontSize: 16,
            color: kTextColor.withAlpha(200),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${details.summary.value}',
          style: TextStyle(
            fontSize: 14,
            color: kTextColor.withAlpha(200),
          ),
        ),
      ],
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor:
            data.textScaleFactor > 1.2 ? 1.2 : data.textScaleFactor*1.05,
          ),
          child: child!,
        );
      },
      title: kAppName,
      initialRoute: kSplashScreenRoute,
      initialBinding: ScreensBindings(),
      getPages: RouteManagement.getPages(),
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
    );
  }
}


