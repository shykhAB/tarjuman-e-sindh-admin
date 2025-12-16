import 'package:firebase_auth/firebase_auth.dart';

import '../models/response_model.dart';

class ForgotPasswordService {


  Future<ResponseModel> sendEmail({required String email}) async {
    String errorMsg = '';
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      errorMsg = 'OK';
      return ResponseModel.named(statusDescription: errorMsg);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMsg = "user-not-found";
      }
      return ResponseModel.named(statusDescription: errorMsg);
    }
  }

}