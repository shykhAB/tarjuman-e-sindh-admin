/* Created By: Abdul Salam on 26-Nov-2024 */

import 'package:get/get.dart';
import 'package:tarjuman_e_sindh_admin/utils/user_session.dart';
import '../models/image_model.dart';

class BrowseImageController {

  RxString errorMessage=''.obs;
  String title;
  int maxLength;
  int minLength;
  String? hint;
  RxList<ImageModel> urls=RxList();
  RxList<ImageModel> deletedUrls = RxList();

  bool mandatory;

  BrowseImageController({required this.title, this.mandatory=true, this.maxLength=5, this.minLength=5, this.hint});

  bool validate(){
    if(mandatory && urls.isEmpty){
      errorMessage.value = "$title is Required!";
    } else if(mandatory && urls.length < minLength){
      // errorMessage.value = "Minimum $minLength Attachment${minLength == 1?' is': 's are'} Required!";
      errorMessage.value = "$minLength Attachment${minLength == 1?' is': 's are'} Required!";
    } else {
      UserSession.isDataChanged.value = true;
      errorMessage.value = "";
    }
    return errorMessage.isEmpty;
  }


}
