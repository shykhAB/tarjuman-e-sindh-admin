import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/news_list_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/models/news_model.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/string_utils.dart';
import '../../utils/app_colors.dart';
import '../../utils/common_code.dart';
import '../custom_widgets/custom_dialogs.dart';
import '../custom_widgets/custom_loading_indicator.dart';

class NewsListScreen extends GetView<NewsListScreenController> {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "Uploaded News List",
        scaffoldKey: controller.scaffoldKey,
        onAddPressed: () async {
          final result = await Get.toNamed(kUploadNewsScreenRoute);
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
          Obx(()=> CustomLoadingIndicator(isLoading: controller.isLoading.value, isListEmpty: controller.newsList.isEmpty,)),
          SizedBox(height: 10,),
          for(var v in controller.newsList)
            _buildNewsCard(news: v)
        ],
      ),
    );
  }

  Widget _buildNewsCard({required NewsModel news}) {
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
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      news.heading,
                      style:  TextStyle(
                        fontFamily: kFontFamilySindhi,
                        color: kPrimaryDarkColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 25),
                    Row(
                      spacing: 2,
                      children: [
                        Icon(Icons.access_time_outlined, size:  17,),
                        Text(news.createdAt.timeAgo, style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 11
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              ClipRRect(
                child: Image.memory(
                  CommonCode().decodeImage(news.image.imageData),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: kGreyColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(Icons.image, size: 40, color: kGreyColor),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
