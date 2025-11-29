// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import '';

class FirestoreService {
  get Timestamp => null;

  Future<void> saveEntry(String title, String text, String? imagePath) async {
    await FirebaseFirestore.instance.collection("diario").add({
      "title": title,
      "text": text,
      "imagePath": imagePath,
      "createdAt": Timestamp.now(),
    });
  }
}

class   FirebaseFirestore {
  static final FirebaseFirestore instance = FirebaseFirestore._internal();

  FirebaseFirestore._internal();

  CollectionReference collection(String name) {
    return CollectionReference();
  }
}

class CollectionReference {
  Future<void> add(Map<String, dynamic> data) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));
  }
}


