import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomo_coco_website/models/item_serializable.dart';

abstract mixin class FirebaseUpdater<T extends ItemSerializable> {
  /// The path to the stored data inside the database.
  String get pathToData;

  bool _isInitialized = false;

  T deserialize(String id, Map<String, dynamic> map);

  void updateAllItems(List<T> items);

  Future<void> initializeFirebaseUpdater() async {
    _dataRef.doc('results').get().then((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        updateAllItems(
            data.keys.map((key) => deserialize(key, data[key]!)).toList());
      }
    });

    _dataRef.snapshots().listen((querySnapshot) {
      // Serialize the current item and update the new value
      final data = querySnapshot.docChanges[0].doc.data();
      if (data == null) return;
      updateAllItems(
          data.keys.map((key) => deserialize(key, data[key]!)).toList());
    });

    _isInitialized = true;
  }

  ///
  /// Adds an item to the Realtime Database.
  void setToDatabase(T value) async {
    if (!_isInitialized) {
      throw Exception(
          'The FirebaseUpdater is not initialized. Please call initialize() before using it.');
    }

    final map = value.serializedMap;
    await _dataRef.doc('results').set({value.id: map}, SetOptions(merge: true));
  }

  // Firebase Reference getters
  CollectionReference<Map<String, dynamic>> get _dataRef =>
      FirebaseFirestore.instance.collection(pathToData);
}
