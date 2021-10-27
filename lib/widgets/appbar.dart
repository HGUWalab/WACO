import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wacoproject/screens/home/home.dart';
import 'package:wacoproject/utils/colors.dart';

AppBar buildAppBar() {
  return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Container(
          width: 80.0,
          height: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo1.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
AppBar appBar2(double width, int dorm, int floor) {
  return AppBar(
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
            Get.to(HomePage(dorm: dorm, floor: floor));
          },
        )
    ),
  );
}
