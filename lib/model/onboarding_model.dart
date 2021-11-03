//This class is made to handle firebase in Onboarding page.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wacoproject/model/main_model.dart';
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

  static Future<int> getStateCount(String dormNumber, String dormFloor, String machineKind) async{
    int machineCount = 2;
    //await MainModel.getMachineCount(dormNumber, dormFloor, machineKind);
    int availableCount = 0;
    for(int i = 1; i <= machineCount; i++) {
      bool available = await MainModel.getMachineState(
          dormNumber, dormFloor, "$i$machineKind");
      if (available == true) availableCount++;
    }
    return availableCount;
  }

  static Future<List<String>> getDormFloor(String dormNumber) async{
    List<String> floors = [];
    int floor = 0;
    int setakki = 0;
    int gunjoki = 0;
    var collection = await db.collection('dormAndFloor').doc(dormNumber)
        .get().then((value) async {
      floor = value.data()!['floor'];

      if(dormNumber=='5'){
        for(int i = 3; i <= floor; i++){
          setakki = await getStateCount(dormNumber, "$i", "setakki");
          gunjoki= await getStateCount(dormNumber, "$i", "gunjoki");
          floors.add(i.toString()+"층           $setakki / $gunjoki");
        }
      }else{
        for(int i = 1; i <= floor; i++){
          setakki = await getStateCount(dormNumber, "$i", "setakki");
          gunjoki= await getStateCount(dormNumber, "$i", "gunjoki");
          floors.add(i.toString()+"층          $setakki / $gunjoki");
        }
      }
    });
    return floors;
  }

}