import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tarjuman_e_sindh_admin/controllers/dashboard_screen_controller.dart';
import 'package:tarjuman_e_sindh_admin/models/weekly_graph_model.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_scaffold.dart';
import 'package:tarjuman_e_sindh_admin/utils/constants.dart';
import '../../utils/app_colors.dart';
import '../custom_widgets/custom_loading_indicator.dart';

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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildSurveyCard(icon: Icons.file_copy, count: "3", label: "Total Uploaded\n News", color: Color(0xFF276667))),
                  SizedBox(width: 5,),
                  Expanded(child: _buildSurveyCard(icon: Icons.newspaper_outlined, count: "3", label: "Total Uploaded\n E-Papers", color: Color(0xFFB69B03)))
                ],
              ),
              _buildWeeklyInspectionsChart(),
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

  //
  // Widget _customPieChart({required Map<String, double> data, List<Color> colors = const [kPrimaryColor, kPrimaryYellowColor]}) {
  //   // final double total = max(data.values.reduce((a, b) => a + b),1);
  //
  //   return SfCircularChart(
  //     margin: EdgeInsets.zero,
  //     legend: Legend(
  //       isVisible: true,
  //       position: LegendPosition.bottom,
  //       iconHeight: 16,
  //       iconWidth: 16,
  //       overflowMode: LegendItemOverflowMode.wrap,
  //     ),
  //     tooltipBehavior: TooltipBehavior(enable: true),
  //     series: <CircularSeries>[
  //       PieSeries<MapEntry<String, double>, String>(
  //         dataSource: data.entries.toList(),
  //         xValueMapper: (entry, _) => entry.key,
  //         yValueMapper: (entry, _) => entry.value,
  //         pointColorMapper: (entry, index) => colors[index % colors.length],
  //         // dataLabelMapper: (entry, _) => "${(entry.value*100/total).toPrecision(1)}%",
  //         dataLabelMapper: (entry, _) => "${entry.value.toInt()}",
  //         dataLabelSettings: DataLabelSettings(
  //             useSeriesColor: true,
  //             labelPosition: ChartDataLabelPosition.outside,
  //             isVisible: true,textStyle: TextStyle(fontSize: 15, color: kWhiteColor, fontWeight: FontWeight.bold, shadows: [Shadow(color: kBlackColor, offset: Offset(1, 2), blurRadius: 2)])),
  //         explode: true,
  //         explodeIndex: 1,
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _socialPreFeasibilityStatsChart(DashboardCountModel stats) {
  //   final maritalStatus = {
  //     "Pending": stats.pending.toString(),
  //     "Completed": stats.completed.toString(),
  //     "Under\nReview": stats.underReview.toString(),
  //     "Approved": stats.approved.toString(),
  //     "Rejected": stats.rejected.toString(),
  //   };
  //
  //   final List<Color> barColors = [
  //     kYellowColor,
  //     kChartBlueColor,
  //     kPrimaryAccentColor,
  //     kGreenArrowColor,
  //     kRequiredRedColor,
  //   ];
  //
  //   return SfCartesianChart(
  //     margin: EdgeInsets.zero,
  //     primaryXAxis: CategoryAxis(
  //       majorGridLines: MajorGridLines(width: 0),
  //       labelIntersectAction: AxisLabelIntersectAction.rotate45,
  //       maximumLabelWidth: 120,
  //     ),
  //     primaryYAxis: NumericAxis(
  //       labelStyle: const TextStyle(color: Colors.transparent),
  //       axisLine: const AxisLine(width: 0),
  //       majorTickLines: const MajorTickLines(size: 0),
  //     ),
  //     tooltipBehavior: TooltipBehavior(enable: true),
  //     series: <CartesianSeries<MapEntry<String, String>, String>>[
  //       ColumnSeries<MapEntry<String, String>, String>(
  //         dataSource: maritalStatus.entries.toList(),
  //         xValueMapper: (entry, _) => entry.key,
  //         yValueMapper: (entry, _) => double.tryParse(entry.value) ?? 0,
  //         pointColorMapper: (entry, index) => barColors[index % barColors.length],
  //         dataLabelSettings: DataLabelSettings(isVisible: true),
  //       ),
  //     ],
  //   );
  // }


  Widget _buildWeeklyInspectionsChart() {
    return Obx((){
      if(controller.weeklyData.isEmpty){
        return CustomLoadingIndicator(isListEmpty: controller.weeklyData.isEmpty, isLoading: controller.isLoading.value,);
      }
      return SfCartesianChart(
        margin:EdgeInsets.only(top: 24),
        title: ChartTitle(
          text: 'Weekly News Report',
          alignment: ChartAlignment.near,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),

        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),

        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x: point.y news',
          textStyle: const TextStyle(color: kWhiteColor),),


        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
          enableDoubleTapZooming: true,
        ),
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelRotation: -45,
        ),

        primaryYAxis: NumericAxis(
          minimum: 0,
          interval: 5,
          majorGridLines: const MajorGridLines(
            width: 0.8,
            color: kGreyColor,
            dashArray: [5, 5],
          ),
        ),
        series: <CartesianSeries>[
          ColumnSeries<WeeklyGraphModel, String>(
            name: 'News',
            dataSource: controller.weeklyData,
            xValueMapper: (data, _) => data.formattedDay,
            yValueMapper: (data, _) => data.count,
            color: const Color(0xFF27666d).withValues(alpha: 0.7),
            borderColor: const Color(0xFF276667),
            borderWidth: 2,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            animationDuration: 1500,
          ),

          LineSeries<WeeklyGraphModel, String>(
            name: 'Progress',
            dataSource: controller.weeklyData,
            xValueMapper: (data, _) => data.formattedDay,
            yValueMapper: (data, _) => data.count,
            color: const Color(0xFFB69B03),
            width: 3,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              borderWidth: 2,
              borderColor: kCardLightColor,
              width: 8,
              height: 8,
            ),
            animationDuration: 2000,
          ),
        ],
        plotAreaBorderWidth: 1,
        plotAreaBorderColor: kGreyColor.withAlpha(50),
      );
    }
    );
  }
}
