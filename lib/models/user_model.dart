class UserModel{
  String id = '';
  String name = "";
  String email = "";
  String contact = "";
  String city = "";
  String cnic = "";

  UserModel.empty();


  UserModel.fromJson(Map<String, dynamic> json){
    id = json["id"] ?? '';
    name = json["name"] ?? "";
    email = json["email"] ?? "";
    contact = json["contact"] ?? "";
    city = json["city"] ?? "";
    cnic = json["cnic"] ?? "";
  }

  Map<String, dynamic> toJson(){
    return{
      "id" : id,
      "name" : name,
      "email" : email,
      "contact" : contact,
      "city" : city,
      "cnic" : cnic,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, contact: $contact, city: $city, cnic: $cnic}';
  }
}