import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/complete.dart';
import 'package:wacoproject/screens/process/process.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';
import 'package:wacoproject/widgets/appbar.dart';
import 'package:wacoproject/widgets/button_theme.dart';

class RunPage extends StatefulWidget {
  int dorm;
  int floor;
  int number;
  String machineName;
  String machineKind;
  String ment;
  bool isUser;

  RunPage(this.dorm, this.floor, this.number, this.machineName,
      this.machineKind, this.ment, this.isUser);

  @override
  _RunPageState createState() => _RunPageState();
}

class _RunPageState extends State<RunPage> {
  var _currentNumber = 50;

  @override
  Widget build(BuildContext context) {
    String mented = widget.ment;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar2(width, widget.dorm, widget.floor),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 150),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: primary),
            alignment: Alignment.center,
            //color: primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "$mented",
                          style: body1style(color: white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 50),
                        Container(
                            width: width * 0.63,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text("남은 시간:",
                                        style: head2style(color: Colors.white)),
                                  ),
                                  NumberPicker(
                                    selectedTextStyle: head2style(color: white),
                                    textStyle: subtitle1style(color: white),
                                    value: _currentNumber,
                                    minValue: 1,
                                    maxValue: 90,
                                    step: 1,
                                    haptics: true,
                                    onChanged: (value) =>
                                        setState(() => _currentNumber = value),
                                  ),
                                  Center(
                                    child: Text("분",
                                        style: head2style(color: Colors.white)),
                                  )
                                ])),
                        SizedBox(height: 30),
                        ElevatedButton(
                            onPressed: () {
                              if (widget.isUser) {
                                EmptyModel.changeState(
                                    widget.dorm.toString(),
                                    widget.floor.toString(),
                                    widget.machineName,
                                _currentNumber.toString());
                                UserData.updateUsingMachine(widget.dorm, widget.floor, widget.number, widget.machineName);
                              } else {
                                EmptyModel.announceOther(
                                    widget.dorm.toString(),
                                    widget.floor.toString(),
                                    widget.machineName,
                                    _currentNumber.toString());
                              }
                              Get.off(Process(
                                  widget.dorm, widget.floor, widget.number, widget.machineName));                            },
                            style: shortButtonStyle,
                            child: Text(
                              '입력완료',
                              style: body1style(color: primary),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
