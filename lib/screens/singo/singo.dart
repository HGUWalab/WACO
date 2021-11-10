import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/complete.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/screens/home/home.dart';

class SingoPage extends StatefulWidget {
  int dorm;
  int floor;
  String machineName;
  String userName;
  SingoPage(this.dorm,this.floor, this.machineName, this.userName);
  _SingoPageState createState() => _SingoPageState();
}

class _SingoPageState extends State<SingoPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset('assets/logo1.png', width: 80.0),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: height*0.15),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: '비어있는 세탁기/건조기',style: head2style(color: primary)),
                TextSpan(text: '가\n어플에서는 ',style: body4style(color: primary)),
                TextSpan(text: (widget.userName) ,style: head2style(color: primary)),
                TextSpan(text: '님이 사용중\n',style: head2style(color: primary)),
                TextSpan(text: '이라고 나와있나요?', style: body4style(color: primary))
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.1, height * 0.25, width * 0.1, height * 0.12),
            child: Column(
              children: [
                FlatButton(
                    onPressed: () {
                      EmptyModel.changeState(widget.dorm.toString(), widget.floor.toString(), widget.machineName, '0');
                      Get.off(HomePage(dorm: widget.dorm, floor: widget.floor));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.0),
                        color: primary,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            '네, 신고합니다',
                            textAlign: TextAlign.center,
                            style: head2style(color: white)
                          ),
                        ],
                      ),
                      width: width * 0.78,
                      height: height * 0.08,
                    )),
                SizedBox(
                  height: height * 0.02,
                ),
                FlatButton(
                    onPressed: () {
                      Get.off(CompletePage(widget.dorm, widget.floor));
                    },
                    child: Text(
                      '메인으로 돌아가기',
                      style: body4style(color: primary)
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}