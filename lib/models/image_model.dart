
import '../utils/user_session.dart';


class ImageModel {
   String id='';
   String path='';
   String name='';
   String createdAt='';
   String createdBy = '';
   String mimeType = '';
   String imageData = '';
   String deletedAt = '';
   String deletedBy = '';
   bool isSynced = false;
   String fileType = '';
   String parentId = '';
   String parentType = '';
   int? localId;

  ImageModel({
    this.id = '',
    required this.path,
    this.createdAt = '',
    this.name = '',
    this.mimeType = '',
    this.createdBy = '',
    this.imageData = '',
    this.isSynced = false,
    this.fileType = '',
  });
  ImageModel.empty();

   ImageModel copyWith({
     String? id,
     String? filePath,
     String? name,
     String? createdAt,
     String? createdBy,
     String? mediaType,
     String? imageData,
   }) {
     return ImageModel(
       id: id ?? this.id,
       path: filePath ?? path,
       name: name ?? this.name,
       createdAt: createdAt ?? this.createdAt,
       createdBy: createdBy ?? this.createdBy,
       mimeType: mediaType ?? mimeType,
       imageData: imageData ?? this.imageData,
     );
   }

  ImageModel.fromJson(Map<String, dynamic> json):
    imageData = json['fileData']?? (json['data'] ?? ''),
    mimeType = json['mimeType'] ?? '',
    fileType = json['fileType'] ?? (json['documentType'] ?? ''),
    name = json['fileName'] ??'';

   ImageModel.fromJsonChallan(Map<String, dynamic> json):
         imageData = json['data']??'',
         mimeType = json['mimetype'] ?? '',
         name = json['filename'] ??'',
         fileType = json['filetype'] ?? '';


  Map<String, String> toJson(){
    return {
      'mimeType': mimeType,
      'fileName':name,
      'fileData':imageData,
    };
  }


  @override
  String toString() {
    return 'ImageModel{name: $name, mimeType: $mimeType, fileType: $fileType}';
  }
}