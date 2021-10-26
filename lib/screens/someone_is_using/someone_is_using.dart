import 'package:flutter/material.dart';
import 'package:wacoproject/utils/colors.dart';
import 'package:wacoproject/utils/text.dart';
import 'package:get/get.dart';
import 'package:wacoproject/widgets/appbar.dart';
import 'package:wacoproject/widgets/button_theme.dart';
import 'package:wacoproject/model/empty_model.dart';
import 'package:wacoproject/screens/home/home.dart';

class SomeoneIsUsingPage extends StatelessWidget {
  const SomeoneIsUsingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: Text('하*님 사용중',
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
                  onPressed: (){},
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