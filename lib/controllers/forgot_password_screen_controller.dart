import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import '../models/response_model.dart';
import '../services/forgot_password_service.dart';
import '../ui/custom_widgets/custom_dialogs.dart';
import '../ui/custom_widgets/custom_progress_dialog.dart';
import '../utils/app_colors.dart';
import '../utils/common_code.dart';
import '../utils/text_field_manager.dart';
import '../utils/text_filter.dart';

class ForgotPasswordScreenController extends GetxController{

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextFieldManager email = TextFieldManager("Email", filter: TextFilter.email);

  void removeFocus(){
    if(email.focusNode.hasFocus){
      email.focusNode.unfocus();
    }
  }
  bool isAllDataValid(){
    return email.validate();
  }

  void sendEmail()async{
    if(isAllDataValid()){
      ProgressDialog pd = ProgressDialog();
      pd.showDialog();
      bool checkInternet = await CommonCode().checkInternetConnection();
      if(checkInternet){
        ResponseModel response = await ForgotPasswordService().sendEmail(email: email.controller.text);
        if(response.statusDescription == "OK"){
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Success", "", DialogType.success, kGreenColor, onOkBtnPressed:()=>Get.back());
        }else if(response.statusDescription == "user-not-found"){
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "No Data Found!", DialogType.error, kRequiredRedColor);
        }else{
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", kErrorMessage, DialogType.error, kRequiredRedColor);
        }
      }else{
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Alert", kNoInternetMsg, DialogType.error, kRequiredRedColor);
      }
    }
  }

}