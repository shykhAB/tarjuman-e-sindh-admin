
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/text_field_manager.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';
import '../../models/user_model.dart';
import '../../ui/custom_widgets/custom_dialogs.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_code.dart';
import '../services/users_services.dart';
import '../ui/custom_widgets/custom_progress_dialog.dart';
import '../utils/text_filter.dart';

class ViewProfileScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextFieldManager nameTFM = TextFieldManager("Name");
  TextFieldManager emailTFM = TextFieldManager("Email", filter: TextFilter.email);
  TextFieldManager contactTFM = TextFieldManager("Contact No", filter: TextFilter.mobile);
  TextFieldManager cnicTFM = TextFieldManager("CNIC", filter: TextFilter.cnic);
  TextFieldManager cityTFM = TextFieldManager("City", filter: TextFilter.name, mandatory: true);


  @override
  Future<void> onInit() async {
    super.onInit();
    emailTFM.controller.text = UserSession.userId.value;
  }

  void removeFocus(){
    nameTFM.removeFocus;
    emailTFM.removeFocus;
    contactTFM.removeFocus;
    cnicTFM.removeFocus;
    cityTFM.removeFocus;
  }

  bool validateData(){
    return emailTFM.validate() & contactTFM.validate() & cnicTFM.validate() & cityTFM.validate() & nameTFM.validate();
  }

  Future<void> onCreateProfile() async {
    bool checkInternet = await CommonCode().checkInternetConnection();
    ProgressDialog pd = ProgressDialog();
    if(validateData()){
      if(checkInternet){
        pd.showDialog();
        UserModel userModel = UserModel.empty();
        userModel.email = emailTFM.text;
        userModel.id = emailTFM.text;
        userModel.contact = contactTFM.text;
        userModel.city = cityTFM.text;
        userModel.cnic = cnicTFM.text;
        userModel.name = nameTFM.text;
        String response = await UserServices().registerUser(userModel);
        if(response == "OK"){
          pd.dismissDialog();
          UserSession().createSession(user: userModel);
          UserSession().setIsProfileCreated(true);
          CustomDialogs().showErrorDialog("Success", "Profile Created Successfully", DialogType.success, kGreenColor, onOkBtnPressed: ()=> Get.offAllNamed(kDashboardScreenRoute));
        }else if (response == "OTHER") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", kErrorMessage, DialogType.error, kRequiredRedColor);
        }
      } else {
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Alert", kNoInternetMsg, DialogType.error, kRequiredRedColor);
      }
    }
  }



}