import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/custom_widget_controllers/dropdown_controller.dart';
import 'package:tarjuman_e_sindh_admin/utils/browse_image_controller.dart';
import 'package:tarjuman_e_sindh_admin/utils/dummy_data.dart';
import 'package:tarjuman_e_sindh_admin/utils/text_field_manager.dart';

class UploadNewsScreenController extends GetxController{
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextFieldManager headingTFM = TextFieldManager("Heading", length: 100);
  TextFieldManager detailTFM = TextFieldManager("Detail", length: 2000);
  DropdownController categoryDDC = DropdownController(title: "Category", items: RxList(DummyData.getNewsCategories));
  BrowseImageController imageController = BrowseImageController(title: "Image", minLength: 1, maxLength: 1);



  void removeFocus(){
    headingTFM.removeFocus;
    detailTFM.removeFocus;
  }
}