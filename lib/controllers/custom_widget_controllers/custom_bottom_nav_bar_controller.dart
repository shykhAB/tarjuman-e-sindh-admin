import 'dart:async';
import 'package:get/get.dart';
import '../../utils/constants.dart';

class CustomBottomNavBarController extends GetxController{
  static RxInt selectedIndex=0.obs;

  Future<void> onItemSelect(int index) async {
    selectedIndex.value = index;
    if(selectedIndex.value == 0){
      if(Get.currentRoute != kNewsListScreenRoute) {
        Get.offAllNamed(kNewsListScreenRoute, predicate: (r)=>r.isFirst);
      }
    }
    else if(selectedIndex.value == 1){
      if(Get.currentRoute != kEPaperListScreenRoute) {
        Get.offAllNamed(kEPaperListScreenRoute, predicate: (r)=>r.isFirst);
      }
    }
  }
}