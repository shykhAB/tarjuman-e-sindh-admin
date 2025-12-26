import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/upload_epaper_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_browse_image_widget.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/general_button.dart';
import 'package:tarjuman_e_sindh_admin/utils/app_colors.dart';


class UploadEPaperScreen extends GetView<UploadEPaperScreenController> {
  const UploadEPaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "Upload E-Paper",
        scaffoldKey: controller.scaffoldKey,
        body: _body());
  }

  Widget _body(){
    return Column(
      children: [
        SizedBox(height: 20,),
        // GeneralDatePickerField(dateManager: controller.date,),
        CustomBrowseImageWidget(controller: controller.image1Controller, withBrows: true,),
        GeneralButton(onPressed: ()=>controller.ePaperModel.isEmpty?controller.onSubmitPressed() : controller.onUpdatePressed(), color: kPrimaryDarkColor, secondColor: kPrimaryLightColor,
          text: controller.ePaperModel.isEmpty?"Submit" : "Update",


        ),
      ],
    );
  }
}
