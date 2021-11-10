import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/complete.dart';
import 'package:wacoproject/screens/empty/run.dart';
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
                          style: head2style(color: lightBlue)
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    Get.to(RunPage(widget.dorm, widget.floor, widget.number, widget.machineName, widget.machineKind,
                        '⏰\n기기에 표시된 남은 시간을 입력해주세요!', true));
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
                          style: head2style(color: lightBlue)
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    Get.to(RunPage(widget.dorm, widget.floor, widget.number, widget.machineName, widget.machineKind,
                        '😎\n다른 학우들을 위해 남은시간을 알려주세요!\n사용 현황에는 하은님의 이름이 뜨지 않으니\n안심하세요 :)', false));
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
