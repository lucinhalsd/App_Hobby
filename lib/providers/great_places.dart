// pega os itens do provider

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';
import '../models/place_location.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items => [..._items];

  /// Carrega DO FIRESTORE
  Future<void> loadPlaces() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('places')
        .where('userId', isEqualTo: userId)
        .get();

    _items.clear();

    for (var doc in snapshot.docs) {
      _items.add(
        Place(
          id: doc.id,
          title: doc['title'],
          imageUrl: doc['imageUrl'],
          location: PlaceLocation(
            latitude: doc['latitude'],
            longitude: doc['longitude'],
          ),
        ),
      );
    }

    notifyListeners();
  }

  /// Salvar uma nova viagem
  Future<void> addPlace(String title, File image) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Upload da imagem no Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('places')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await storageRef.putFile(image);
    final imageUrl = await storageRef.getDownloadURL();

    // Dados no Firestore
    final docRef = await FirebaseFirestore.instance.collection('places').add({
      'title': title,
      'imageUrl': imageUrl,
      'latitude': 0, // você pode mudar depois
      'longitude': 0,
      'userId': userId,
    });

    _items.add(
      Place(
        id: docRef.id,
        title: title,
        imageUrl: imageUrl,
        location: PlaceLocation(latitude: 0, longitude: 0),
      ),
    );

    notifyListeners();
  }
}


