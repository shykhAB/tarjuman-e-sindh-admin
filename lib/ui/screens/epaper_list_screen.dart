import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/string_utils.dart';
import '../../controllers/epaper_list_screen_controller.dart';
import '../../models/epaper_model.dart';
import '../../utils/app_colors.dart';
import '../custom_widgets/custom_dialogs.dart';
import '../custom_widgets/custom_loading_indicator.dart';
import '../custom_widgets/custom_scaffold.dart';

class EPaperListScreen extends GetView<EPaperListScreenController> {
  const EPaperListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "Uploaded E-Paper List",
        scaffoldKey: controller.scaffoldKey,
        onAddPressed: () async {
          final result = await Get.toNamed(kUploadEPaperScreenRoute);
          if(result == 'true'){
            controller.onInit();
          }
        },
        onRefresh: controller.onInit,
        body: _body());
  }

  Widget _body(){
    return Obx(
          ()=> Column(
        children: [
          Obx(()=> CustomLoadingIndicator(isLoading: controller.isLoading.value, isListEmpty: controller.paperList.isEmpty,)),
          SizedBox(height: 10,),
          for(var v in controller.paperList)
            _buildNewsCard(news: v)
        ],
      ),
    );
  }

  Widget _buildNewsCard({required EPaperModel news}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(kNewsDetailScreenRoute, arguments: news);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
            color: kCardLightColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  color: kLightGreyColor,
                  offset: Offset(0, 0.8)
              )
            ]
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 30,
                child: PopupMenuButton<String>(
                  onSelected: (value) async {
                    if(value == "delete"){
                      CustomDialogs().confirmationDialog(
                        message: "Are you sure you want to delete this news?",
                        yesFunction: () {
                          controller.deleteNews(id: news.id.toString());
                        },
                      );
                    }

                    if(value == "edit"){
                      final result = await Get.toNamed(kUploadNewsScreenRoute, arguments: news);
                      if(result == 'true'){
                        controller.onInit();
                      }
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  color: kWhiteColor,
                  shadowColor: kCardShadowColor,
                  elevation: 2,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.delete, size: 20, color: kRequiredRedColor,),
                          Text("Delete"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.edit_calendar, size: 20, color: kPrimaryLightColor,),
                          Text("Edit"),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 2,
                  children: [
                    Icon(Icons.access_time_outlined, size:  17,),
                    Text(news.createdAt.timeAgo, style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 11
                    ),),
                  ],
                ),
              ),
              SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
