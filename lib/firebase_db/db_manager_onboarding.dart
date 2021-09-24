import 'package:cloud_firestore/cloud_firestore.dart';

class DBManagerOnboard{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static void firebaseUserUpload(String user) {
    var stl = db.collection('users');
    var now = DateTime.now();
    //String dateSlug = DateFormat('yyyy-MM-dd hh:mm:ss').format(now);
    stl.add({
      'name': user,
      'regDate': now
    }).then((value) => print("entered data"))
        .catchError((error) => print('This error occured "$error'));
  }
}