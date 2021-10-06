import 'package:flutter/material.dart';
import 'package:wacoproject/main/setakki.dart';
import 'package:wacoproject/model/main_model.dart';

class MainPage extends StatelessWidget {

  MainPage({required int this.dorm, required int this.floor});

  int dorm;
  int floor;
  int i=1;
  int count;
  /*int setakkiCount =
  int gunjokiCount = MainModel.getMachineCount(dorm.toString(), floor.toString(), 'gunjokiCount');

  Future<int> getSetakkiCount()*/

  Future<void> getCount(int dorm) async {
    int count = 0;
    count = await MainModel.getMachineCount('4', '1', 'gunjokiCount');
    this.count = count;
  }

  @override
  Widget build(BuildContext context) {
    getCount(1);
    print(count);
    return Scaffold(
      appBar: MainModel.buildAppBar(),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index){
          i++;
          return Container(
            child: ListTile(
                dense: true,
                title:Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                )
            ),
          );
        },
      ),
    );
  }
/*
  @override
  Widget buildColumn(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          MainModel.buildTopMain(context, MainModel.getPageName(dorm, floor)),
          SizedBox(
            height: 100.0,
          ),
          Text('      세탁기',
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w700,
              )
          ),
              ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index){
                  i++;
                  return ListTile(
                    title:Text('dsafl',
                    style: TextStyle(
                      color: Colors.black
                    ),
                    )
                    //BuildSetakki(i, '영헌'),
                  );
                },

              ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child:
            ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              SizedBox(
                width: 35.0,
              ),
            ]),
          ),
          SizedBox(
            height: 60.0,
          ),
          Text('      건조기',
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w700,
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child:
            ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              SizedBox(
                width: 35.0,
              ),
            ]),
          ),
        ]);
  }*/
/*
  Widget buildColumn(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index){
              i++;
              return Container(
                child: ListTile(
                  dense: true,
                    title:Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                    )
                ),
              );
            },
          ),
        ]);
  }
  */
}
