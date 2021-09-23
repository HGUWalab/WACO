import 'package:flutter/material.dart';

//static은 여러 객가 있어도 static으로 선언된 것은체 모든 객체에 해당되는 변수가 된다.
//const는 compile시간 때 값이 지정되는 것이다.
//final은 compile이후 run시간 때 값이 지정되는 것이다.
class OnboardThemeData{
  static const Color blue2 = Color(0xffB0C4FF);
  static const Color blue1 = Color(0xffE1EBF7);

  static Text titleText(String input) {
    return Text('$input',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          fontFamily: 'NotoSansKR',
          color: Colors.white,
        ));
  }

  static Text chipTitleText(String input) {
    return Text(
      '$input',
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'NotoSansKR',
          color: Colors.white),
    );
  }

  static Text subTitleText(String input){
    return Text(
      '$input',
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontFamily: 'NotoSansKR',
          color: Colors.white),
    );
  }

  static Container mainImage(double height, double width, String input){
    return Container(
      alignment: Alignment.bottomCenter,
      height: height*0.6,
      width: width*0.8,
      child: Image.asset('$input', width: width * 0.8),
      //color: grey
    );
  }

}