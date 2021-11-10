import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';
import 'package:flutter/material.dart';

class FirebaseData extends StatefulWidget {
  const FirebaseData({Key? key}) : super(key: key);

  @override
  _FirebaseDataState createState() => _FirebaseDataState();
}

class _FirebaseDataState extends State<FirebaseData> {
  @override
  Widget build(BuildContext context) {
    FirebaseReset FR = new FirebaseReset();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: FlatButton(
              child: Text(
                "갈대1 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(0, "galdae1", 5, 1, 1);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "갈대2 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(1, "galdae2", 5, 1, 1);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "로뎀 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(2, "lothem", 5, 2, 2);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "비전 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(3, "vision", 5, 2, 2);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "은혜 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(4, "grace", 5, 2, 2);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "하용조 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(5, "hayongjo", 10, 4, 2);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "벧엘 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(6, "bethel", 6, 2, 2);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "창조 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(7, "creation", 5, 1, 1);
              }),
            ),
          ),
          Center(
            child: FlatButton(
              child: Text(
                "국제 Firebase 초기화",
                style: body4style(color: Colors.black),
              ),
              onPressed: (() {
                FR.resetFirebase(8, "global", 3, 3, 2);
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class FirebaseReset {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void resetFirebase(int dormAndFloor, String dormName, int floor, int setakki, int gunjoki) {
    var stl = db.collection('dormAndFloor');
    //dormAndFloor랑 field로 이름이랑 층수 제작
    stl.doc("$dormAndFloor").set({'dormName': dormName, 'floor': floor});

    //setakki 입력 수 만큼 제작
    for (int i = 1; i <= floor; i++) {
      for(int j = 1; j <= setakki; j++){
        stl.doc("$dormAndFloor").collection("$i").doc("$j" + "setakki")
            .set({
          'endTime': "none",
          'inputTime': 0,
          'name': "",
          'state': true,
          'userID': ""
        });
      }
    }

    //gunjoki 입력 수 만큼 제작
    for (int i = 1; i <= floor; i++) {
      for(int j = 1; j <= gunjoki; j++){
        stl.doc("$dormAndFloor").collection("$i").doc("$j" + "gunjoki")
            .set({
          'endTime': "none",
          'inputTime': 0,
          'name': "",
          'state': true,
          'userID': ""
        });
      }
    }

    //machineCount제작
    for(int i = 1; i <= floor; i++){
      stl.doc("$dormAndFloor").collection("$i").doc("machineCount")
          .set({
        'availablegunjoki': gunjoki,
        'availablesetakki': setakki,
        'gunjokiCount': gunjoki,
        'setakkiCount': setakki
      });
    }

  }
}
