import 'dart:convert';
import 'package:tarjuman_e_sindh_admin/models/image_model.dart';

class EPaperModel{
  int id = -1;
  ImageModel image = ImageModel.empty();
  String createdAt = '';
  String createdBy = '';
  String createdByName = '';

  bool get isEmpty => (id==-1);

  EPaperModel({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.createdBy,
  });

  EPaperModel.empty();

  EPaperModel.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? -1;
    if(json['image'] != null){
      image = ImageModel.fromJson(jsonDecode(json['image']) ?? {});
    }
    createdAt = json['createdAt'] ?? "";
    createdBy = json['createdBy'] ?? "";
    createdByName = json['createdByName'] ?? "";

  }

  Map<String, dynamic> toJson(){
    return {
      "news_id" : id,
      "image" : jsonEncode(image.toJson()),
      "createdAt" : createdAt,
      "createdBy" : createdBy,
      "createdByName" : createdByName,
    };
  }



}