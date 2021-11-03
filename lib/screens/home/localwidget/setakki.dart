import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/screens/empty/empty.dart';
import 'package:wacoproject/screens/process/process.dart';
import 'package:wacoproject/screens/someone_is_using/someone_is_using.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';

class BuildSetakki extends StatefulWidget {
  int dorm;
  int floor;
  int number;
  String machineName;

  BuildSetakki(this.dorm,this.floor, this.number, this.machineName);

  @override
  _BuildSetakkiState createState() => _BuildSetakkiState();
}

class _BuildSetakkiState extends State<BuildSetakki> {
  var state;

  Future<void> getState() async {
    MainModel.checkDoneMachine(widget.dorm.toString(), widget.floor.toString(), widget.machineName);
    bool state;
    state = await MainModel.getMachineState(widget.dorm.toString(), widget.floor.toString(), widget.machineName);
    this.state = state;
  }//무언가 변화를 줄때는 setState(() {내용})을 사용하면 된다.

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    getState(); //화면이 만들어지기 전에 Future<void> getState()를 통해 변수들에 값들을 저장해준다.
    return Container(
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
      width: 140,
      height: 230,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: height*0.015,
            ),
            Text('${widget.number}',
                style: subtitle2style(color: grey)
            ),
            SizedBox(
              height: height*0.015,
            ),
            buildFlatButton(),
            SizedBox(
              height: height*0.01
            ),
            checkText(),
          ]),
    );
  }

  FlatButton buildFlatButton() {
    if(state == false){
      return FlatButton(
        child: Container(
          width: 75,
          height: 89.37,
          decoration: this.checkBoxDeco(),
        ),
        onPressed: () async {
          String userID = await MainModel.getUserID(widget.dorm.toString(), widget.floor.toString(), widget.machineName);
          final SharedPreferences pref = await SharedPreferences.getInstance();
          if((pref.getString('documentId')==userID)){
            Get.to(Process(widget.dorm, widget.floor, widget.number, widget.machineName));
          }else{
            Get.to(SomeoneIsUsingPage(widget.dorm, widget.floor, widget.number, widget.machineName));
          }
        },
      );
    }else{
      return FlatButton(
        child: Container(
          width: 75,
          height: 89.37,
          decoration: this.checkBoxDeco(),
        ),
        onPressed: (){
          Get.to(EmptyPage(widget.dorm, widget.floor, widget.number, widget.machineName, "세탁"));
        },
      );
    }
  }

  BoxDecoration checkBoxDeco()  {
    if (state == false)
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/사용중인 세탁기.png'),
          fit: BoxFit.fill,
        ),
      );
    else
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/사용가능 세탁기.png'),
          fit: BoxFit.fill,
        ),
      );
  }

  Row checkText() {
    if (state == false)
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '사용중',
              style: body1style(color: grey)
            ),
          ]);
    else
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '사용가능',
              style: body1style(color: lightBlue)
            )
          ]);
  }
}