// import 'package:mind_healing_app/models/hospital_model.dart';
// import 'package:mind_healing_app/utils/constants.dart';
//
// import '../models/response_model.dart';
// import '../utils/firebase_client.dart';
//
// class HospitalServices{
//
//   Future<List<HospitalModel>> getAllHospitals()async{
//     List<HospitalModel> hospitals = [];
//     var data = await FirebaseClient().firebaseGetRequest(collectionName: kHospitalCollection);
//     if(data is List){
//       for(var i in data){
//         hospitals.add(HospitalModel.fromJson(i));
//       }
//     }
//     else{
//       hospitals = [];
//     }
//     return hospitals;
//   }
//
//   Future<String> addHospital(HospitalModel hospitalModel) async {
//     ResponseModel responseModel = await FirebaseClient().firebaseInsertRequest(model: hospitalModel, collectionName: kHospitalCollection, id: hospitalModel.hospitalId.toString());
//     return responseModel.statusDescription;
//   }
//
//   Future<String> updateHospital(HospitalModel hospitalModel)async{
//     ResponseModel responseModel = await FirebaseClient().firebaseUpdateRequest(model: hospitalModel, collectionName: kHospitalCollection, id: hospitalModel.hospitalId.toString());
//     return responseModel.statusDescription;
//   }
//
//   Future<String> deleteHospital({required String id})async{
//     ResponseModel responseModel = await FirebaseClient().firebaseDeleteRequest(collectionName: kHospitalCollection, id: id);
//     return responseModel.statusDescription;
//   }
// }