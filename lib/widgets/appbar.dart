import 'package:flutter/material.dart';

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
