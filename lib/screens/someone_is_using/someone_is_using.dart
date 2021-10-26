import 'package:flutter/material.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:get/get.dart';
import 'package:wacoproject/widgets/appbar.dart';
import 'package:wacoproject/widgets/button_theme.dart';
import 'package:wacoproject/model/main_model.dart';

class SomeoneIsUsingPage extends StatefulWidget {
  int dorm;
  int floor;
  int number;
  String machineName;
  SomeoneIsUsingPage(this.dorm,this.floor, this.number, this.machineName);

  @override
  _SomeoneIsUsingPageState createState() => _SomeoneIsUsingPageState();
}

class _SomeoneIsUsingPageState extends State<SomeoneIsUsingPage> {
  String user = '';

  Future<void> getUser() async {
    user = await MainModel.getUserName(widget.dorm.toString(), widget.floor.toString(), widget.machineName);
    if(this.mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
        backgroundColor: white,
        appBar: buildAppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: primary, ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                ),
                height: 38,
                width: 178,
                child: Text('$user님 사용중',
                  style: body1style(color: grey),
                ),
              ),
              SizedBox(height: 50,),
              Text('남은 시간',
                style: body1style(color: grey),
              ),
              Text('24',
                style: body5style(color: primary),
              ),
              Text('minutes',
                style: body6style(color: primary),
              ),
              SizedBox(height: 160,),
              ElevatedButton(
                  onPressed: (){
                    Get.back();
                  },
                  style: longButtonStyle,
                  child: Text('홈으로',
                    style: body1style(color: white),
                  )
              ),
              SizedBox(height: 25,),
              Text('⚠️ 허위 상태 신고하기',
                style: body1style(color: grey),
              ),
            ],
          ),
        )
    );
  }
}