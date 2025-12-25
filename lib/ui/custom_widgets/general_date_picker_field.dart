/*Created By: Abdul Salam on 27-Oct-2025*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/date_time_manager.dart';


class GeneralDatePickerField extends StatelessWidget {

  final DateTimeManager dateManager;
  final double paddingHorizontal;
  final bool readOnly;
  final VoidCallback? onDateChange;

  const GeneralDatePickerField({super.key,
    required this.dateManager,
    this.paddingHorizontal=0,
    this.readOnly = false,
    this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: kFieldVerticalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: dateManager.fieldName.length>40,
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: dateManager.fieldName,
                        style: TextStyle(color: kTextHintColor, fontSize: 12, fontWeight: FontWeight.w500),
                        children: [
                          if(dateManager.mandatory)
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 120),
                      readOnly: true,
                      controller: dateManager.controller,
                      onTap: readOnly ? null : _selectDate,
                      focusNode: dateManager.focusNode,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label:  dateManager.fieldName.length<40?RichText(text: TextSpan(
                              text: dateManager.fieldName,
                              style: TextStyle(color: kTextHintColor, fontSize: 16),
                              children: [
                                if(dateManager.mandatory)
                                  const TextSpan(text: " *", style: TextStyle(color: kRequiredRedColor, fontSize: 16))
                              ]
                          ),
                          ):null,
                          filled: readOnly,
                          fillColor: readOnly ? kPrimaryColor.withOpacity(0.1) : Colors.transparent ,
                          labelStyle: TextStyle(
                              color: readOnly ? kFieldBorderColor : kTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.calendar_today_outlined, color: kGreyColor,),
                          )
                      ),
                      style: TextStyle(
                        color: readOnly ? kTextHintColor : kTextColor,
                        decorationColor: kPrimaryColor,
                      ),
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Visibility(
            visible: dateManager.errorMessage.value.isNotEmpty,
            child: Text(dateManager.errorMessage.value, style: const TextStyle(color: kRequiredRedColor, fontSize: 12),),
          )),

        ],
      ),
    );
  }

  void _selectDate() async {
    var now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    try {
      DateTime? initDate = dateManager.dateTime;
      if(initDate==null){
        if(now.toString().split(' ').first == dateManager.firstDate.toString().split(' ').first){
          initDate =  dateManager.firstDate;
        } else if(now.toString().split(' ').first == dateManager.lastDate.toString().split(' ').first){
          initDate =  dateManager.lastDate;
        } else if(now.isAfter(dateManager.lastDate)){
          initDate =  dateManager.lastDate;
        } else if(now.isBefore(dateManager.firstDate)){
          initDate =  dateManager.firstDate;
        } else {
          initDate = now;
        }

      }
      final date = await showDatePicker(
        context: Get.context!,
        initialDate: initDate,
        firstDate: dateManager.firstDate,
        lastDate: dateManager.lastDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light(useMaterial3: true).copyWith(
              primaryColor: kPrimaryDarkColor,
              buttonTheme: const ButtonThemeData(buttonColor: kPrimaryDarkColor), colorScheme: const ColorScheme.light(primary: kPrimaryDarkColor).copyWith(secondary: kPrimaryDarkColor),
            ),
            child: child!,
          );
        },
      );
      if (date!=null) {
        dateManager.validateDate(date: date);
        if(onDateChange != null) {
          onDateChange!();
        }
      }
    } catch (_) {}
  }


}
