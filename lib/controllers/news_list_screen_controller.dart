import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/services/news_service.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';

import '../models/news_model.dart';
import '../ui/custom_widgets/custom_dialogs.dart';
import '../utils/app_colors.dart';
import '../utils/common_code.dart';

class NewsListScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<NewsModel> newsList = RxList();
  RxBool isLoading = RxBool(false);

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    newsList.value = await NewsServices().getAllNews();
    isLoading.value = false;
  }

  void deleteNews({required String id})async{
    isLoading.value = true;
    bool checkInternet = await CommonCode().checkInternetConnection();
    if(checkInternet){
      String response =await NewsServices().deleteNews(id: id);
      if(response == "OK"){
        isLoading.value = false;
        onInit();
      }else{
        isLoading.value = false;
        CustomDialogs().showErrorDialog("Alert", kErrorMessage, DialogType.error, kRequiredRedColor);
      }
    }else{
      isLoading.value = false;
      CustomDialogs().showErrorDialog("Alert", kNoInternetMsg, DialogType.error, kRequiredRedColor);
    }
  }

}