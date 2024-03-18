import 'package:cloud_firestore/cloud_firestore.dart';

class InformationSetter {
  static void setEmailReminder(String email) {
    FirebaseFirestore.instance
        .collection('informationReminder')
        .doc('email')
        .set({email: true}, SetOptions(merge: true));
  }
}
