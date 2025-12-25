import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/upload_news_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_browse_image_widget.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/general_button.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/general_dropdown.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/general_text_field.dart';
import 'package:tarjuman_e_sindh_admin/utils/app_colors.dart';

import '../custom_widgets/general_date_picker_field.dart';

class UploadNewsScreen extends GetView<UploadNewsScreenController> {
  const UploadNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "Upload News",
        scaffoldKey: controller.scaffoldKey,
        gestureDetectorOnTap: controller.removeFocus,
        body: _body());
  }

  Widget _body(){
    return Column(
      children: [
        SizedBox(height: 20,),
        GeneralTextField(tfManager: controller.headingTFM),
        GeneralTextField(tfManager: controller.detailTFM, maxLines: 20,),
        GeneralDropdown(controller: controller.categoryDDC),
        // GeneralDatePickerField(dateManager: controller.date,),
        CustomBrowseImageWidget(controller: controller.imageController, withBrows: true,),
        GeneralButton(onPressed: ()=>controller.newsModel.isEmpty?controller.onSubmitPressed() : controller.onUpdatePressed(), color: kPrimaryDarkColor, secondColor: kPrimaryLightColor,
          text: controller.newsModel.isEmpty?"Submit" : "Update",


        ),
      ],
    );
  }
}
