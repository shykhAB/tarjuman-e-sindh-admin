import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreMigration{

  Future<void> migrate({required String collection, required String newFieldName}) async {
   try{
     FirebaseFirestore fireStore = FirebaseFirestore.instance;
     CollectionReference cr = fireStore.collection(collection);

     QuerySnapshot querySnapshot = await cr.get();
     for (QueryDocumentSnapshot doc in querySnapshot.docs) {
       await doc.reference.update({
         newFieldName: '',
       });
     }
     log('-----------------------------++++>>>>>Migration completed.');
   }catch(e){
     log('EXCEPTION While Migration---------------------------++++>>>>>$e');
   }

  }
}