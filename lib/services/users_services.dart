
import '../models/login_model.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';
import '../utils/firebase_client.dart';

class UserServices{
  Future<String> authenticateUser({required LoginModel loginModel})async{
    ResponseModel responseModel = await FirebaseClient().firebaseAuthUserRegisterRequest(model: loginModel);
    return responseModel.statusDescription;
  }

  Future<String> registerUser(UserModel userModel) async {
    ResponseModel responseModel = await FirebaseClient().firebaseInsertRequest(model: userModel, collectionName: kUserCollection, id: userModel.email);
    return responseModel.statusDescription;
  }

  Future<String> loginUser(LoginModel loginModel)async{
    ResponseModel responseModel = await FirebaseClient().firebaseAuthUserSignInRequest(model: loginModel);
    return responseModel.statusDescription;
  }

  Future<dynamic> getUser(String email) async {
    dynamic response = await FirebaseClient().firebaseGetSingleRequest(collectionName: kUserCollection, id: email);
    return response;
  }

  Future<String> updateUser(UserModel userModel)async{
    ResponseModel responseModel = await FirebaseClient().firebaseUpdateRequest(model: userModel, collectionName: kUserCollection, id: userModel.id);
    return responseModel.statusDescription;
  }

}