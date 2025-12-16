import 'package:flutter/material.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';
import '../../utils/app_colors.dart';

class CustomDashboardAppbar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double appBarHeight;
  final String screenName;
  final Function? onBackButtonPress;

  const CustomDashboardAppbar({
    super.key,
    required this.scaffoldKey,
    required this.screenName,
    required this.onBackButtonPress,
    required this.appBarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kWhiteColor,
      elevation: 0,
      toolbarHeight: appBarHeight,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryDarkColor, kPrimaryLightColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
        ),
        child: Image.asset('assets/images/app-icon.png', width: 100,),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 110.0),
        child: screenName=="Dashboard" ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hello, ", style: TextStyle(color: kWhiteColor),),
            Image.asset('assets/icons/hand.png', width: 25,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 0),
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(UserSession.userModel.value.fullName,
                    style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w600, )),
                ),
              ),
            ),
          ],
        ) :
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(screenName, style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
