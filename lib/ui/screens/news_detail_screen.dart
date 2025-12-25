
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/news_detail_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import 'package:tarjuman_e_sindh_admin/utils/string_utils.dart';

import '../../utils/app_colors.dart';
import '../../utils/common_code.dart';

class NewsDetailScreen extends GetView<NewsDetailScreenController> {
  const NewsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "News Detail",
        scaffoldKey: controller.scaffoldKey,
        body: _body());
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 20,),
          ClipRRect(
            child: Image.memory(
              CommonCode().decodeImage(controller.news.image.imageData),
              width: Get.width * 0.9,
              height: Get.height * 0.4,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: Get.width * 0.9,
                  height: Get.height * 0.4,
                  decoration: BoxDecoration(
                    color: kGreyColor.withAlpha(50),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(Icons.image, size: Get.width * 0.3, color: kGreyColor),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: kPrimaryDarkColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.person, color: kWhiteColor,),
                    Text(controller.news.createdByName, style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              Row(
                spacing: 2,
                children: [
                  Icon(Icons.access_time_outlined, size: 20,),
                  Text(controller.news.createdAt.timeAgo, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(controller.news.heading, style: TextStyle(fontFamily: kFontFamilySindhi, color: kTextColor, fontWeight: FontWeight.bold, fontSize: 18),),
          const SizedBox(height: 6),
          Text(controller.news.detail, style: TextStyle(fontFamily: kFontFamilySindhi, color: kTextColor),)

        ],
      ),
    );
  }
}
