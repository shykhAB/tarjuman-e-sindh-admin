import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/custom_widget_controllers/dropdown_controller.dart';
import 'package:tarjuman_e_sindh_admin/models/news_model.dart';
import 'package:tarjuman_e_sindh_admin/services/news_service.dart';
import 'package:tarjuman_e_sindh_admin/utils/browse_image_controller.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/date_time_manager.dart';
import 'package:tarjuman_e_sindh_admin/utils/dummy_data.dart';
import 'package:tarjuman_e_sindh_admin/utils/text_field_manager.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';
import '../ui/custom_widgets/custom_dialogs.dart';
import '../ui/custom_widgets/custom_progress_dialog.dart';
import '../utils/app_colors.dart';
import '../utils/common_code.dart';

class UploadNewsScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextFieldManager headingTFM = TextFieldManager("Heading", length: 100);
  TextFieldManager detailTFM = TextFieldManager("Detail", length: 2000);
  DropdownController categoryDDC = DropdownController(title: "Category", items: RxList(DummyData.getNewsCategories));
  BrowseImageController imageController = BrowseImageController(title: "Image", minLength: 1, maxLength: 1, mandatory: false);
  DateTimeManager date = DateTimeManager("News Date", firstDate: DateTime(DateTime.now().year - 75, DateTime.now().month, DateTime.now().day),lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), mandatory: false);
  NewsModel newsModel = NewsModel.empty();

  @override
  void onInit(){
    super.onInit();
    if(Get.arguments !=null && Get.arguments is NewsModel){
      newsModel = Get.arguments ?? NewsModel.empty();
      populateData();
    }
  }

  void populateData(){
    headingTFM.controller.text = newsModel.heading;
    detailTFM.controller.text = newsModel.detail;
    categoryDDC.selectedItem.value = newsModel.category;
    imageController.urls.add(newsModel.image);
  }

  void removeFocus(){
    headingTFM.removeFocus;
    detailTFM.removeFocus;
  }

  bool validateData(){
    return headingTFM.validate() & detailTFM.validate() & categoryDDC.validate() & imageController.validate();
  }


  Future<void> onSubmitPressed() async {
    if (validateData()) {
      ProgressDialog pd = ProgressDialog();
      bool checkInternet = await CommonCode().checkInternetConnection();
      if (checkInternet) {
        pd.showDialog();
        NewsModel news = NewsModel.empty();
        news.heading = headingTFM.text;
        news.detail = detailTFM.text;
        news.category = categoryDDC.selectedItem.value;
        news.createdAt = DateTime.now().toString();
        news.createdBy = UserSession.userId.value;
        news.createdByName = UserSession.userModel.value.name;
        news.image = imageController.urls.first;
        String response = await NewsServices().addNews(news);
      if (response == "OK") {
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Success", "News Uploaded Successfully", DialogType.success, kGreenColor, onOkBtnPressed: () {
          Get.back(result: "true");
        });
      } else if (response == "ALREADY_EXISTS") {
        pd.dismissDialog();
        CustomDialogs().showErrorDialog("Alert", "News Already Exists", DialogType.error, kRequiredRedColor);
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
        NewsModel news = NewsModel.empty();
        news.id = newsModel.id;
        news.heading = headingTFM.text;
        news.detail = detailTFM.text;
        news.category = categoryDDC.selectedItem.value;
        news.createdAt = newsModel.createdAt;
        news.createdBy = UserSession.userId.value;
        news.createdByName = UserSession.userModel.value.name;
        news.image = imageController.urls.first;
        String response = await NewsServices().updateNews(news);
        if (response == "OK") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Success", "News Uploaded Successfully", DialogType.success, kGreenColor, onOkBtnPressed: () {
            Get.back(result: "true");
          });
        } else if (response == "ALREADY_EXISTS") {
          pd.dismissDialog();
          CustomDialogs().showErrorDialog("Alert", "News Already Exists", DialogType.error, kRequiredRedColor);
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