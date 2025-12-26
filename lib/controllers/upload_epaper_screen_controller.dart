import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/models/epaper_model.dart';
import 'package:tarjuman_e_sindh_admin/models/news_model.dart';
import 'package:tarjuman_e_sindh_admin/services/news_service.dart';
import 'package:tarjuman_e_sindh_admin/utils/browse_image_controller.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';
import '../ui/custom_widgets/custom_dialogs.dart';
import '../ui/custom_widgets/custom_progress_dialog.dart';
import '../utils/app_colors.dart';
import '../utils/common_code.dart';

class UploadEPaperScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   BrowseImageController image1Controller = BrowseImageController(title: "Page 1", minLength: 1, maxLength: 1);
   BrowseImageController image2Controller = BrowseImageController(title: "Page 2", minLength: 1, maxLength: 1);
   BrowseImageController image3Controller = BrowseImageController(title: "Page 3", minLength: 1, maxLength: 1);
   BrowseImageController image4Controller = BrowseImageController(title: "Page 4", minLength: 1, maxLength: 1);
   BrowseImageController image5Controller = BrowseImageController(title: "Page 5", minLength: 1, maxLength: 1);
   BrowseImageController image6Controller = BrowseImageController(title: "Page 6", minLength: 1, maxLength: 1);
   EPaperModel ePaperModel = EPaperModel.empty();

  @override
  void onInit(){
    super.onInit();
    if(Get.arguments !=null && Get.arguments is EPaperModel){
      ePaperModel = Get.arguments ?? EPaperModel.empty();
      populateData();
    }
  }

  void populateData(){
    // imageController.urls.add(newsModel.image);
  }


  bool validateData(){
    return image1Controller.validate() & image2Controller.validate() & image3Controller.validate() &
    image4Controller.validate() & image5Controller.validate() & image6Controller.validate();
  }


  Future<void> onSubmitPressed() async {
    if (validateData()) {
      ProgressDialog pd = ProgressDialog();
      bool checkInternet = await CommonCode().checkInternetConnection();
      if (checkInternet) {
        pd.showDialog();
        EPaperModel paper = EPaperModel.empty();
        paper.createdAt = DateTime.now().toString();
        paper.createdBy = UserSession.userId.value;
        paper.createdByName = UserSession.userModel.value.name;
        paper.image = image1Controller.urls.first;
        String response = await NewsServices().addNews(NewsModel.empty());
        if (response == "OK") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Success", "E-Paper Uploaded Successfully", DialogType.success, kGreenColor, onOkBtnPressed: () {
            Get.back(result: "true");
          });
        } else if (response == "ALREADY_EXISTS") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "E-Paper Already Exists", DialogType.error, kRequiredRedColor);
        } else if (response == "OTHER") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", kErrorMessage, DialogType.error, kRequiredRedColor);
        }
      } else {
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Alert", kNoInternetMsg, DialogType.error, kRequiredRedColor);
      }
    }
  }

  Future<void> onUpdatePressed() async {
    if (validateData()) {
      ProgressDialog pd = ProgressDialog();
      bool checkInternet = await CommonCode().checkInternetConnection();
      if (checkInternet) {
        pd.showDialog();
        EPaperModel paper = EPaperModel.empty();
        paper.id = ePaperModel.id;
        paper.createdAt = ePaperModel.createdAt;
        paper.createdBy = UserSession.userId.value;
        paper.createdByName = UserSession.userModel.value.name;
        paper.image = image1Controller.urls.first;
        String response = await NewsServices().updateNews(NewsModel.empty());
        if (response == "OK") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Success", "E-Paper Uploaded Successfully", DialogType.success, kGreenColor, onOkBtnPressed: () {
            Get.back(result: "true");
          });
        } else if (response == "ALREADY_EXISTS") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "E-Paper Already Exists", DialogType.error, kRequiredRedColor);
        } else if (response == "OTHER") {
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