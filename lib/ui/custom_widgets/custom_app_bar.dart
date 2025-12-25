import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/platform/platform_io.dart';

import '../../utils/app_colors.dart';
import '../../utils/user_session.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String screenName;
  final double appBarHeight;
  final PreferredSize? bottomSheet;
  final Function? onBackButtonPress;

  const CustomAppbar({
    super.key,
    required this.screenName,
    required this.scaffoldKey,
    required this.onBackButtonPress,
    required this.appBarHeight,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: kWhiteColor,
      backgroundColor: kWhiteColor,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 70,
      automaticallyImplyLeading: GeneralPlatform.isWeb,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryGradientColor1, kPrimaryGradientColor2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        )
      ) ,
      actions: [
        screenName != "Find Route" && (UserSession.userModel.value.name.isNotEmpty ? true : screenName != "Create Account") && screenName != "Forgot Password" && screenName != "Verify OTP"  && screenName != "Reset Password" && screenName != "Sync Data" && screenName != "Track Certificate" ?GestureDetector(
          child: Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(right: 10, top: 0, left: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: kWhiteColor,
                border: Border.all(color: kWhiteColor),
                borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              'assets/icons/menu-new.png',
              color: kPrimaryColor,
            ),
          ),
          onTap: () {
            scaffoldKey.currentState!.openEndDrawer();
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ) : const SizedBox(),
      ],
      leading: (screenName.isNotEmpty && screenName != "Sync Data")?
      GestureDetector(
        onTap: (){
          if(onBackButtonPress != null){
            onBackButtonPress!();
          }else{
            Get.back();
          }
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 13),
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: kWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGreyColor.withAlpha(70))
          ),
          child: const Icon(Icons.arrow_back_ios, color: kBlackColor, size: 22,),
        ),
      ):null,
      title: FittedBox(
        child: Padding(
          padding: screenName == "Sync Data" ?const EdgeInsets.only(left: 32.0):const EdgeInsets.all(0),
          child: Text(
            screenName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,  color: (UserSession.userModel.value.name.isNotEmpty ? false : screenName == "Create Account")  || screenName == "Forgot Password" || screenName == "Verify OTP"  || screenName == "Reset Password" || screenName == "Track Certificate" ? kBlackColor : kWhiteColor),
          ),
        ),
      ),
      actionsIconTheme: const IconThemeData(),
      bottom: bottomSheet,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
