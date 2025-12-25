import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/general_button.dart';
import '../../controllers/view_profile_screen_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_field_manager.dart';
import '../custom_widgets/custom_dialogs.dart';


class ViewProfileScreen extends GetView<ViewProfileScreenController> {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        CustomDialogs().showAwesomeConfirmationDialog("Are you sure you want to exit?",onOkBtnPressed: ()=>exit(0));
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: (){
          controller.removeFocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: body(),
        ),
      ),
    );
  }
  Widget body(){
    return Obx(
        ()=> SingleChildScrollView(
          child: Container(
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [kPrimaryDarkColor, kPrimaryLightColor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child: Column(
            children: [
              const SizedBox(height: 80),
              ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kLightGreyColor.withAlpha(60)
                      ),
                      child: Icon(Icons.person, size: 110, color: kLightGreyColor,))
                          ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(child: customTextField(tfm: controller.nameTFM)),
                  Expanded(child: customTextField(tfm: controller.emailTFM)),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: customTextField(tfm: controller.cnicTFM)),
                  Expanded(child: customTextField(tfm: controller.contactTFM)),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: customTextField(tfm: controller.cityTFM)),
                ],
              ),
              const SizedBox(height: 100),
              GeneralButton(onPressed: ()=>controller.onCreateProfile(), marginHorizontal: 30,)
            ],
                  ),
          ),
        ),
    );
  }

  Widget customTextField({required TextFieldManager tfm}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left :Get.width * 0.02,),
          alignment: Alignment.topLeft,
          child: Text(tfm.fieldName, style: TextStyle(
            color: kLightGreyColor,
            fontSize: 15
          )),
        ),
        Container(
          margin: EdgeInsets.only(left: Get.width * 0.03, right: Get.width * 0.03,),
          child:TextField(
            controller: tfm.controller,
            focusNode: tfm.focusNode,
            keyboardType: tfm.keyboardType,
            inputFormatters: tfm.formatters,
            readOnly: tfm.fieldName=="Email",
            style: TextStyle(color: kGreyColor),
            onChanged: (value) {
              if(tfm.customValidation!=null){
                tfm.customValidation!();
              }else{
                tfm.validate();
              }
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kLightGreyColor)
              ),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color:kLightGreyColor)
              ),
              border: const UnderlineInputBorder(
                  borderSide: BorderSide(color:kLightGreyColor)
              ),

            ),
          )
        ),
        Obx(()=> Visibility(
            visible: tfm.errorMessage.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(tfm.errorMessage.value, style: TextStyle(color: kRequiredRedColor),),
            )))
      ],
    );
  }
}
