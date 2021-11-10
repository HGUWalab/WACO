import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wacoproject/model/empty_model.dart';

class MainModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static bool timeCheck = false;

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

  static void checkDoneMachine(String dormNumber, String floor, String machineName)async {
    int timeLeft = await EmptyModel.getTimeCompare(dormNumber, floor, machineName);
    // setState()가 1초안에 여러번 호출되서 나중에 increment(1)할 때 여러번에 함수가 동시에 되서 + 4~6이 되버린다. 이거 해결하자!
    if(timeLeft <= 0){
      var machineKind = machineName.substring(1, machineName.length);
      var stl = db.collection('dormAndFloor').doc(dormNumber).collection(floor);
      stl.doc(machineName)
          .set({
        'state' : true,
        'endTime' : "none",
        'inputTime' : 0,
        'name' : '',
        'userID' : ''
      });
      stl.doc("machineCount")
          .update({
        'available$machineKind' : FieldValue.increment(1)
      });
    }
  }


  static String getPageName(int dorm, int floor){
    String pageName = '';
    switch(dorm){
      case 0: pageName = '갈상1 '; break;
      case 1: pageName = '갈상2 '; break;
      case 2: pageName = '로뎀관 '; break;
      case 3: pageName = '비전관 '; break;
      case 4: pageName = '은혜관 '; break;
      case 5: pageName = '하용조관 '; break;
      case 6: pageName = '벧엘관 '; break;
      case 7: pageName = '창조관 '; break;
      case 8: pageName = '국제관 '; break;
    }
    pageName = pageName + "$floor" + "층";
    return pageName;
  }
}