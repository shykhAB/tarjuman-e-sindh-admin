import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/text_field_manager.dart';

class CustomTrackTextField extends StatelessWidget {
  final TextFieldManager textFieldManager;
  final double paddingHorizontal;
  final ValueChanged<String>? onChange;
  final void Function()? onTap;
  final bool useMaterial ;
  final bool isTrackField ;
  const CustomTrackTextField({super.key, required this.textFieldManager, this.paddingHorizontal = 0, this.onChange, this.useMaterial = false, this.isTrackField =true, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isTrackField ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        if(isTrackField)
          const Text('Track Your Road Permit / MVI License / Certificate', style: TextStyle(color: kBlackColor, fontWeight: FontWeight.w500, fontSize: 11),),
        Container(
          width: Get.width,
          margin:  EdgeInsets.only(bottom: 8, top: 4, right: paddingHorizontal, left: paddingHorizontal),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: useMaterial ? 1 : 0,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(isTrackField? 10: kFieldRadius), bottomLeft: Radius.circular(isTrackField? 10: kFieldRadius),),
                  child: TextField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 120),
                    keyboardType: textFieldManager.keyboardType,
                    cursorColor: kPrimaryColor,
                    controller: textFieldManager.controller,
                    focusNode: textFieldManager.focusNode,
                    onChanged: (value){
                      textFieldManager.validate();
                      if (onChange!=null) {
                        onChange!(value);
                      }
                    },
                    maxLength: textFieldManager.length,
                    inputFormatters: textFieldManager.formatters,
                    textCapitalization: textFieldManager.textCapitalization,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: textFieldManager.hint,
                      hintStyle: TextStyle(fontSize: 13, color: kTextHintColor),
                      filled: !useMaterial,
                      fillColor: !useMaterial ? !isTrackField? kWhiteColor: kGreyColor.withAlpha(40) : null,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(!isTrackField? 10: kFieldRadius),
                          bottomLeft: Radius.circular(!isTrackField? 10: kFieldRadius),
                        ),
                        borderSide: isTrackField? BorderSide.none:const BorderSide(
                            color: kFieldBorderColor, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isTrackField? 10: kFieldRadius),
                          bottomLeft: Radius.circular(isTrackField? 10: kFieldRadius),
                        ),
                        borderSide: isTrackField? BorderSide.none: const BorderSide(
                            color: kPrimaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isTrackField? 10: kFieldRadius),
                          bottomLeft: Radius.circular(isTrackField? 10: kFieldRadius),
                        ),
                        borderSide: isTrackField? BorderSide.none: BorderSide(
                            color: kGreyColor,
                            width: 1),
                      ),
                      contentPadding: EdgeInsets.all(isTrackField? 12 : 16),
                    ),
                    style: TextStyle(
                      color: kTextHintColor,
                      decorationColor: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if(onTap != null){
                    onTap!();
                  }
                },
                child: Container(
                  height: useMaterial ? 50.5 : !isTrackField ? 57 : 49,
                  width: 55,
                  decoration: BoxDecoration(
                    color: kBlackColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(isTrackField? 10: kFieldRadius),
                      bottomRight: Radius.circular(isTrackField? 10: kFieldRadius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/search.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
        if(isTrackField)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/validate.png", height: 20,),
              const Text(" Validate", style: TextStyle(fontSize: 14, color: kGreyColor),),
              const SizedBox(width: 40,),
              Image.asset("assets/icons/not-validate.png", height: 20,),
              const Text(" Not Validate", style: TextStyle(fontSize: 14, color: kGreyColor),)
            ],
          ),

        const SizedBox(height: 4),
        Obx(() => Visibility(
          visible: textFieldManager.errorMessage.value.isNotEmpty && !isTrackField,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              textFieldManager.errorMessage.value,
              style:
              const TextStyle(color: kRequiredRedColor, fontSize: 12),
            ),
          ),
        )),
      ],
    );
  }
}
