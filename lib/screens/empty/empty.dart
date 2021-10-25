import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';

class EmptyPage extends StatefulWidget {

  int dorm;
  int floor;
  int number;
  String machineName;

  EmptyPage(this.dorm,this.floor, this.number, this.machineName);

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    print(widget.machineName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image.asset(
            'assets/logo1.png',
            width: 80.0
        ),
        leading: Padding(
            padding: EdgeInsets.only(left:width*0.05),
            child: IconButton(
              icon: Icon(Icons.home_sharp,
                size: 35,
                color: primary,),
              onPressed: () {
                Get.back();
              },
            )
        ),
      ),
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
                          'assets/사용가능 세탁기.png',
                          width: 75,
                          height: 89,
                        ),
                        SizedBox(
                          width: width*0.1,
                        ),
                        Text(
                          '세탁하기',
                          style: body4style(color: lightBlue)
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    EmptyModel.changeState(widget.dorm.toString(), widget.floor.toString(), widget.machineName);
                    Get.off(HomePage(dorm: widget.dorm,
                        floor: widget.floor));
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
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
