//Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

//project imports:
import '../constants/app_assets_constant.dart';
import '../constants/app_string_constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: PhisonColors.primaryColor)],
        image: DecorationImage(
            image: AssetImage(PhisonImages.welcomeImagebg), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          //1st child = logo
          //2nd child = slong
          //3rd child = heading
          //4th child = sentence
          //5th child = Btn1
          //6th child = break line
          //7th child = Btn2
        ],
      ),
    );
  }
}
