import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import 'constants.dart';

class UserSession {

  static final RxBool isDataChanged = RxBool(false);
  static final Rx<UserModel> userModel = UserModel.empty().obs;
  static final Rx<String> userId = ''.obs;

  static final UserSession _instance = UserSession._internal();
  UserSession._internal();
  factory UserSession() {
    return _instance;
  }

  Future<bool> createSession({required UserModel user}) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    userModel.value = user;
    await storage.write(key: 'USER_DATA', value: jsonEncode(userModel.value.toJson()));
    return true;
  }

  Future<bool> isUserLoggedIn() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    final value = await storage.read(key: 'USER_DATA');
    userModel.value = UserModel.fromJson(jsonDecode(value ?? "{}"));
    return userModel.value.email.isNotEmpty;
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

  Future<bool> getIsRemember() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    final value = await storage.read(key: 'isRemember');
    return value == 'true';
  }

  Future<void> setIsRemember(bool value) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    await storage.write(key: 'isRemember',value: value.toString());
  }

  Future<String> getUserId() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    userId.value = await storage.read(key: 'userId') ?? '';
    return userId.value;
  }

  Future<void> setUserId(String value) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    userId.value = value;
    await storage.write(key: 'userId', value: userId.value);
  }

  Future<bool> getIsProfileCreated() async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
   final value = await storage.read(key: 'profile') ?? '';
    return value == 'true';
  }

  Future<void> setIsProfileCreated(bool value) async {
    const FlutterSecureStorage storage =  FlutterSecureStorage();
    await storage.write(key: 'profile',value: value.toString());
  }


}
