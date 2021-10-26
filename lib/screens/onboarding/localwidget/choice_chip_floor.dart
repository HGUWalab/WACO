import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:wacoproject/model/onboarding_model.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_dorm.dart';
import 'package:wacoproject/themes/onboard_theme_data.dart';


/*
 * 온보드 화면과 세팅 화면에 사용하는 ChoiceChip화면으로 하나를 고르면 하나가 취소되는 형식으로 구성되었다.
 * dependencies에서 Chip_chice라는 것을 사용하였고 생활관과 층수를 따로하기 위해 구별해놓았다.
 */
class ChoiceChipFloor extends StatefulWidget {
  _ChoiceChipFloorState chipFloor = new _ChoiceChipFloorState();

  static int tag = 0;
  static bool chipUpdate = false;

  static int getFloorTag(){
    return tag+1;
  }

  @override
  _ChoiceChipFloorState createState() => chipFloor;
}

class _ChoiceChipFloorState extends State<ChoiceChipFloor> {

  Future<void> getCount() async {
    options = await OnboardingModel.getDormFloor(ChoiceChipDorm.tag.toString());
    if(this.mounted){
      setState((){});
    }
  }

  List<String> options = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    getCount();
    return ChipsChoice<int>.single(
      alignment: WrapAlignment.center,
      spacing: 15.0,
      runSpacing: height*0.005,
      wrapped: true,
      value: ChoiceChipFloor.tag,
      onChanged: (val) => setState(() {
        ChoiceChipFloor.tag = val;
        print(ChoiceChipFloor.tag);
      }),
      choiceItems: C2Choice.listFrom<int, String>(
        source: options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(
          color: OnboardThemeData.blue2,
          brightness: Brightness.dark,
          borderWidth: 1,
          borderColor: Colors.white,
          labelStyle: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w500),
          showCheckmark: false),
      //text color를 바꾸는 듯 하다
      choiceActiveStyle: C2ChoiceStyle(
        color: Colors.white,
        labelStyle: TextStyle(
            fontSize: 18.0,
            color: OnboardThemeData.blue2,
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w500),
      ), //클릭 되었을 때 text 색을 바꾼
    );
  }
}