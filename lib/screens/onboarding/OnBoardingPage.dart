import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wacoproject/model/onboarding_model.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_dorm.dart';
import 'package:wacoproject/screens/onboarding/localwidget/choice_chip_floor.dart';
import 'package:wacoproject/themes/onboard_theme_data.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';


/*
 * 첫시작 화면을 온보드 화면으로 구현한 것이다.
 * 화면 구현은 dependecies에서 introduction_screen: 을 사용하였다.
 * 화면 구성은 1. 환영말 2. 생활관 선택 3. 이름 입력 4. 아너코드 확인 및 시작으로 구성되어있다.
 */
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  static TextEditingController name = TextEditingController();
  bool typedIn = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: OnboardThemeData.blue2,
        dotsDecorator: DotsDecorator(
          color: OnboardThemeData.blue1,
          activeColor: Colors.white,
        ),
        pages: [
          PageViewModel(
            decoration: PageDecoration(
                titlePadding: EdgeInsets.all(1),
                footerPadding: EdgeInsets.all(1)
            ),
            titleWidget: Container(
              alignment: Alignment.bottomCenter,
              height: height*0.6,
              width: width*0.8,
              child: Image.asset('assets/on1.png', width: width * 0.8),
              //color: grey
            ),
            bodyWidget: Container(
              height: height*0.3,
              width: width*0.8,
              //color: grey,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('안녕하세요.',
                      style: head1style(color: white)),
                  Text('한동인을 위한 세탁어플 “WACO” 입니다 ☺',
                      style: subtitle1style(color: white))
                ],
              ),
            ),
          ),
          PageViewModel(
              titleWidget: Container(
                width: width * 0.8,
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Text('Your Room',
                        style: head1style(color: white)),
                    Text('사용자의 거주 호관과 층수를 입력하세요',
                        style: subtitle1style(color: white))
                  ],
                ),
              ),
              bodyWidget: Container(
                child: Column(
                  children: [
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
                  ],
                ),
              )),
          PageViewModel(
              decoration: PageDecoration(
                  titlePadding: EdgeInsets.all(1),
                  footerPadding: EdgeInsets.all(1)
              ),
              titleWidget: Container(
                alignment: Alignment.bottomCenter,
                height: height*0.6,
                width: width*0.8,
                child: Image.asset('assets/on2.png', width: width * 0.8),
              ),
              bodyWidget: Container(
                  height: height*0.15,
                  width: width*0.8,
                  //color: grey,
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('NAME',
                          style: head1style(color: white)),
                      Text('사용자의 이름을 입력해주세요',
                          style: subtitle1style(color: white))
                    ],
                  )),
              footer: Container(
                height: height*0.15,
                width: width*0.8,
                //color: grey,
                alignment: Alignment.bottomCenter,
                child: inputContainer(name, '예) 김길동', TextInputType.name, 3),
              )
          ),
          PageViewModel(
            decoration: PageDecoration(
                titlePadding: EdgeInsets.all(1),
                footerPadding: EdgeInsets.all(1)
            ),
            titleWidget: Container(
              alignment: Alignment.bottomCenter,
              height: height*0.5,
              width: width*0.7,
              child: Image.asset('assets/on3.png', width: width * 0.7),
              //color: grey
            ),
            bodyWidget: Container(
              height: height*0.2,
              width: width*0.8,
              //color: grey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnboardThemeData.titleText('Honor Code'),
                    OnboardThemeData.subTitleText('모든 준비가 끝났습니다! 마지막으로\n정직한 한동인으로서 약속하나 해주세요 😊'),
                  ]),
            ),
            footer: Container(
              //color:grey,
                height: height*0.2,
                width: width*0.9,
                //alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:height*0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buildCheckButton(),
                          OnboardThemeData.subTitleText('나는 한동인으로서 아너코드를 지키며\n본 어플리케이션을 이용할 것을 약속합니다.'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
                      child: buildFlatButton(),
                    ),
                  ],
                )),
          )
        ],
        showDoneButton: false,
        showNextButton: false,
      ),
    );
  }



  FlatButton buildCheckButton() {
    if (isChecked == true) {
      return FlatButton(
        minWidth: 25,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Image.asset("assets/checked.png", width: 30),
        onPressed: () {
          setState(() {
            isChecked = false;
          });
        },
      );
    } else {
      return FlatButton(
        minWidth: 25,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Image.asset("assets/unchecked.png", width: 30),
        onPressed: () {
          setState(() {
            isChecked = true;
          });
        },
      );
    }
  }

  Container buildFlatButton() {
    if (typedIn && isChecked) {
      return Container(
        height: 40,
        width: 126,
        child: FlatButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          child: Text('시작하기',
              textAlign: TextAlign.center,
              style: body1style(color: primary)),
          onPressed: () async {
            OnboardingModel.firebaseUserUpload(name.text);
            UserData.updateDormAndFloor(ChoiceChipDorm.getDormTag(), ChoiceChipFloor.getFloorTag());//마지막 층과 기숙사 번호 SharedPreference로 저장해놓음.
            UserData.setData();//저장한 내용들 한번 업데이트 진행해줌
            Get.off(HomePage(dorm: ChoiceChipDorm.getDormTag(), floor: ChoiceChipFloor.getFloorTag()));
          },
        ),
      );
    } else {
      return Container(
        height: 37,
        width: 126,
        child: FlatButton(
          color: primary,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50)),
          child: Text('시작하기',
              style: body1style(color: white)),
          onPressed: () {},
        ),
      );
    }
  }

  Container inputContainer(TextEditingController input, String labelText,
      TextInputType type, int inputMax) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      //padding:
      //EdgeInsets.fromLTRB(width * 0.05, height * 0.01, width * 0.05, 0),
        child: Theme(
          data: ThemeData(
            primaryColor: primary,
            primaryColorDark: primary,
          ),
          child: TextField(
            maxLength: inputMax,
            maxLengthEnforced: true,
            keyboardType: type,
            onChanged: (value) {
              setState(() {
                if (name.text.isNotEmpty)
                  typedIn = true;
                else
                  typedIn = false;
              });
            },
            controller: input,
            decoration: InputDecoration(
                hintText: labelText,
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15.0))),
          ),
        ));
  }
}