import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_dorm.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_floor.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';

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
        padding: EdgeInsets.only(left: width*0.08, right: width*0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Text('Your Room',
                    style: head1style(color: white)),
            Text('사용자의 거주 호관과 층수를 입력하세요',
                style: subtitle1style(color: white)),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.03, bottom: height * 0.02),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: width*0.2,
                ),
                Text('*갈대상자관1: 00호~13호, 갈대상자관2: 14~36호',
                    style: body8style(color: white)),
              ],
            ),
            Center(child: ChoiceChipDorm()),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.05, bottom: height * 0.02),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: width*0.42,
                ),
                Text('*사용가능한 세탁기 수/건조기 수',
                    style: body8style(color: white)),
              ],
            ),
            Center(child: ChoiceChipFloor()),
            SizedBox(height: 10),
            Center(
              child: FlatButton(
                color: white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Text('시작하기',
                    style: body1style(color: primary)),
                onPressed: () {
                  UserData.updateDormAndFloor(ChoiceChipDorm.tag, ChoiceChipFloor.tag+1);
                  Get.off(HomePage(dorm: ChoiceChipDorm.tag, floor: ChoiceChipFloor.tag+1));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
