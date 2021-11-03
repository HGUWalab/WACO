import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wacoproject/model/empty_model.dart';

class MainModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<String> getUserName(String dormNumber, String floor, String machineName) async{
    String userName = '';
    try{
      var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floor).doc(machineName)
          .get().then((value) {
        userName = value.data()!['name'];
      });
    }catch(e){}
    return userName;
  }

  static Future<String> getUserID(String dormNumber, String floor, String machineName) async{
    String userID = '';
    try{
      var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floor).doc(machineName)
          .get().then((value) {
        userID = value.data()!['userID'];
      });
    }catch(e){}
    return userID;
  }

  static Future<int> getStateCount(String dormNumber, String dormFloor, String machineKind) async{
    int machineCount = await MainModel.getMachineCount(dormNumber, dormFloor, machineKind);
    int availableCount = 0;
    for(int i = 1; i <= machineCount; i++) {
      bool available = await MainModel.getMachineState(
          dormNumber, dormFloor, "$i$machineKind");
      if (available == true) availableCount++;
    }
    return availableCount;
  }
  //문서까지 접근해서 특정 필드 가져오기
  static Future<bool> getMachineState(String dormNumber, String floor, String machineName) async {
    bool available = false;
    try{
      var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floor).doc(machineName)
          .get().then((value) {
        available = value.data()!['state'];
      });
    }catch(e){}
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

  static Future<void> checkDoneMachine(String dormNumber, String floor, String machineName)async {
    int timeLeft = await EmptyModel.getTimeLeft(dormNumber, floor, machineName);
    if(timeLeft < 0 ){
      EmptyModel.changeState(dormNumber, floor, machineName, "0");
    }
  }


  static String getPageName(int dorm, int floor){
    String pageName = '';
    switch(dorm){
      case 0: pageName = '갈대상자관 '; break;
      case 1: pageName = '국제관 '; break;
      case 2: pageName = '로뎀관 '; break;
      case 3: pageName = '비전관 '; break;
      case 4: pageName = '은혜관 '; break;
      case 5: pageName = '하용조관 '; break;
      case 6: pageName = '벧엘관 '; break;
      case 7: pageName = '창조관 '; break;
    }
    pageName = pageName + "$floor" + "층";
    return pageName;
  }
}
/*
  static Future<int> getFloor(int dormNumber) async {
    int count = 0;
    var collection = await db.collection('dormAndFloor').doc(dormNumber.toString());
      collection
        .get().then((value) {
      count = value.data()!['floor'];
    });
    return count;
  }


  static Future<List<String>> getList(int dorm) async {
    int floor = await getFloor(dorm);
    List<String> floor4 = ['1층', '2층', '3층', '4층'];
    List<String> floor5 = ['1층', '2층', '3층', '4층', '5층'];
    List<String> floor6 = ['1층', '2층', '3층', '4층', '5층', '6층'];
    List<String> floor10 = ['1층', '2층', '3층', '4층', '5층', '6층', '7층', '8층', '9층', '10층'];
    List<String> toReturn = [];

    switch(floor){
      case 4: toReturn = floor4; break;
      case 5: toReturn = floor5; break;
      case 6: toReturn = floor6; break;
      case 10: toReturn = floor10; break;
    }

    return toReturn;
  }
  */