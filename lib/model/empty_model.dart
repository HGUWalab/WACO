import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
        'endTime' : time
      });
    }else{
      stl.doc(machineName)
          .set({
        'state' : true,
        'endTime' : time
      });
    }
  }
}