import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import 'constants.dart';

class UserSession {

  static final RxBool isDataChanged = RxBool(false);
  static final Rx<UserModel> userModel = UserModel.empty().obs;
  // static Rx<Offset> backButtonPosition = Offset(12, Get.height*0.8).obs;
  static RxInt backButtonTransparency = (0xCC).obs;
  static const String keyAllDataSynced = "AllDataSynced";
  static const String keyInspectionAppointments = "GetInspectionAppointments";
  static const String keyAllCreatedInspections = "GetCreatedInspections";
  static const String keyAllAppointments = "GetAllAppointments";
  static const String keyAllFitnessCertificates = "GetAllCertificates";
  static const String keyCheckList = "GetChecklist";

  static final UserSession _instance = UserSession._internal();
  UserSession._internal();
  factory UserSession() {
    return _instance;
  }

  Future<bool> createSession({required UserModel user}) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    userModel.value = user;
    await storage.write(key: 'USER_DATA', value: jsonEncode(userModel.value.toOfflineJson()));
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    final value = await storage.read(key: 'USER_DATA');
    userModel.value = UserModel.fromOfflineJson(jsonDecode(value ?? "{}"));
    return userModel.value.email.isNotEmpty && userModel.value.isRemembered;
  }

  Future<bool> logoutSession() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    // await storage.delete(key: 'FINGER_PRINT_AUTH');
    // await storage.delete(key: 'FACE_ID_AUTH');
    // if (await UserSession().getFingerPrintAuth()) {
    //   userModel.value.isRemembered = false;
    //   await createSession(user: userModel.value);
    // } else {
      await storage.delete(key: 'USER_DATA');
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'csrf_token');
      await storage.delete(key: 'auth_token');
      await storage.delete(key: 'cookie');
      userModel.value = UserModel.empty();
    // }

    Get.offAllNamed(kLoginScreenRoute);
    return true;
  }


  Future<bool> checkDefaultCameraEnabled() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    final value = await storage.read(key: 'UseDefaultCamera');
    return value == 'true';
  }

  Future<void> enableDefaultCamera(bool value) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    await storage.write(key: 'UseDefaultCamera',value: value.toString());
  }


}
