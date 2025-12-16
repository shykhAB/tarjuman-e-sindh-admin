import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response_model.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseClient {

  Future<dynamic> firebaseInsertRequest(
      {required dynamic model, required String collectionName, required String id}) async {
    try {
      String errorDis = '';
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(
          collectionName).doc(id).get();
      if (!doc.exists) {
        CollectionReference collectionReference = FirebaseFirestore.instance
            .collection(collectionName);
        await collectionReference.doc(id).set(model.toJson());
        errorDis = 'OK';
      } else {
        errorDis = 'ALREADY_EXISTS';
      }
      return ResponseModel.named(statusDescription: errorDis);
    } catch (e) {
      log('Error--------------------: $e');
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }

  Future<dynamic> firebaseUpdateRequest(
      {required dynamic model, required String collectionName, required String id}) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection(collectionName).doc(id);
      await documentReference.update(model.toJson());
      return ResponseModel.named(statusDescription: 'OK');
    } catch (e) {
      return ResponseModel.named(statusDescription: 'OTHER : $e');
    }
  }

  Future<dynamic> firebaseDeleteRequest(
      {required String collectionName, required String id}) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection(collectionName).doc(id);
      await documentReference.delete();
      return ResponseModel.named(statusDescription: 'OK');
    } catch (e) {
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }

  Future<dynamic> firebaseGetRequest({required String collectionName}) async {
    try {
      List<Map<String, dynamic>> listOfData = [];
      CollectionReference collectionRef = FirebaseFirestore.instance.collection(
          collectionName);
      QuerySnapshot snapshot = await collectionRef.get();
      for (var document in snapshot.docs) {
        if (document.exists) {
          Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
          if (data != null) {
            listOfData.add(data);
          }
        }
      }
      return listOfData;
    }catch(e){
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }

  Future<dynamic> firebaseGetSingleRequest({required String collectionName, required String id}) async {
    try {
      Map<String, dynamic> user = {};
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(collectionName).doc(id).get();
      if (doc.id.isNotEmpty) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          user = data;
        }
      }
      return user;
    }catch(e){
      log('Error-------------------------$e');
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }

  Future<dynamic> firebaseAuthUserRegisterRequest({required dynamic model}) async {
    String errorDis = '';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
      errorDis = 'OK';
      return ResponseModel.named(statusDescription: errorDis);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        errorDis = "ERROR_EMAIL_ALREADY_IN_USE";
      } else {
        errorDis = "OTHER";
      }
      return ResponseModel.named(statusDescription: errorDis);
    }
  }

  Future<dynamic> firebaseAuthUserSignInRequest({required dynamic model}) async {
    String errorDis = '';
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: model.email, password: model.password);
      errorDis = 'OK';
      return ResponseModel.named(statusDescription: errorDis);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorDis = "user-not-found";
      }else if (e.code == 'wrong-password') {
        errorDis = "wrong-password";
      }
      else if (e.code == 'invalid-credential') {
        errorDis = "invalid-login-credentials";
      }else {
        errorDis = "OTHER";
      }
      return ResponseModel.named(statusDescription: errorDis);
    }
  }

}