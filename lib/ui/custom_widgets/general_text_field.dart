import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/text_field_manager.dart';
import '../../utils/text_filter.dart';

class GeneralTextField extends StatelessWidget {
  final TextFieldManager tfManager;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChange;
  // final Function(String)? callback;
  final int maxLines;
  final double paddingHorizontal;
  final double labelFont;
  final bool readOnly;
  final TextAlign textAlign;
  final RxBool _obscure = true.obs;

  GeneralTextField({super.key,
    required this.tfManager,
    // this.callback,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.paddingHorizontal = 0,
    this.readOnly = false,
    this.labelFont = 16,
    this.textAlign = TextAlign.start,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: kFieldVerticalMargin),
      child: Obx(()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: tfManager.fieldName.length>40,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: tfManager.fieldName,
                        style: TextStyle(color: kTextHintColor, fontSize: 12, fontWeight: FontWeight.w500),
                        children: [
                          if(tfManager.mandatory)
                            TextSpan(
                                text: "*",
                                style: TextStyle(color: kRequiredRedColor, fontSize: 14, fontWeight: FontWeight.w500)
                            )
                        ]
                    ),),
                  SizedBox(height: 4,)
                ],
              )),
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.only(left: 2, right: 2),
            // decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(kFieldRadius),
            // border: Border.all(color: kFieldBorderColor),
            // color: kFieldBGColor,
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    keyboardType: tfManager.keyboardType,
                    maxLines: maxLines,
                    minLines: maxLines > 2 ? 3 : null,
                    readOnly: readOnly,
                    maxLength: tfManager.length,
                    controller: tfManager.controller,
                    focusNode: tfManager.focusNode,
                    textCapitalization: tfManager.textCapitalization,
                    textAlign: textAlign,
                    obscureText: tfManager.filter == TextFilter.password? _obscure.value:false,
                    onChanged: (value) {
                      if(tfManager.customValidation!=null){
                        tfManager.customValidation!();
                      }else{
                        tfManager.validate();
                      }
                      if (onChange != null) {
                        onChange!(value);
                      }
                      // if (value.isEmpty && tfManager.focusNode.hasFocus) {
                      //   callback?.call(value);
                      // }
                    },
                    cursorColor: kPrimaryColor,
                    textInputAction: maxLines == 1
                        ? TextInputAction.done
                        : TextInputAction.newline,
                    inputFormatters: tfManager.formatters,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      label: tfManager.fieldName.length<40?RichText(
                        text: TextSpan(
                            text: tfManager.hint ??tfManager.fieldName,
                            style: TextStyle(
                                color: kTextHintColor,
                                fontSize: labelFont),
                            children: [
                              if (tfManager.mandatory)
                                TextSpan(
                                    text: " *",
                                    style: TextStyle(
                                        color: kRequiredRedColor,
                                        fontSize: labelFont))
                            ]),
                      ):null,
                      filled: readOnly,
                      fillColor: readOnly
                          ? kPrimaryColor.withOpacity(0.1)
                          : Colors.transparent,
                      labelStyle: TextStyle(
                          color: readOnly ? kFieldBorderColor : kGreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(kFieldRadius)),
                        borderSide: const BorderSide(color: kFieldBorderColor, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(kFieldRadius)),
                        borderSide: BorderSide(color: kPrimaryDarkColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(kFieldRadius)),
                        borderSide: BorderSide(color: kFieldBorderColor, width: 1),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      // border: InputBorder.none,
                      prefixIcon: prefixIcon != null
                          ? Icon(prefixIcon, color: kTextHintColor, size: 32)
                          : null,
                      suffixIcon: tfManager.filter != TextFilter.password
                          ? suffixIcon != null
                          ? Icon(
                        suffixIcon,
                        size: 30,
                        color: kGreyColor,
                      )
                          : null
                          : GestureDetector(
                          onTap: () => _obscure.toggle(),
                          child: Icon(
                            _obscure.isTrue
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            color: kTextHintColor,
                          )),
                    ),
                    style: TextStyle(
                      color: readOnly ? kTextHintColor : kTextColor,
                      decorationColor: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),

          ),
          const SizedBox(height: 4),
          Visibility(
            visible: tfManager.errorMessage.value.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                tfManager.errorMessage.value,
                style: const TextStyle(color: kRequiredRedColor, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
