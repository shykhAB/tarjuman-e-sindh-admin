import 'dart:convert';
import 'package:tarjuman_e_sindh_admin/models/image_model.dart';

class NewsModel{
  int id = -1;
  String heading = '';
  String detail = '';
  ImageModel image = ImageModel.empty();
  String category = '';
  String createdAt = '';
  String createdBy = '';
  String createdByName = '';

  bool get isEmpty => (id==-1);

  NewsModel({
    required this.id,
    required this.heading,
    required this.detail,
    required this.image,
    required this.category,
    required this.createdAt,
    required this.createdBy,
  });

  NewsModel.empty();

  NewsModel.fromJson(Map<String, dynamic> json){
    id = json['news_id'] ?? -1;
    heading = json['heading'] ?? "";
    detail = json['detail'] ?? "";
    if(json['image'] != null){
      image = ImageModel.fromJson(jsonDecode(json['image']) ?? {});
    }
    category = json['category'] ?? "";
    createdAt = json['createdAt'] ?? "";
    createdBy = json['createdBy'] ?? "";
    createdByName = json['createdByName'] ?? "";

  }

  Map<String, dynamic> toJson(){
    return {
      "news_id" : id,
      "heading" : heading,
      "detail" : detail,
      "image" : jsonEncode(image.toJson()),
      "category" : category,
      "createdAt" : createdAt,
      "createdBy" : createdBy,
      "createdByName" : createdByName,
    };
  }

  @override
  String toString() {
    return 'NewsModel{id: $id, heading: $heading, detail: $detail, image: $image, category: $category, createdAt: $createdAt, createdBy: $createdBy, createdByName: $createdByName}';
  }


}