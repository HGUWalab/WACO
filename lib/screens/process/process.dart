import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';
import 'package:wacoproject/widgets/appbar.dart';

class Process extends StatefulWidget {
  var number, machineName;
  int dorm, floor;

  Process(this.dorm,this.floor, this.number, this.machineName);

  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  var userName = UserData.userName;
  late Timer _timer;
  bool finished = false;
  bool first = true;
  int _start=50;
  int _count=50;
  double value = 0;

  Future<void> getUserAndTime() async {
    if (first) {
      _start = await EmptyModel.getInputTime(widget.dorm.toString(),
               widget.floor.toString(), widget.machineName);
      _count = await EmptyModel.getTimeLeft(widget.dorm.toString(),
              widget.floor.toString(), widget.machineName);
      if(_count < 0){
        _count = 0;
        finished = true;
      }
      first=false;
      value = 1.0-(_count/_start);
      print('Process/getUserAndTime-userName: $userName, _start: $_start, _count: $_count');
      setState(() {});
    }
  }

  void startTimer() {
    const oneMin = const Duration(minutes: 1);
    _timer = new Timer.periodic(oneMin, (Timer timer) {
      if (_count == 0) {
        if(this.mounted){
          setState(() {
            timer.cancel();
            finished = true;
          });
        }
      } else {
        if(this.mounted){
          setState(() {
            _count--;
            value = 1.0-(_count/_start);
            timer.cancel();
          });
        }//기존 타이머가 문제 였던 이유가 timer.cancel()을 사용하지 않아서 였다. 매번 만들어질 때마다 새로운 타이머가 생성되서 문제였다.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    getUserAndTime();
    if (first == false) {startTimer();}
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar2(width, widget.dorm, widget.floor),
        body: Padding(
            padding: EdgeInsets.fromLTRB(width*0.1, 10.0, width*0.1, 0.0),
            child: Container(
              height:height*0.9,
              //color:grey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Container(
                      height: 10,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: value, //1.0
                            color: Color(0xffB0C4FF),
                            backgroundColor: Color(0xffE1EBF7),
                          )
                      ),
                    ),
                    SizedBox(height: height*0.05),
                    buildColumn(),
                    SizedBox(
                        height:height*0.1
                    ),
                    Container(
                      //color:Colors.white,
                      //alignment: Alignment.bottomCenter,
                      width: width*0.8,
                      height:60,
                      child: buildTextButton(),
                    ),
                    Center(
                      child: TextButton(
                        child: Text("작동 취소하기", style: body1style(color: darkGrey)),
                        onPressed: ((){
                          EmptyModel.changeState(widget.dorm.toString(), widget.floor.toString(), widget.machineName, "0");
                          Get.off(HomePage(dorm: widget.dorm, floor: widget.floor,));
                        }) ,
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }

  TextButton buildTextButton() {
    if(finished == false){
      return TextButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              )
          ),
          backgroundColor: MaterialStateProperty.all(grey),
        ),
        onPressed: () {},
        child: Text('현재 작동중입니다...',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            fontFamily: 'NotoSansKR',
            color: Colors.white,
          ),
        ),
      );
    }else{
      return TextButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              )
          ),
          backgroundColor: MaterialStateProperty.all(primary),
          //Defines shadowColor
        ),
        onPressed: () {
          EmptyModel.changeState(widget.dorm.toString(), widget.floor.toString(), widget.machineName, "0");
          first = true;
          Get.to(HomePage(dorm: widget.dorm, floor: widget.floor));
          },
        child: Text('세탁물 수거하기',
          style: body4style(color: white)
        ),
      );
    }

  }

  Column buildColumn() {
    if(finished == false){
      return Column(
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(text:'${userName}님의\n옷이\n깨끗해지기까지\n', style: body3style(color: primary)),
                TextSpan(text: '$_count분', style: head3style(color: primary)),
                TextSpan(text: ' 남았습니다', style: body3style(color: primary))
              ],
            )
          ),
        ],
      );
    }else{
      return Column(
        children: [
          Text('$userName님의\n옷 세탁이\n완료되었습니다',
              style: body3style(color: primary))
        ],
      );
    }
  }
}