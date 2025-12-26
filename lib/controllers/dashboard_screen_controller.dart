import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/models/weekly_graph_model.dart';

import '../services/news_service.dart';
import '../utils/common_code.dart';


class DashboardScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = RxBool(false);

  RxList<WeeklyGraphModel> weeklyData = RxList();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getWeeklyInspectionsData();
  }

  Future<void> getWeeklyInspectionsData() async {
    isLoading.value = true;
    if(await CommonCode().checkInternetConnection()){
      weeklyData.value = await NewsServices().getCounts();
    }
    isLoading.value = false;
  }

}