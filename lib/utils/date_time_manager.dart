import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';

class DateTimeManager {

  DateTime? dateTime;
  DateTime firstDate;
  DateTime lastDate;
  String fieldName;
  RxString formattedDateTime = "".obs;
  RxString errorMessage=''.obs;
  String pattern;
  bool mandatory;
  FocusNode focusNode =  FocusNode();
  RxBool isFocused = false.obs;
  TextEditingController controller = TextEditingController();

  DateTimeManager(this.fieldName, {this.pattern='dd-MM-yyyy', DateTime? firstDate, DateTime? lastDate, this.mandatory = true}) :
        firstDate=firstDate??DateTime.now(),
        lastDate=lastDate??DateTime(DateTime.now().year+10, DateTime.now().month, DateTime.now().day){

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isFocused.value = true;
      } else {
        isFocused.value = false;
      }
    });
  }

  bool validateDate({DateTime? date}){
    if(date!=null) {
      dateTime = date;
    }
    if (dateTime != null && !(dateTime.isBlank!)) {
      formattedDateTime.value = DateFormat(pattern).format(dateTime!);
      controller.text = formattedDateTime.value;
      errorMessage.value = "";
      UserSession.isDataChanged.value = true;
    } else {
      dateTime = null;
      formattedDateTime.value = "";
      errorMessage.value = isTitleUrdu? "$fieldName ضروری ہے " : "$fieldName is required";
    }
    return errorMessage.isEmpty;
  }


  String getFormattedDateTime({String? pattern}){
    if(dateTime!=null && !dateTime.isBlank!) {
      return DateFormat(pattern??this.pattern).format(dateTime!);
    } else {
      return formattedDateTime.value;
    }
  }


  void clear(){
    dateTime=null;
    formattedDateTime.value = "";
    errorMessage.value='';
  }

  void parse(String dateStr){
    dateTime  = DateTime.tryParse(dateStr);
    if(dateTime == null){
      try {
        dateTime = DateFormat(pattern).parse(dateStr.replaceAll('/', '-'));
      }catch(_){}
    }
    if(dateTime != null){
      if(!dateTime!.isBefore(firstDate) && !dateTime!.isAfter(lastDate)){
        validateDate();
      } else {
        dateTime = null;
        formattedDateTime.value = '';
      }
    }
  }
  bool get isTitleUrdu => RegExp(r'[\u0600-\u06FF]').hasMatch(fieldName);
}