 import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/date_time_manager.dart';



class GeneralDatePickerField extends StatelessWidget {

  final DateTimeManager dateManager;
  final double paddingHorizontal;
  final RxBool _withoutBorder=false.obs;
  final bool readOnly;
  final VoidCallback? onDateChange;

  GeneralDatePickerField.withoutBorder({super.key,
    required this.dateManager,
    this.paddingHorizontal=3,
    this.readOnly = false,
    this.onDateChange,
  }){
    _withoutBorder.value=true;
  }

  GeneralDatePickerField.withBorder({super.key,
    required this.dateManager,
    this.paddingHorizontal=0,
    this.readOnly=false,
    this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: kFieldVerticalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                      ()=> TextField(
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 120),
                        readOnly: true,
                        controller: dateManager.controller,
                        onTap: readOnly ? null : _selectDate,
                        focusNode: dateManager.focusNode,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: _withoutBorder.isTrue ? null : RichText(text: TextSpan(
                                text: dateManager.fieldName,
                                style: TextStyle(color: dateManager.isFocused.isTrue ? kPrimaryColor : kGreyColor, fontSize: 16),
                                children: [
                                  if(dateManager.mandatory)
                                    const TextSpan(text: " *", style: TextStyle(color: kRequiredRedColor, fontSize: 16))
                                ]
                            ),
                            ),
                            filled: readOnly ? readOnly : _withoutBorder.value,
                            fillColor: readOnly ? kPrimaryColor.withValues(alpha: 0.1) : _withoutBorder.value ? kWhiteColor : Colors.transparent,
                            labelStyle: TextStyle(
                                color: readOnly ? kFieldBorderColor : kGreyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(_withoutBorder.isTrue ? 0: kFieldRadius)),
                              borderSide: const BorderSide(color: kFieldBorderColor,width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(_withoutBorder.isTrue ? 0: kFieldRadius)),
                              borderSide: const BorderSide(color:  kPrimaryColor, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.all(Radius.circular(_withoutBorder.isTrue ? 0: kFieldRadius)),
                              borderSide: BorderSide(color: readOnly ? kFieldGreyColor : kGreyColor, width: 1),
                            ),
                            // hintText: "Enter ${tfManager.hint??tfManager.fieldName}",
                            contentPadding: const EdgeInsets.all(16),
                            // border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset('assets/icons/calendar-alt.png', color: kDarkGreyColor, width: 10, height: 10),
                            )
                        ),
                        style: TextStyle(
                          color: readOnly ? kTextHintColor : kTextHintColor,
                          decorationColor: kPrimaryColor,
                        ),
                      ),
                ),
              ),
            ],
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
      if (initDate.isBefore(dateManager.firstDate)) {
        initDate = dateManager.firstDate;
      }
      final date = await showDatePicker(
        context: Get.context!,
        initialDate: initDate,
        firstDate: dateManager.firstDate,
        lastDate: dateManager.lastDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kPrimaryColor,
              buttonTheme: const ButtonThemeData(buttonColor: kPrimaryColor), colorScheme: const ColorScheme.light(primary: kPrimaryColor).copyWith(secondary: kPrimaryColor),
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
