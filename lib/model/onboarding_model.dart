//This class is made to handle firebase in Onboarding page.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wacoproject/utils/user.dart';


class OnboardingModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static void firebaseUserUpload(String user) async {
    var uuid = Uuid();
    var documentId = uuid.v4();
    var stl = db.collection('users');
    var now = DateTime.now();
    String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    stl
      .doc(documentId).set({
      'name': user,
      'regDate': dateFormat
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userName', user);
    pref.setString('documentId', documentId);
    pref.setBool('isLoggedIn', true);
  }

  static Future<List<String>> getDormFloor(String dormNumber) async{
    List<String> floors = [];
    int floor = 0;
    var collection = await db.collection('dormAndFloor').doc(dormNumber)
        .get().then((value) {
      floor = value.data()!['floor'];
      if(dormNumber=='5'){
        for(int i = 3; i <= floor; i++){
          floors.add(i.toString()+"층");
        }
      }else{
        for(int i = 1; i <= floor; i++){
          floors.add(i.toString()+"층");
        }
      }
    });
    return floors;
  }
}