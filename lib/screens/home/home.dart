import 'package:flutter/material.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/model/onboarding_model.dart';
import 'package:wacoproject/screens/home/localwidget/gunjoki.dart';
import 'package:wacoproject/screens/home/localwidget/setakki.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';
import 'package:wacoproject/widgets/appbar.dart';
import 'package:wacoproject/screens/home/localwidget/tophome.dart';

class HomePage extends StatefulWidget {

  HomePage({required int this.dorm, required int this.floor});

  int dorm;
  int floor;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i=1;

  int setakkiCount=0;
  int gunjokiCount=0;
  int setakkiAvailable=0;
  int gunjokiAvailable=0;

  Future<void> getCount() async {
    int count = 0;
    count = await MainModel.getMachineCount(widget.dorm.toString(), widget.floor.toString(), 'setakkiCount');
    this.setakkiCount = count;
    count = await MainModel.getMachineCount(widget.dorm.toString(), widget.floor.toString(), 'gunjokiCount');
    this.gunjokiCount = count;
    setakkiAvailable = await OnboardingModel.getStateCount(widget.dorm.toString(), widget.floor.toString(), "setakki");
    gunjokiAvailable = await OnboardingModel.getStateCount(widget.dorm.toString(), widget.floor.toString(), "gunjoki");
    if(this.mounted){
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var userName = UserData.userName;
    getCount();
    return Scaffold(
      backgroundColor: white,
      appBar: buildAppBar(),
      body: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.1, height * 0.01, width * 0.1, 0),
          child: ListView(

              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.04),
                  child: TopHome(widget.dorm, widget.floor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('세탁기',
                        style: head2style(color: darkGrey)),
                    RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: '사용가능: ', style: subtitle2style(color: grey)),
                            TextSpan(text: '$setakkiAvailable', style: body1style(color: darkGrey)),
                            TextSpan(text:'대', style: subtitle2style(color: grey))
                          ]
                        )
                    ),
                  ],
                ),
                SizedBox(height:height*0.01),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height*0.01),
                  height: height * 0.23,
                  width: width * 0.9,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    itemCount: setakkiCount,
                    itemBuilder: (BuildContext context, int index){
                      return Row(
                        children: [
                          BuildSetakki(widget.dorm, widget.floor, index+1 ,'${index+1}setakki'),
                          SizedBox(width: width*0.05)
                        ],
                      );
                    }
                  )
                ),
                SizedBox(height : height*0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('건조기',
                            style: head2style(color: darkGrey)),
                        RichText(
                            text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(text: '사용가능: ', style: subtitle2style(color: grey)),
                                  TextSpan(text: '$gunjokiAvailable', style: body1style(color: darkGrey)),
                                  TextSpan(text:'대', style: subtitle2style(color: grey))
                                ]
                            )
                        ),
                      ],
                    ),
                    SizedBox(height:height*0.01),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height*0.01),
                      height: height * 0.23,
                      width: width * 0.9,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        itemCount: gunjokiCount,
                        itemBuilder: (BuildContext context, int index){
                          return Row(
                            children: [
                              BuildGunjoki(widget.dorm, widget.floor, index+1 ,'${index+1}gunjoki'),
                              SizedBox(width: width*0.05)
                            ],
                          );
                        }
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Container(
                            width :350,
                            height :30,
                            //color: darkGrey,
                            decoration: BoxDecoration(
                              color: darkGrey,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15.0) 
                              ),
                            ), 
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/basket.png', width: 25, height: 20,),
                                SizedBox(width: 10,),
                                Text('$userName님은 ', style: body9style(color: white),),
                                Text('1번 세탁기', style: body7style(color: white),),
                                Text('를 사용중입니다.', style: body9style(color: white),)
                              ],
                            )
                          ),
                          TextButton(
                            child: Text("남은시간 보러가기", style: subtitle2style(color: darkGrey),),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
          )
      ),
    );
  }
}
