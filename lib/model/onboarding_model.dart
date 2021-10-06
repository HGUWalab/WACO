//This class is made to handle firebase in Onboarding page.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OnboardingModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static void firebaseUserUpload(String user) {
    var stl = db.collection('users');
    var now = DateTime.now();
    String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);    stl.add({
      'name': user,
      'regDate': dateFormat
    });
  }
}