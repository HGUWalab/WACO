import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/screens/onboarding/OnBoardingPage.dart';
import 'package:wacoproject/utils/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserData.setData();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home()
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return AnimatedSplashScreen(
          splash: Image.asset(
              'assets/logo1.png',
              width: size.width * 0.5
          ),
          nextScreen: autoLogin(),
          splashTransition: SplashTransition.fadeTransition,
        );
    }
  autoLogin(){
    if(UserData.isLoggedIn==false){
      return OnBoardingPage();
    }else{
      return HomePage(dorm: UserData.lastDorm, floor: UserData.lastFloor);
    }
  }
}

