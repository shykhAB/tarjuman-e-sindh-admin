import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../utils/app_colors.dart';


class CustomDialogs {
  static final CustomDialogs _instance = CustomDialogs._internal();

  CustomDialogs._internal();

  factory CustomDialogs() => _instance;

  static bool isDialogVisible = false;

  void confirmationDialog({required String message, required Function yesFunction}) {
    const double padding = 10.0;
    const double avatarRadius = 66.0;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                top: padding + 10,
                bottom: padding,
                left: padding + 10,
                right: padding,
              ),
              margin: const EdgeInsets.only(top: avatarRadius),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(padding),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // To make the card compact
                children: <Widget>[
                  const Text(
                    "Confirmation",
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    message,
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Text(
                              "NO",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            yesFunction();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 15, top: 5, bottom: 5),
                            child: Text(
                              "YES",
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }



  void showAppUpdateDialog(
      String title, String description,
      {Function? onOkBtnPressed, bool dismissible = true, String features=''}) {
    AwesomeDialog(
      onDismissCallback: (type) => {},
      autoDismiss: dismissible,
      dismissOnBackKeyPress: dismissible,
      btnOkText: "UPDATE",
      btnCancelText: 'LATER',
      context: Get.context!,
      dismissOnTouchOutside: false,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      btnOkColor: kGreenColor,
      customHeader: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(100),topRight: Radius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("assets/images/gos_logo_black.png")
          ),
        ),
      ),
      title: title,
      desc: description,
      body: features.isEmpty ? null :
      Column(
        children: [
          Text(title,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text(description,style: const TextStyle(fontSize: 12),textAlign: TextAlign.center),
          const SizedBox(height: 18),
          const Text("What's New",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(color: kFieldGreyColor,borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  for(String f in  features.split(';'))
                  Container(
                    margin: const EdgeInsets.only(top: 4, right: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4, left: 10,right: 10),
                          child: Icon(Icons.double_arrow, size: 8,),
                        ),
                        Flexible(child: Text(f.trim(), style: const TextStyle(fontSize: 13,letterSpacing: -0.3),)),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      )
      ,
      btnOkOnPress: () {
        if (onOkBtnPressed != null) {
          onOkBtnPressed();
        }
      },
      btnCancelColor: const Color(0xffefa632),
      btnCancelOnPress: dismissible ? (){} :  null,
    ).show();
  }




  void showDialog(
      String title,
      String description,
      DialogType type, {
        Function? onOkBtnPressed,
      }) {
    if (!isDialogVisible) {
      isDialogVisible = true;

      AwesomeDialog(
        dismissOnBackKeyPress: false,
        context: Get.context!,
        dialogType: type,
        headerAnimationLoop: false,
        animType: AnimType.scale,
        btnOkColor: type == DialogType.success ? null /*kPrimaryColor*/ :
            type == DialogType.error ? kRequiredRedColor : kYellowColor,
        title: title,
        dismissOnTouchOutside: false,
        desc: capitalizeEachWord(description),
        btnOkOnPress: () {
          if (onOkBtnPressed != null) {
            onOkBtnPressed();
          }
          isDialogVisible = false;
        },
      ).show();
    }
  }

  String capitalizeEachWord(String input) {
    return input
        .splitMapJoin(
      RegExp(r'([^\s\n]+)'),
      onMatch: (m) {
        String word = m.group(0)!;
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      },
      onNonMatch: (n) => n,
    );
  }



  void showAwesomeConfirmationDialog(String message, {Function? onOkBtnPressed, String? title}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      btnOkColor: kGreenColor,
      dismissOnTouchOutside: false,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            title != null?Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
              ),
            ):SizedBox(),
          ],
        ),
      ),
      customHeader: Container(
        margin: const EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
            child: Image.asset("assets/images/app-icon.png", color: kPrimaryDarkColor,)
        ),
      ),
      btnOkText: 'YES',
      btnOkOnPress: () {
        if (onOkBtnPressed != null) {
          onOkBtnPressed();
        }
      },
      btnCancelColor: kRequiredRedColor,
      btnCancelOnPress: () {
        // Get.back();
      },
      btnCancelText: 'NO',
    ).show();
  }

  void showErrorDialog(String title, String description, DialogType type, Color btnOkColor, {Function? onOkBtnPressed,bool dismissible = true}) {
    AwesomeDialog(
      dismissOnBackKeyPress: false,
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      btnOkColor: btnOkColor,
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      // customHeader: Container(
      //     margin: const EdgeInsets.all(12.0),
      //     child: Image.asset("assets/icons/logo2.png", color: kPrimaryColor,)),
      btnOkOnPress: () {
        if(onOkBtnPressed != null ){onOkBtnPressed();}
      },
    ).show();
  }

  void verifyCNICDialog(
      String title, String description, DialogType type, Color btnOkColor,
      {Function? onOkBtnPressed,bool dismissible = true, Function? onCancelBtnPressed}) {
    AwesomeDialog(
      onDismissCallback: (type) => {},
      autoDismiss: dismissible,
      dismissOnBackKeyPress: dismissible,
      btnOkText: "EDIT",
      btnCancelText: 'NEXT',
      context: Get.context!,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      btnOkColor: btnOkColor,
      title: title,
      dismissOnTouchOutside: false,
      desc: description,
      btnOkOnPress: () {
        if (onOkBtnPressed != null) {
          onOkBtnPressed();
        }
      },
      btnCancelColor: kPrimaryColor,
      btnCancelOnPress:(){
        if(onCancelBtnPressed != null){
          onCancelBtnPressed();
        }
      },
    ).show();
  }

}
