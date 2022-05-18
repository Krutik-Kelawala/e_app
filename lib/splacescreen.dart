import 'package:e_app/homepage.dart';
import 'package:e_app/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splacescreenpg extends StatefulWidget {
  static SharedPreferences? pref;

  @override
  State<splacescreenpg> createState() => _splacescreenpgState();
}

class _splacescreenpgState extends State<splacescreenpg> {
  bool loginstatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getpref();
  }

  getpref() async {
    splacescreenpg.pref = await SharedPreferences.getInstance();

    setState(() {
      loginstatus = splacescreenpg.pref!.getBool("login") ?? false;
    });

    Future.delayed(Duration(seconds: 10)).then((value) {
      if (loginstatus) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Homepg();
          },
        ));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return loginpage();
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84E586),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300,
            width: 350,
            child: Lottie.asset("lottieanimation/onlineshopping.json",
                fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
