import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:wacoproject/model/onboarding_model.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_floor.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';

/*
 * 온보드 화면과 세팅 화면에 사용하는 ChoiceChip화면으로 하나를 고르면 하나가 취소되는 형식으로 구성되었다.
 * dependencies에서 Chip_chice라는 것을 사용하였고 생활관과 층수를 따로하기 위해 구별해놓았다.
 */
class ChoiceChipDorm extends StatefulWidget {
  _ChoiceChipDormState chipDorm = new _ChoiceChipDormState();

  static int tag = 0;

  @override
  _ChoiceChipDormState createState() => chipDorm;
}

class _ChoiceChipDormState extends State<ChoiceChipDorm> {
  List<String> options = [
    '갈대상자관1',
    '갈대상자관2',
    '로뎀관',
    '비전관',
    '은혜관',
    '하용조관',
    '벧엘관',
    '창조관',
    '국제관',
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ChipsChoice<int>.single(
      alignment: WrapAlignment.center,
      spacing: 15.0,
      runSpacing: height*0.005,
      wrapped: true,
      value: ChoiceChipDorm.tag,
      onChanged: (val) => setState((){
        ChoiceChipDorm.tag = val;
        ChoiceChipFloor.tag = 0;
      }),
      choiceItems: C2Choice.listFrom<int, String>(
        source: options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(
          color: primary,
          brightness: Brightness.dark,
          borderWidth: 1,
          borderColor: Colors.white,
          labelStyle: body1style(color: white),
          showCheckmark: false),
      choiceActiveStyle: C2ChoiceStyle(
        color: Colors.white,
        labelStyle: body1style(color: primary),
      ), //클릭 되었을 때 text 색을 바꾼
    );
  }
}