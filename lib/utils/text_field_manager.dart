
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';
import 'package:tarjuman_e_sindh_admin/utils/string_utils.dart';
import 'package:tarjuman_e_sindh_admin/utils/text_filter.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';

import 'log.dart';


class TextFieldManager {

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  RxString errorMessage=''.obs;
  String fieldName;
  TextInputType _textInputType = TextInputType.name;
  bool Function()? customValidation;
  int length;
  String? hint;
  TextCapitalization textCapitalization = TextCapitalization.none;

  TextFilter filter;
  List<TextInputFormatter>? _formatters;
  bool mandatory;
  int minNumber;
  int? maxNumber;

  TextFieldManager(this.fieldName, {this.filter= TextFilter.none, this.mandatory=true, this.length=50, this.hint, this.minNumber=0, this.maxNumber, RegExp? regex}) {
    if(filter == TextFilter.cnic){
      length = 15;
      _formatters=[MaskInputFormatter(mask: '#####-#######-#')];
      _textInputType = TextInputType.number;
      customValidation = validateCNIC;
    } else if(filter == TextFilter.number){
      _formatters=[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))];
      _textInputType = TextInputType.number;
      customValidation = validateNumber;
    } else if(filter == TextFilter.name){
      _formatters=[FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]'))];
      textCapitalization = TextCapitalization.words;
      _textInputType = TextInputType.name;
    } else if(filter == TextFilter.alphaNumeric){
      _formatters=[FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9 ]'))];
      textCapitalization = TextCapitalization.sentences;
      _textInputType = TextInputType.text;
    } else if(filter == TextFilter.email){
      _formatters=[FilteringTextInputFormatter.deny(RegExp(r'\s'))];
      _textInputType = TextInputType.emailAddress;
      customValidation = validateEmail;
    } else if(filter == TextFilter.mobile){
      length = 12;
      _formatters=[MaskInputFormatter(mask: "####-#######")];
      _textInputType = TextInputType.number;
      customValidation = validateMobileNumber;
    } else if(filter == TextFilter.password){
      _formatters=[FilteringTextInputFormatter.deny(RegExp(r'\s'))];
      _textInputType = TextInputType.visiblePassword;
    } else {
      if(regex!=null) _formatters=[FilteringTextInputFormatter.allow(regex)];
    }
  }

  bool validate(){
    if(customValidation!=null) {
      UserSession.isDataChanged.value = true;
      return customValidation!();
    }
    if(text.isEmpty){
      errorMessage.value = mandatory ? "$fieldName is required" : '';
    }else {
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    }
    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  @override
  String toString() {
    return controller.text;
  }

  bool validateMobileNumber() {
    if(text.isEmpty) {
      errorMessage.value = mandatory ? "$fieldName is required" : "";
    } else if(RegExp(r'^[0][3][0-5][0-9]-[0-9]{7}$').hasMatch(text)) {
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    }else{
      errorMessage.value = "$fieldName must follow '03XX-XXXXXXX' format!";
    }

    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }



  bool validateCNIC(){
    if(text.isEmpty){
      errorMessage.value = mandatory ? "$fieldName is required" : "";
    } else if(RegExp(r"^[0-9]{5}-[0-9]{7}-[0-9]$").hasMatch(text)){
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    } else {
      errorMessage.value = "CNIC must follow the 'XXXXX-XXXXXXX-X' format!";
      // errorMessage.value = "Invalid $fieldName";
    }
    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  bool validateHouseholdNumber(){
    if(text.isEmpty){
      errorMessage.value = mandatory ? "Household Ref Number is required" : "";
    } else if(RegExp(r"^[0-9]{3}[A-Z]?$").hasMatch(text)){
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    } else {
      errorMessage.value = "Household Ref Number must follow the '###A' format!";
    }
    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  bool validateNumber() {
    if(text.isEmpty){
      errorMessage.value =  mandatory ? "$fieldName is required" : "";
    } else if (text.toInt < minNumber || (maxNumber!=null && text.toInt > maxNumber!)) {
      controller.text = text.toInt.toString();
      maxNumber!=null
          ? errorMessage.value = "$fieldName cannot be more than $maxNumber"
          : errorMessage.value = "$fieldName cannot be less than $minNumber";
    } else {
      UserSession.isDataChanged.value = true;
      controller.text = text.toInt.toString();
      controller.selection = TextSelection(baseOffset: text.length, extentOffset: text.length);
      errorMessage.value = "";
    }
    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  bool validateEmail() {
    if (text.isEmpty) {
      errorMessage.value = mandatory ? "$fieldName is required":"";
    } else if (!text.isEmail) {
      errorMessage.value = "Invalid $fieldName";
    } else {
      errorMessage.value = "";
    }
    if(errorMessage.isNotEmpty) Log.debug('TextField: $errorMessage',tag:  'VALIDATION');
    return errorMessage.isEmpty;
  }

  String get text => controller.text.trim();
  set text(String value) => controller.text = value;

  TextInputType get keyboardType => _textInputType;
  List<TextInputFormatter>? get formatters => _formatters;

  bool get removeFocus {
    if(focusNode.hasFocus) {
      focusNode.unfocus();
      return true;
    }
    return false;
  }

}

