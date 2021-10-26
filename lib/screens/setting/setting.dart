import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_dorm.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_floor.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primary,
      body: Padding(
        padding: EdgeInsets.only(left: 30.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            Text('Your Room',
                    style: head1style(color: white)),
            Text('사용자의 거주 호관과 층수를 입력하세요',
                style: subtitle1style(color: white)),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.03, bottom: height * 0.02),
            ),
            ChoiceChipDorm(),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.05, bottom: height * 0.02),
            ),
            ChoiceChipFloor(),
            Center(
              child: FlatButton(
                color: white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Text('시작하기',
                    style: body1style(color: primary)),
                onPressed: () {
                  Get.off(HomePage(dorm: ChoiceChipDorm.getDormTag(), floor: ChoiceChipFloor.getFloorTag()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
