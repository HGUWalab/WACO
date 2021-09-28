import 'package:cloud_firestore/cloud_firestore.dart';

class MainModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static dynamic dataDD;

  //문서까지 접근해서 특정 필드 가져오기
  static Future<bool> getMachineState(String dormNumber, String floor, String machineName) async {
    bool available = false;
    var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floor).doc(machineName)
    .get().then((value) {
      print(value.data()!['state']);
    });
    return available;
  }

  //데이터를 받아올 때 await를 꼭 써줘야한다. 안그러면 값이 전달되기 전에 실행되버린다.
  static Future<int> getMachineCount(String dormNumber, String floor, String machineKind) async {
    int count = 0;
    var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floor).doc('machineCount')
        .get().then((value) {
      count = value.data()![machineKind];
    });

    return count;
  }
}