import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/controllers/dashboard_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';

import '../../utils/app_colors.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        className: runtimeType.toString(),
        screenName: "Dashboard",
        scaffoldKey: controller.scaffoldKey,
        body: _body());
  }

  Widget _body(){
    return Column(
      children: [
        SizedBox(height: 20,),
        GestureDetector(
          onTap: ()=>Get.toNamed(kNewsListScreenRoute),
          child: Row(
            children: [
              Expanded(child: _buildSurveyCard(icon: Icons.access_alarms, count: "3", label: "No of News", color: kLightGreenColor)),
              SizedBox(width: 5,),
              Expanded(child: _buildSurveyCard(icon: Icons.access_alarms, count: "3", label: "No of E-Papers", color: kButtonColor))
            ],
          ),
        )

      ],
    );
  }


  Widget _buildSurveyCard({required IconData icon, required String count, required String label, required Color color}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(colors: [color, color.withAlpha(150)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: RichText(text: TextSpan(
                text: "$count\n",
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 24, fontWeight: FontWeight.w500
                ),
                children: [
                  TextSpan(
                    text: label,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 13, fontWeight: FontWeight.w400
                    ),
                  )
                ]
            )),
          ),
          Expanded(
              flex: 1,
              child: Icon(icon))
        ],
      ),
    );
  }
}
