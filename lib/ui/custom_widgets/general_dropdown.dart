
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/custom_widget_controllers/dropdown_controller.dart';
import '../../models/item_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class GeneralDropdown extends StatelessWidget {
  final DropdownController controller;
  final double paddingHorizontal;
  final void Function(dynamic)? onItemChanged;
  final bool readOnly;
  final double labelFont;

  const GeneralDropdown({
    super.key,
    required this.controller,
    this.paddingHorizontal = 0,
    this.onItemChanged,
    this.labelFont = 16,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: kFieldVerticalMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(kFieldRadius),
              color: readOnly
                  ? kCardColor
                  : Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                    visible: controller.title.length>30,
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: controller.title,
                              style: TextStyle(color: kTextHintColor, fontWeight: FontWeight.w500),
                              children: [
                                if(controller.mandatory)
                                  TextSpan(
                                      text: "*",
                                      style: TextStyle(color: kRequiredRedColor, fontWeight: FontWeight.w500)
                                  )
                              ]
                          ),),
                        SizedBox(height: 4,)
                      ],
                    )),
                Obx(() => DropdownSearch(
                  selectedItem: controller.selectedItem.value,
                  enabled: controller.items.isNotEmpty && !readOnly,
                  dropdownBuilder: (context, selectedItem) => Text((controller.selectedItem.value != null) ? controller.selectedItem.value.toString() : controller.hintText.isEmpty ? 'Select ${controller.title.length>30?"":controller.title}':controller.hintText,
                      overflow: TextOverflow.ellipsis,
                      maxLines:1,
                      style: TextStyle(color: (!readOnly && controller.selectedItem.value == null) ? kTextHintColor: kBlackColor)),
                  dropdownButtonProps: DropdownButtonProps(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: readOnly || controller.items.isEmpty
                          ? kLightGreyColor
                          : kGreyColor,
                    ),
                  ),
                  items: controller.items,
                  popupProps: PopupProps.menu(
                    showSearchBox: controller.items.length>8,
                    // showSearchBox: isSearchable,
                    fit: FlexFit.loose,
                    itemBuilder: (context, itm, isSelected) {
                      dynamic item = itm;
                      // isSelected =item !=null && controller.selectedItem.value!=null && controller.selectedItem.value.toString()== item.toString();
                      /* isSelected = item != null && controller.selectedItem.value != null &&
                                  ((controller.selectedItem.value is int || controller.selectedItem.value is String || controller.selectedItem.value is double) ?
                                  controller.selectedItem.value.toString() == item.toString()
                                      : (controller.selectedItem.value.id != null && controller.selectedItem.value.id.toString() == item.id.toString())
                                  );*/
                      isSelected = item != null && controller.selectedItem.value != null &&
                          ((controller.selectedItem.value is int ||
                              controller.selectedItem.value is String ||
                              controller.selectedItem.value is double)
                              ? controller.selectedItem.value.toString() == item.toString()
                              : (controller.selectedItem.value is ItemModel && item is ItemModel
                              ? controller.selectedItem.value.id == item.id
                              : false)
                          );

                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                        margin: const EdgeInsets.only(bottom: 3, top: 2),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: isSelected ? kPrimaryDarkColor : kWhiteColor,
                            border: const Border(bottom: BorderSide(color: kCardColor)),
                            boxShadow: const [BoxShadow(spreadRadius: 0,blurRadius: 2, color: kCardShadowColor,offset: Offset(0, 1))]
                        ),
                        child: Text(item.toString(), style: TextStyle(color: isSelected ? kWhiteColor : kTextColor),),
                      );
                    },
                    searchDelay: Duration.zero,
                    scrollbarProps: const ScrollbarProps(
                      scrollbarOrientation: ScrollbarOrientation.right,
                      thumbColor: kPrimaryDarkColor,
                      thickness: 10,
                      radius: Radius.circular(20),
                    ),
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: 'Search ${controller.title}...',
                        hintStyle: const TextStyle(
                          color: kTextHintColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 400,
                      maxWidth: Get.width,
                      minWidth: Get.width,
                    ),
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      label: controller.title.length<30?RichText(text: TextSpan(
                          text: controller.title ,
                          style: TextStyle(color: kTextHintColor, fontSize: labelFont),
                          children: [
                            if(controller.mandatory)
                              TextSpan(text: " *", style: TextStyle(color: kRequiredRedColor, fontSize: labelFont))
                          ]
                      ),):null,
                      // contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular( kFieldRadius)),
                        borderSide: BorderSide(color: kFieldBorderColor,width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(kFieldRadius)),
                        borderSide: BorderSide(color: kPrimaryDarkColor, width: 1.5),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius:  BorderRadius.all(Radius.circular( kFieldRadius)),
                        borderSide: BorderSide(color: kFieldBorderColor, width: 1),
                      ),
                      hintText: (readOnly &&controller.selectedItem.value != null)
                          ? controller.selectedItem.value.toString()
                          : controller.items.isEmpty ?'${controller.title} not found':controller.hintText.isEmpty ? 'Select ${controller.title.length>30?"":controller.title}':controller.hintText,
                      hintStyle: const TextStyle(color: kTextHintColor,fontSize: 14,fontWeight: FontWeight.w500),
                    ),
                  ),
                  onChanged: (selectedItem) {
                    controller.selectedItem.value = selectedItem;

                    controller.validate();
                    if (onItemChanged != null) {
                      onItemChanged!(selectedItem);
                    }
                  },
                )
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => Visibility(
            visible: controller.errorMessage.value.isNotEmpty,
            child: Text(
              controller.errorMessage.value,
              style:
              const TextStyle(color: kRequiredRedColor, fontSize: 12),
            ),
          )),

        ],
      ),
    );
  }
}
