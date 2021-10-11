import 'package:flutter/material.dart';
import 'package:wacoproject/utils/colors.dart';


final longButtonStyle = ElevatedButton.styleFrom(
    onPrimary: white, //글자색
    primary: primary, //배경색
    minimumSize: Size(250, 50),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)
        )
    )
);

final shortButtonStyle = ElevatedButton.styleFrom(
    onPrimary: primary, //글자색
    primary: white, //배경색
    minimumSize: Size(130, 40),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)
        )
    )
);