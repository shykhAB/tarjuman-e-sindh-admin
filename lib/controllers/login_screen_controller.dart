import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';
import '../services/users_services.dart';
import '../ui/custom_widgets/custom_dialogs.dart';
import '../ui/custom_widgets/custom_progress_dialog.dart';
import '../utils/app_colors.dart';
import '../utils/common_code.dart';
import '../utils/text_field_manager.dart';
import '../utils/text_filter.dart';
import '../utils/user_session.dart';

class LoginScreenController extends GetxController{

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldManager usernameTFMController = TextFieldManager('Email',hint:'Email Address' ,filter: TextFilter.email);
  TextFieldManager passwordTFMController = TextFieldManager('Password',hint: 'Password', filter: TextFilter.password);
  RxBool rememberMe = true.obs,obscurePassword = true.obs;


  void onSingInBtnPressed() async {
    if (validateUser()) {
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      LoginModel loginModel = LoginModel.empty();
      loginModel.email = usernameTFMController.text;
      loginModel.password = passwordTFMController.text;
      bool checkInternet = await CommonCode().checkInternetConnection();
      if(checkInternet){
        String response = await UserServices().loginUser(loginModel);
        if (response == "OK") {
          dynamic user = await UserServices().getUser(usernameTFMController.text);
          if (user is Map<String, dynamic>) {
            pd.dismissDialog();
            UserModel userModel = UserModel.fromJson(user);
            await UserServices().updateUser(userModel);
            userModel.isRemembered = rememberMe.value;
            UserSession().createSession(user: userModel);
            // Get.offAllNamed(kDashboardScreenRoute);
        }else{
            pd.dismissDialog();CustomDialogs().showErrorDialog("Alert", "Services Are Currently Unavailable, Please try again later!", DialogType.error, kRequiredRedColor);
        }
      }else if(response == "user-not-found") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "User Not Found!", DialogType.error, kRequiredRedColor);
        }else if(response == "wrong-password") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "Password is incorrect!", DialogType.error, kRequiredRedColor);
        }else if(response == "invalid-login-credentials") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "Invalid Email/Password!", DialogType.error, kRequiredRedColor);
        }else if(response == "OTHER") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "Something went wrong. Try Again!", DialogType.error, kRequiredRedColor);
        }
      }else{
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Alert", "No Internet is available!", DialogType.error, kRequiredRedColor);
      }
    }

  }

  void removeFocus(){
    if(usernameTFMController.focusNode.hasFocus){
      usernameTFMController.focusNode.unfocus();
    }
    if(passwordTFMController.focusNode.hasFocus){
      passwordTFMController.focusNode.unfocus();
    }

  }

  bool validateUser(){
    return usernameTFMController.validate() & passwordTFMController.validate();
  }

  void clearFields() {
    usernameTFMController.controller.clear();
    passwordTFMController.controller.clear();
    usernameTFMController.errorMessage.value = '';
    passwordTFMController.errorMessage.value = '';
  }
}