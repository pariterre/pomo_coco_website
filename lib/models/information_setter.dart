import 'package:cloud_firestore/cloud_firestore.dart';

class InformationSetter {
  static Future<void> setEmailReminder(String email) async {
    await FirebaseFirestore.instance
        .collection('informationReminder')
        .doc('email')
        .set({email: true}, SetOptions(merge: true));
  }
}
