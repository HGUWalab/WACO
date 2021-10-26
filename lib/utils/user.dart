import 'package:shared_preferences/shared_preferences.dart';

class UserData{
  static String userName = '';
  static String documentId = '';
  static bool isLoggedIn = false;
  static int lastDorm = 0;
  static int lastFloor = 0;

  static void setData() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    try{
      documentId = pref.getString('documentId')!;
      userName = pref.getString('userName')!;
      isLoggedIn = pref.getBool('isLoggedIn')!;
      lastDorm = pref.getInt('lastDorm')!;
      lastFloor = pref.getInt('lastFloor')!;
    }catch(e){}
  }

  static void updateDormAndFloor(int dorm, int floor) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('lastDorm', dorm);
    pref.setInt('lastFloor', floor);
  }
}