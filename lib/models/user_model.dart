import 'dart:convert';
import 'base_model.dart';


class UserModel extends BaseModel {
  String id = '';
  String fullName = "";
  String userName = "";
  String fatherName = "";
  String cnic = "";
  String age = "";
  String email = "";
  bool status = false;
  String phoneNumber = "";
  String file = "";
  String role = "";
  String password = "";
  List permissions = [];
  bool isRemembered = false;
  String center = "";
  String inspectorStatus = "";
  String accountType = "";
  String companyName = "";
  String ntnNo = "";
  String address = "";

  UserModel.empty();

  UserModel({required this.id,
    required this.fullName,
    required this.cnic,
    required this.email,
    required this.fatherName,
    required this.phoneNumber,
    required this.role,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    id = (json['user'] ?? {})['_id'] ?? '';
    fullName = (json['user'] ?? {})["firstname"] ?? "";
    fatherName = (json['user'] ?? {})["lastname"] ?? "";
    userName = (json['user'] ?? {})["username"] ?? "";
    // fatherName = json['user']["father_name"]??"";
    cnic = (json['user'] ?? {})["nic"] ?? "";
    // age = json['user']["age"]??"";
    email = (json['user'] ?? {})["email"] ?? "";
    status = (json['user'] ?? {})["status"] ?? false;
    phoneNumber = (json['user'] ?? {})["phonenumber"] ?? "";
    // file = json['user']["file"]??"";
    role = (json['user']["role"] ?? {})["role_name"] ?? "";
    // isRemembered = json['is_remembered'] ?? false;
    permissions = json["permissions"] ?? [];
    center = (json['user'] ?? {})['center'] ?? "";
    inspectorStatus =
        jsonEncode((json['user'] ?? {})['inspector_status'] ?? "");
    companyName = (json['user'] ?? {})['company_name'] ?? "";
    accountType = (json['user'] ?? {})['accountType'] ?? "";
    address = (json['user'] ?? {})['address'] ?? "";
    ntnNo = (json['user'] ?? {})['ntn'] ?? "";
  }

  UserModel.usersFromJson(Map<String, dynamic> json){
    id = json['_id'] ?? '';
    fullName = json["firstname"] ?? "";
    fatherName = json["lastname"] ?? "";
    userName = json["username"] ?? "";
    cnic = json["nic"] ?? "";
    email = json["email"] ?? "";
    status = json["status"] ?? false;
    phoneNumber = json["phonenumber"] ?? "";
    role = (json["role"] ?? {})["role_name"] ?? "";
    permissions = json["permissions"] ?? [];
    center = json['center'] ?? "";
    inspectorStatus = jsonEncode(json['inspector_status'] ?? "");
    companyName = json['company_name'] ?? "";
    accountType = json['accountType'] ?? "";
    address = json['address'] ?? "";
    ntnNo = json['ntn'] ?? "";
  }

  UserModel.fromOfflineJson(Map<String, dynamic> json) {
    id = '${json['id'] ?? ''}';
    fullName = '${json["firstname"] ?? ""}';
    fatherName = '${json["lastname"] ?? ""}';
    userName = '${json["username"] ?? ""}';
    cnic = '${json["nic"] ?? ""}';
    age = '${json["age"] ?? ""}';
    email = '${json["email"] ?? ""}';
    // status = '${json["status"] ?? ""}';
    phoneNumber = '${json["phonenumber"] ?? ""}';
    file = '${json["file"] ?? ""}';
    isRemembered = json['is_remembered'] ?? false;
    permissions = json["permissions"] ?? [];
    center = json["center"] ?? "";
    inspectorStatus = json["inspector_status"] ?? "";
    role = json["role"] ?? "";
    accountType = json["accountType"] ?? "";
    companyName = json["company_name"] ?? "";
    address = json["address"] ?? "";
    ntnNo = json["ntn"] ?? "";
  }

  Map<String, dynamic> toOfflineJson() {
    return {
      "id": id,
      "firstname": fullName,
      "lastname": fatherName,
      "username": userName,
      "email": email,
      "nic": cnic,
      "phonenumber": phoneNumber,
      "role": role,
      "is_remembered": isRemembered,
      "permissions": permissions,
      "center": center,
      "inspector_status": inspectorStatus,
      "accountType": accountType,
      "company_name": companyName,
      "ntn": ntnNo,
      "address": address
    };
  }


}


