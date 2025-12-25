


class ImageModel {
   String id='';
   String path='';
   String name='';
   String mimeType = '';
   String imageData = '';

  ImageModel({
    this.id = '',
    required this.path,
    this.name = '',
    this.mimeType = '',
    this.imageData = '',
  });
  ImageModel.empty();


  ImageModel.fromJson(Map<String, dynamic> json):
    imageData = json['fileData']?? (json['data'] ?? ''),
    mimeType = json['mimeType'] ?? '',
    name = json['fileName'] ??'';


  Map<String, String> toJson(){
    return {
      "mimeType": mimeType,
      "fileName": name,
      "fileData": imageData,
    };
  }


  @override
  String toString() {
    return 'ImageModel{name: $name, mimeType: $mimeType}';
  }
}