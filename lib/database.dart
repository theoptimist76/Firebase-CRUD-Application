import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Database {
  late FirebaseFirestore firestore;

  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String code) async {
    try {
      await firestore.collection("countries").add({
        "name": name,
        "code": code,
        "timestamp": FieldValue.serverTimestamp()
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("countries").doc(id).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  read() async {
    final QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('countries').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "code": doc['code']};
          docs.add(a);
          // return docs;
        }
        return docs;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> update(String id, String name, String code) async {
    try {
      await firestore
          .collection("countries")
          .doc(id)
          .update({"name": name, "code": code});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
