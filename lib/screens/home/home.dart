import 'package:flutter/material.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/screens/home/localwidget/gunjoki.dart';
import 'package:wacoproject/screens/home/localwidget/setakki.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
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

  Future<void> getCount(int dorm) async {
    int count = 0;
    count = await MainModel.getMachineCount(dorm.toString(), widget.floor.toString(), 'setakkiCount');
    this.setakkiCount = count;
    count = await MainModel.getMachineCount(dorm.toString(), widget.floor.toString(), 'gunjokiCount');
    this.gunjokiCount = count;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    getCount(widget.dorm);
    return Scaffold(
      backgroundColor: white,
      appBar: buildAppBar(),
      body: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.1, height * 0.01, width * 0.1, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.fromLTRB(0, height * 0.01, 0, height * 0.04),
                  child: TopHome(widget.dorm, widget.floor),
                ),
                Text('세탁기',
                    style: head2style(color: darkGrey)),
                SizedBox(height:height*0.01),
                Column(
                  children: [
                    Container(
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height : height*0.05),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('건조기',
                        style: head2style(color: darkGrey)),
                    SizedBox(height:10),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: height*0.01),
                      height: width*0.46,
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
                  ],
                ),
              ]
          )
      ),
    );
  }
}
