import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilmtop/const/size_config.dart';
import 'package:ilmtop/data/servise/servisauth.dart';
import 'package:ilmtop/presintation/home/homescreen.dart';
import 'package:ilmtop/presintation/login/loginscreen.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  late Services _apiService;
  @override
  void initState() {
    super.initState();
      Timer(
        const Duration(seconds: 5),
        () {
           _apiService = Helper();
      _apiService.isLogin().then((value) {
        if (value == 'logged') {
          Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
        } else { Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyCustomLoginUI(),
            ),
          );}
      });
        },
      );
  
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
   
    SizeConfig().init(context);
    return Scaffold(
      body:Container(
 decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.9, -0.3),
          colors: <Color>[
            Colors.black,
            Colors.cyanAccent
          ], 
          tileMode: TileMode.repeated, 
        ),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: h*0.1,),
         Container(
           height: h*0.5,
           width: w,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/splashlogo.png"))),
             ),
             SizedBox(height: h*0.02,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText("Ilm ",textStyle: GoogleFonts.b612Mono(fontStyle: FontStyle.italic,fontSize: 30,fontWeight: FontWeight.w600,color: Colors.black),),
              ],
              repeatForever: true,
              isRepeatingAnimation: true,
            ), AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(" Top",textStyle: GoogleFonts.b612Mono(fontStyle: FontStyle.italic,fontSize: 30,fontWeight: FontWeight.w600,color: Colors.teal),),
              ],
              repeatForever: true,
              isRepeatingAnimation: true,
            ),
          ],
        ),
    
        ],),
      )
      
       
      
      
    );
  }
}
