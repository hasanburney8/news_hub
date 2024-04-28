import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_hub/view/home_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height*1;
    final w = MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Image.asset('images/splash_pic.jpg',
              fit: BoxFit.cover,
              width: w*0.9,
              height: h*0.5,
            ),
            SizedBox(height: h*0.04,),
            Text('TOP HEADLINES'),
            SizedBox(height: h*0.04,),
            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
