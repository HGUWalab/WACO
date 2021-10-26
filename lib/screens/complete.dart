import 'package:flutter/material.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:get/get.dart';
import 'package:wacoproject/widgets/appbar.dart';
import '../widgets/button_theme.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/home/home.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: buildAppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Image.asset(
                'assets/completeCheckIcon.png',
                width: 100,
              ),
              SizedBox(height: 38,),
              Text('정상적으로 접수되었습니다\n감사합니다!',
                textAlign: TextAlign.center,
                style: body1style(color: primary, height: 2),
              ),
              SizedBox(height: 139,),
              ElevatedButton(
                  onPressed: (){},
                  style: longButtonStyle,
                  child: Text('홈으로',
                    style: body1style(color: white),
                  )
              )
            ],
          ),
        )
    );
  }
}