import 'package:shared_preferences/shared_preferences.dart';

class UserData{
  static String userName = '';
  static String documentId = '';
  static bool isLoggedIn = false;
  static int lastDorm = 0;
  static int lastFloor = 0;
  static int usingDorm = -1;
  static int usingFloor = -1;
  static int usingNumber = -1;
  static String usingMachine = '';

  static void setData() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try{
      documentId = pref.getString('documentId')!;
      userName = pref.getString('userName')!;
      isLoggedIn = pref.getBool('isLoggedIn')!;
      lastDorm = pref.getInt('lastDorm')!;
      lastFloor = pref.getInt('lastFloor')!;
      usingDorm = pref.getInt('usingDorm')!;
      usingFloor = pref.getInt('usingFloor')!;
      usingNumber = pref.getInt('usingNumber')!;
      usingMachine = pref.getString('usingMachine')!;
    }catch(e){}
  }

  static void updateDormAndFloor(int dorm, int floor) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('lastDorm', dorm);
    pref.setInt('lastFloor', floor);
  }

  static void updateUsingMachine(int dorm, int floor, int number, String machineName)async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('usingDorm', usingDorm);
    pref.setInt('usingFloor', usingFloor);
    pref.setInt('usingNumber', usingNumber);
    pref.setString('usingMachine', usingMachine);
    //UserData.updateUsingMachine(widget.dorm, widget.floor, widget.number, widget.machineName);
  }
}