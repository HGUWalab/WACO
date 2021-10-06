import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/themes/onboard_theme_data.dart';


/*
 * 온보드 화면과 세팅 화면에 사용하는 ChoiceChip화면으로 하나를 고르면 하나가 취소되는 형식으로 구성되었다.
 * dependencies에서 Chip_chice라는 것을 사용하였고 생활관과 층수를 따로하기 위해 구별해놓았다.
 */
class ChoiceChipDorm extends StatefulWidget {
  _ChoiceChipDormState chipDorm = new _ChoiceChipDormState();

  static int tag = 0;

  @override
  _ChoiceChipDormState createState() => chipDorm;

  static int getDormTag() {
    return tag;
  }
}

class _ChoiceChipDormState extends State<ChoiceChipDorm> {
  List<String> options = [
    '갈대상자관',
    '국제관',
    '로뎀관',
    '비전관',
    '은혜관',
    '하용조관',
    '벧엘관',
    '창조관',
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
      onChanged: (val) => setState(() {
        ChoiceChipDorm.tag = val;
        print(ChoiceChipDorm.tag);
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