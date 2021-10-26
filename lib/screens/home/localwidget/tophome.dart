import 'package:flutter/material.dart';
import 'package:wacoproject/model/main_model.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:wacoproject/utils/user.dart';

class TopHome extends StatelessWidget {
  int dorm;
  int floor;

  TopHome(this.dorm, this.floor);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var userName = UserData.userName;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children : [
              Text(
                  '안녕하세요 ',
                  style: body2style(color: darkGrey)
              ),
              Text(
                  '$userName',
                  style: head2style(color: darkGrey)
              ),
              Text(
                  '님',
                  style: body2style(color: darkGrey)
              ),
            ],
          ),
          Container(
            height: height*0.04,
            width: width*0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                  style: BorderStyle.solid,
                  width: 1,
                  color: grey
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:5, right:5),
              child: Center(
                  child: buildFlatButton(MainModel.getPageName(dorm, floor))
              ),
            ),
          ),
        ]

    );
  }

  FlatButton buildFlatButton(String dorm) {
    return FlatButton(
      onPressed: () {
        //Get.to(DormSettingPage(userName: userName));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
              dorm,
              style: subtitle2style(color: darkGrey)
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.settings,
              color: darkGrey,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}


