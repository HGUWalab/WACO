import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wacoproject/utils/user.dart';

class EmptyModel{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static void getRunningTime(String dormNumber, String floorNumber, String machineName) async{
    var stl = db.collection('dormAndFloor').doc(dormNumber).collection(floorNumber);
    var now = DateTime.now();
    String dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    dynamic currentTime = DateFormat.jm().format(DateTime.now());
    stl.doc(machineName)
    .update({
      'endTime': currentTime,
      'modTime': dateFormat,
      'startTime': currentTime
    });
  }

  static void changeState(String dormNumber, String floorNumber, String machineName, String time) async{
    var stl = db.collection('dormAndFloor').doc(dormNumber).collection(floorNumber);
    bool available = false;
    var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floorNumber).doc(machineName)
        .get().then((value) {
      available = value.data()!['state'];
    });
    if(available == true){
      stl.doc(machineName)
          .set({
        'state' : false,
        'endTime' : EmptyModel.getTimeDone(time),
        'inputTime' : time,
        'name' : UserData.userName,
        'userID' : UserData.documentId
      });
    }else{
      stl.doc(machineName)
          .set({
        'state' : true,
        'endTime' : '',
        'inputTime' : 0,
        'name' : '',
        'userID' : ''
      });
    }
  }

  static String getTimeDone(String inputTime){
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    var timeDone = DateTime.parse(currentTime);
    var newDate = timeDone.add(Duration(minutes: int.parse(inputTime)));
    return newDate.toString();
  }

  static Future<int> getTimeLeft(String dormNumber, String floorNumber, String machineName) async {
    DateTime now = DateTime.now();
    String currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    var nowTime = DateTime.parse(currentTime);
    String doneTime = '';
    var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floorNumber).doc(machineName)
          .get().then((value) {
            doneTime = value.data()!['endTime'];
          });
    var fireBaseTime = DateTime.parse(doneTime);
    return int.parse(fireBaseTime.difference(nowTime).inMinutes.toString())+1;
  }

  static Future<int> getInputTime(String dormNumber, String floorNumber, String machineName) async {
    String inputTime = '';
    try{
      var collection = await db.collection('dormAndFloor').doc(dormNumber).collection(floorNumber).doc(machineName)
          .get().then((value) {
        inputTime = value.data()!['inputTime'];
      });
    }catch(e){}
    return int.parse(inputTime);
  }
}