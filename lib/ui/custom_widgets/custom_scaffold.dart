import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/ui/custom_widgets/custom_dashboard_app_bar.dart';
import '../../utils/app_colors.dart';
import 'custom_app_bar.dart';
import 'custom_dialogs.dart';

class CustomScaffold extends StatefulWidget {

  final Widget body;
  final String className,screenName;
  final Function? onWillPop,
      gestureDetectorOnTap,
      onBackButtonPressed,
      gestureDetectorOnPanDown,
      onAddPressed,
      onNotificationListener;
  final Future<void> Function()? onRefresh;
  final ScrollController? scrollController;
  final double horizontalPadding;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double appBarHeight;
  final PreferredSize? bottomSheet;


  const CustomScaffold({super.key,
    required this.className,
    required this.screenName,
    this.onWillPop,
    this.onBackButtonPressed,
    this.gestureDetectorOnPanDown,
    this.gestureDetectorOnTap,
    this.onNotificationListener,
    this.onAddPressed,
    this.onRefresh,
    required this.scaffoldKey,
    required this.body,
    this.scrollController,
    this.horizontalPadding=20,
    this.appBarHeight = 70,
    this.bottomSheet,
  });

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: (){
          if(widget.className == "TransportDashboardScreen" || widget.className == "DashboardScreen"){
            if(widget.scaffoldKey.currentState!.isDrawerOpen){
              Get.back();
            }else {
              CustomDialogs().showAwesomeConfirmationDialog("Are you sure you want to exit?",onOkBtnPressed: ()=>exit(0));
            }
            return Future.value(false);
          }else{
            if(widget.onWillPop!=null) {
              return widget.onWillPop!();
            } else {
              return Future.value(true);
            }
          }
        },
        child: GestureDetector(
          onTap: (){
            if(widget.gestureDetectorOnTap != null){
              widget.gestureDetectorOnTap!();
            }
          },
          onPanDown: (panDetails){
            if(widget.gestureDetectorOnPanDown!= null){
              widget.gestureDetectorOnPanDown!(panDetails);
            }
          },
          child: NotificationListener(
            onNotification: (notificationInfo){
              if(widget.onNotificationListener!=null) {
                return widget.onNotificationListener!(notificationInfo);
              } else {
                return false;
              }
            } ,
            child: Scaffold(
              backgroundColor: kWhiteColor,
              extendBody: true,
              resizeToAvoidBottomInset: true,
              key: widget.scaffoldKey,
              appBar: CustomDashboardAppbar(screenName: widget.screenName, scaffoldKey: widget.scaffoldKey, appBarHeight: 180,onBackButtonPress: widget.onBackButtonPressed),
              body: Stack(
              children: [
              widget.onRefresh != null
                  ? RefreshIndicator(
                  onRefresh: widget.onRefresh!,
                color: kPrimaryColor,
                child: ListView(
                  controller: widget.scrollController,
                    // physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom:  widget.onAddPressed == null ? 16 : 64, left: widget.horizontalPadding, right: widget.horizontalPadding),
                  children: [
                    widget.body
                  ],
                ),
              ) : widget.screenName == "Find Route"? widget.body :SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom:  widget.onAddPressed == null ? 16 : 64, left: widget.horizontalPadding, right: widget.horizontalPadding),
                child:widget.body,
              ),
              // bottomNavigationBar: const CustomBottomNavBar(),
              // endDrawer: isDrawerVisible ?const CustomNavigationDrawer():null,
              ]
              ),
              floatingActionButton: widget.onAddPressed == null ? null : FloatingActionButton(
                onPressed:()=> widget.onAddPressed!(),
                backgroundColor: kBlackColor,
                shape: const CircleBorder(),
                child: const Icon(Icons.add,color: kWhiteColor, size: 32),
              ),
              // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            ) ,
          ),
        ));
  }

}