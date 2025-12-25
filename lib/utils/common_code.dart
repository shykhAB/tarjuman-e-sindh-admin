import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'date_time_manager.dart';



class CommonCode {

  Uint8List decodeImage(String imagePath){
    Uint8List image = base64Decode(imagePath);
    return image;
  }

  bool checkIsTimeAfterOrEqual(String time) {
    String splittedTime = _getTime(time);
    DateFormat dateFormat = DateFormat("HH:mm");
    DateTime now = DateTime.now();
    DateTime firstTime = dateFormat.parseStrict(splittedTime).copyWith(year: now.year, month: now.month, day: now.day);
    DateTime currentTime = now;
    return currentTime.isAfter(firstTime);
  }

  String _getTime(String timeRange) {
    List<String> times = timeRange.split("-");
    if (times.isNotEmpty) {
      return times[0];
    } else {
      throw const FormatException("Invalid time range format");
    }
  }

  bool isDateTodayOrBefore(String dateString) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateTime now = DateTime.now();
    try {
      DateTime inputDate = dateFormat.parseStrict(dateString);
      return inputDate.isBefore(now) ||
          (inputDate.year == now.year &&
              inputDate.month == now.month &&
              inputDate.day == now.day);
    } catch (e) {
      return false;
    }
  }

  String getQueryNameByQuery(String query) {
    final queryNameRegex = RegExp(r'(query|mutation)\s+(\w+)\s*');
    final match = queryNameRegex.firstMatch(query);
    if (match != null && match.groupCount >= 2) {
      return match.group(2)!;
    }
    return '';
  }

  void getDateDifferenceInDays(String dateString, DateTimeManager dateField) {
    try{
      DateTime inputDate = DateTime.parse(
        dateString.split('-').reversed.join('-'),
      );
      DateTime currentDate = DateTime.now();
      DateTime today = DateTime(currentDate.year, currentDate.month, currentDate.day);
      DateTime formattedInput = DateTime(inputDate.year, inputDate.month, inputDate.day);
      Duration difference = today.difference(formattedInput);
      if(difference.inDays > 0 || difference.inDays == 0){
        dateField.firstDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-difference.inDays);
      }
    }catch(_){}
  }

  Future<File> compressImage(File file,{int quality=35}) async {
    double sizeKb = (file.lengthSync() / 1000).toPrecision(2);
    CommonCode().showToast(message: 'ImageSize: $sizeKb KB');
    CompressFormat compressFormat = CompressFormat.jpeg;
    try {
      final filePath = file.absolute.path;
      int lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      if (lastIndex == -1) {
        lastIndex = filePath.lastIndexOf(RegExp(r'.png'));
        compressFormat = CompressFormat.png;
      }
      final imageSplit = filePath.substring(0, (lastIndex));
      final outPath = "${imageSplit}_out${filePath.substring(lastIndex)}";
      XFile? compressedXImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          quality: quality, format: compressFormat);

      if (compressedXImage != null) {
        File compressedImage = File(compressedXImage.path);
        double sizeKb = (compressedImage.lengthSync() / 1000).toPrecision(2);
        CommonCode().showToast(message: 'ImageSize: $sizeKb KB');
        return compressedImage;
      } else {
        return file;
      }
    } catch (e) {
      return file;
    }
  }

  String convertDateFromMilliseconds(dynamic date){
      int milliseconds = date is int ? date : int.tryParse(date) ??0;
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
      return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  String convertTimeFromMilliseconds(dynamic date) {
    int milliseconds = date is int ? date : int.tryParse(date) ?? 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  void showToast({required String message, bool showLong = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: showLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xF9454141),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  Future<bool> checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    return /*result == ConnectivityResult.mobile || result == ConnectivityResult.wifi*/true;
  }

  Future<bool> checkInternetAccess() async {
    try {
      if(await checkInternetConnection()) {
        http.Response response =
        await http.get(Uri.parse("https://www.google.com/"))
            .timeout(const Duration(seconds: 5));
        return response.body.length > 4;
      }
    } catch (_) {}
    return false;
  }


  Future<ui.Image> loadImage(Uint8List img) async {
    return decodeImageFromList(img);
  }

  Future<ui.Image> decodeImageFromList(Uint8List bytes) async {
    final ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final ui.Codec codec = await PaintingBinding.instance.instantiateImageCodecWithSize(buffer);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  ///
  /// This method check for latest version on Database and Navigate user to Play Store for Update Application.
  /// - If version is necessary then Popup will not be removed until App is Updated.
  ///
  // Future<void> checkForUpdate() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String appVersion = packageInfo.version;
  //   VersionCheckModel latestVersion = await GeneralService().getVersionData();
  //   if (Platform.isAndroid && latestVersion.androidVersion.isNotEmpty) {
  //     String version = latestVersion.androidVersion;
  //     if (appVersion.compareTo(version).isNegative) {
  //       CustomDialogs().showDialog(
  //           "Version Update Available",
  //           "New version $version is available.\n${latestVersion.isNecessary?'It is Necessary to':'Please'} Update it.",
  //           DialogType.SUCCES,
  //           const Color(kPrimaryColor),
  //           dismissible: !(latestVersion.isNecessary),
  //           onOkBtnPressed: openStore);
  //     }
  //   }
  // }

  // void openStore() {
  //   launchUrl(//https://play.google.com/store/apps/details?id=pk.gos.spsu.mobileApp
  //     Uri.parse("market://details?id=pk.gos.spsu.mobileApp"),
  //     mode: LaunchMode.externalNonBrowserApplication,
  //   );
  // }

  Future<String> saveImage({required String url,bool greaterThanEleven = false, String imageData= ''}) async {
    Directory? directory;
    String fileSavingName = "file.pdf";
    String newPath = "";
    try {
      if (Platform.isAndroid) {
        String appendDate = "${DateTime.now().microsecond}";
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          List<String> paths = directory!.path.split("/");
          List<String> urlList = url.split("/");
          // String downloadFileName = urlList.last;
          // fileSavingName = "${downloadingModelList[indexOfCurrentFileBeingDownloaded].bankTransactionNoOfFile.value}"+"_${appendDate}_"+urlList.last;
          fileSavingName = "_${appendDate}_${urlList.last}";
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          if (!greaterThanEleven) {
            newPath = "$newPath/Download/SFERPApp";
          }else{
            newPath = "$newPath/Download/";
          }
          directory = Directory(newPath);
        } else {
          return "";
        }
      } else {
        if (await requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return "";
        }
      }
      File saveFile = File("${directory.path}/$fileSavingName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        //downloading
         var response =await http.get(Uri.parse(url));
         saveFile.writeAsBytes(response.bodyBytes);
        saveFile.writeAsBytes(base64Decode(imageData));
        //downloaded
        //for ios
        // if (Platform.isIOS) {
        //   await ImageGallerySaver.saveFile(saveFile.path,
        //       isReturnPathOfIOS: true);
        // }
        return "$newPath/$fileSavingName";
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }


}
