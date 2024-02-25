import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomo_coco_website/models/item_serializable.dart';

abstract mixin class FirebaseUpdater<T extends ItemSerializable> {
  /// The path to the stored data inside the database.
  String get pathToData;
  Duration get updateInterval;

  bool _isInitialized = false;
  final Map<String, Map<String, dynamic>> _pendingItems = {};

  T deserialize(String id, Map<String, dynamic> map);

  void updateAllItems(List<T> items);

  Future<void> initializeFirebaseUpdater() async {
    _dataRef.doc('results').get().then((doc) {
      if (doc.exists) {
        final data = doc.data()!['all'] as Map<String, dynamic>?;
        if (data == null) return;
        updateAllItems(
            data.keys.map((key) => deserialize(key, data[key]!)).toList());
      }
    });

    _dataRef.snapshots().listen((querySnapshot) {
      // Serialize the current item and update the new value
      if (querySnapshot.docChanges.isEmpty) return;

      final data = querySnapshot.docChanges[0].doc.data()?['all']
          as Map<String, dynamic>?;
      if (data == null) return;

      updateAllItems(
          data.keys.map((key) => deserialize(key, data[key]!)).toList());
    });

    Timer.periodic(updateInterval, (timer) async {
      if (_pendingItems.isEmpty) return;

      await _dataRef
          .doc('results')
          .set({'all': _pendingItems}, SetOptions(merge: true));
      _pendingItems.clear();
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
    _pendingItems[value.id] = map;
  }

  // Firebase Reference getters
  CollectionReference<Map<String, dynamic>> get _dataRef =>
      FirebaseFirestore.instance.collection(pathToData);
}
