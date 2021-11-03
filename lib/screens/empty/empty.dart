import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/complete.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/screens/process/process.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/widgets/appbar.dart';

class EmptyPage extends StatefulWidget {

  int dorm;
  int floor;
  int number;
  String machineName;
  String machineKind;

  EmptyPage(this.dorm, this.floor, this.number, this.machineName, this.machineKind);

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  static TextEditingController _pinPutController = new TextEditingController();
  late String pin = '';
  bool isUser = true;

  get buttonsRowDirection => null;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(12.0),
    );
  }

  showAlertDialog(var width, var height, BuildContext context, var textInput) {
    _getCloseButton(context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            alignment: FractionalOffset.topRight,
            child: GestureDetector(
              child: Icon(Icons.clear, color: Colors.grey,),
              onTap: () {
                Get.back();
              },),
          ),
        ),
      );
    }
    _getColButtons(context) {
      return [
        DialogButton(
          radius: BorderRadius.all(Radius.circular(32.0)),
          width: 140,
          child: Text(
            "입력완료",
            style: body1style(color: primary),
          ),
          onPressed: () => setState(() {
            if(isUser){
              EmptyModel.changeState(widget.dorm.toString(), widget.floor.toString(),
                  widget.machineName, _pinPutController.text);
              _pinPutController.clear();
              Get.off(HomePage(dorm: widget.dorm, floor: widget.floor));
            }else{
              EmptyModel.announceOther(widget.dorm.toString(), widget.floor.toString(),
                  widget.machineName, _pinPutController.text);
              _pinPutController.clear();
              Get.off(CompletePage(widget.dorm, widget.floor));
            }
          }),
          color: white,
        ),
      ];
    }

    AlertDialog alert2 = AlertDialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        insetPadding: EdgeInsets.all(8),
        elevation: 10,
        titlePadding: const EdgeInsets.all(0.0),
        title: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getCloseButton(context),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                          child: Column(
                              children: [
                                Text(
                                  "$textInput",
                                  style: body1style(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ]
                          )
                      ),
                      SizedBox(
                        height:  20,
                      ),
                      Container(
                          width:width*0.63,
                          child: Row(
                              mainAxisAlignment:MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "남은 시간:",
                                  style: head2style(color:Colors.white)
                                ),
                                Expanded(
                                  child: PinPut(
                                    eachFieldWidth: 48.0,
                                    eachFieldHeight: 65.0,
                                    fieldsCount: 2,
                                    eachFieldMargin: EdgeInsets.only(right:3.5, left:3.5),
                                    keyboardType: TextInputType.number,
                                    controller: _pinPutController,
                                    textStyle: const TextStyle(fontSize: 38.0, color: Colors.white),
                                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    selectedFieldDecoration: _pinPutDecoration.copyWith(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.white,
                                        )
                                    ),
                                    followingFieldDecoration: _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(.5),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "분",
                                  style: head2style(color: Colors.white)
                                )
                              ]
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.only(top:90, bottom: 40, right: 120, left: 120),
        content: buttonsRowDirection==1
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getColButtons(context),
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getColButtons(context),
        )
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert2;
        });
  }

  Widget build(BuildContext context) {
    String machineKind = widget.machineKind;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar2(width, widget.dorm, widget.floor),
      body: Center(
        child: Container(
          //color: grey,
          width: width*0.9,
          height: height*0.8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: secondary,
                    ),
                    width: width*0.8,
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/사용가능 $machineKind기.png',
                          width: 75,
                          height: 89,
                        ),
                        SizedBox(
                          width: width*0.1,
                        ),
                        Text(
                          '$machineKind하기',
                          style: body4style(color: lightBlue)
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    showAlertDialog(width, height, context,"😎\n다른 학우들을 위해 남은 시간을 알려주세요!\n😊");
                    },
                ),
                SizedBox(
                  height: 22,
                ),
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: secondary,
                    ),
                    //color:blue1,
                    width: width*0.8,
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/state_known.png',
                            width: width*0.3
                        ),
                        SizedBox(
                          width: width*0.05,
                        ),
                        Text(
                          '상태 정보\n알려주기',
                          style: body4style(color: lightBlue)
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    isUser = false;
                    showAlertDialog(width, height, context,"😎\n다른 학우들을 위해 남은 시간을 알려주세요!\n사용 현황에는 이름이 뜨지 않으니 안심하세요😊");
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
