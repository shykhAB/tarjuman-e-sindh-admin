import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../models/response_model.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import '../models/weekly_graph_model.dart';

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

  Future<dynamic> firebaseGetLastSevenDaysCount({required String collectionName}) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(sevenDaysAgo),).get();
      return snapshot.docs.length;
    } catch (e) {
      log('Last 7 days count error: $e');
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }


  Future<dynamic> firebaseGetWeeklyGraphData({required String collectionName,}) async {
    try {
      final DateTime now = DateTime.now();
      final DateTime sevenDaysAgo = now.subtract(const Duration(days: 6));
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).where('createdAt', isGreaterThanOrEqualTo: sevenDaysAgo.toString()).get();
      Map<String, WeeklyGraphModel> graphMap = {};
      for (int i = 0; i < 7; i++) {
        DateTime date = now.subtract(Duration(days: i));
        String key = _dateKey(date);
        graphMap[key] = WeeklyGraphModel(
          day: _dayName(date),
          date: date,
          count: 0,
        );
      }

      for (var doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final createdAt = data['createdAt'];
          if (createdAt == null) {
            log('Document ${doc.id} has null createdAt, skipping');
            continue;
          }
          DateTime date;
          if (createdAt is String) {
            try {
              date = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(createdAt);
            } catch (_) {
              try {
                date = DateTime.parse(createdAt);
              } catch (e) {
                log('Document ${doc.id} has invalid date format: $createdAt');
                continue;
              }
            }
          } else if (createdAt is Timestamp) {
            date = createdAt.toDate();
          } else {
            log('Document ${doc.id} createdAt is neither String nor Timestamp: ${createdAt.runtimeType}');
            continue;
          }

          String key = _dateKey(date);

          if (graphMap.containsKey(key)) {
            final old = graphMap[key]!;
            graphMap[key] = WeeklyGraphModel(
              day: old.day,
              date: old.date,
              count: old.count + 1,
            );
          }
        } catch (e) {
          log('Error processing document ${doc.id}: $e');
        }
      }

      List<WeeklyGraphModel> graphList = graphMap.values.toList()..sort((a, b) => a.date.compareTo(b.date));
      return graphList;
    } catch (e, s) {
      log('Weekly graph error: ${s.toString()}');
      return ResponseModel.named(statusDescription: 'OTHER');
    }
  }

  String _dateKey(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  String _dayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }



}