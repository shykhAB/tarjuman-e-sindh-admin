import 'package:get/get.dart';
import '../models/image_model.dart';

class BrowseDocumentController{
  RxString errorMessage=''.obs;
  String title;
  String? hint;
  Rx<ImageModel> document = ImageModel.empty().obs;
  bool mandatory;
  List<String> allowedExtensions = ['image/png', 'image/jpg', 'image/jpeg', 'application/pdf'];
  String requestType;

  BrowseDocumentController({required this.title, this.mandatory=true, this.hint, this.requestType='default'});

  bool validate(){
    if(mandatory && (document.value.path.isEmpty && document.value.imageData.isEmpty)){
      errorMessage.value = isTitleUrdu ? "$title ضروری ہے " : "$title is Required!";
    } else if(mandatory && !allowedExtensions.contains(document.value.mimeType)){
      errorMessage.value = isTitleUrdu? "${document.value.name} غلط فائل کی قسم منتخب کی گئی ہے: ":"Invalid file type: ${document.value.name}";
    }else {
      errorMessage.value = "";
    }
    return errorMessage.isEmpty;
  }

  void clear(){
    document.value = ImageModel.empty();
  }

  bool get isTitleUrdu => RegExp(r'[\u0600-\u06FF]').hasMatch(title);
}