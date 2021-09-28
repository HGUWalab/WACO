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

}