import 'dart:convert';

import 'package:e_app/signuppage.dart';
import 'package:e_app/splacescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    home: splacescreenpg(),
  ));
}

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // String errorhint = "";

  bool usernamestatus = false;
  bool passwordstatus = false;
  bool passhideshow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84E586),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         opacity: 100,
                  //         image: AssetImage("backgroundimg/p1.jpg"),
                  //         fit: BoxFit.cover)),
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Lottie.asset("lottieanimation/loginpganimation.json",
                fit: BoxFit.fill),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: RichText(
                text: TextSpan(
              children: [
                TextSpan(
                    text: "Login ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "here",
                    style: TextStyle(color: Colors.black, fontSize: 30))
              ],
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        usernamestatus = false;
                      });
                    },
                    toolbarOptions: ToolbarOptions(
                        selectAll: true, paste: true, cut: true, copy: true),
                    controller: username,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "User Name",
                        hintText: "Enter Email or Mobile no",
                        // suffixIcon: InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       errorhint = "* Enter Mobile number or Email";
                        //     });
                        //   },
                        //   child: Icon(
                        //     Icons.error,
                        //     color: Colors.red,
                        //   ),
                        // ),
                        prefixIcon: Icon(Icons.person),
                        errorText:
                            usernamestatus ? "Please enter your name" : null),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        passwordstatus = false;
                      });
                    },
                    toolbarOptions: ToolbarOptions(
                        selectAll: true, paste: true, cut: true, copy: true),
                    obscureText: passhideshow,
                    controller: password,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Password",
                        hintText: "Enter Password here",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passhideshow = !passhideshow;
                              });
                            },
                            icon: Icon(passhideshow
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        errorText: passwordstatus
                            ? "Please enter your password"
                            : null),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // for errorhint code

          //  Container(
          // padding: EdgeInsets.only(left: 10),
          //    child: Align(alignment: AlignmentDirectional.centerStart,
          //      child: Text(
          //        "${errorhint}",
          //        style: TextStyle(color: Colors.red),
          //      ),
          //    ),
          //  ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                      onPressed: () async {
                        String pusername = username.text;
                        String puserpassword = password.text;

                        Map loginmap = {
                          "Userlogin": pusername,
                          "Userpassword": puserpassword
                        };

                        if (pusername.isEmpty) {
                          setState(() {
                            usernamestatus = true;
                          });
                        } else if (puserpassword.isEmpty) {
                          setState(() {
                            passwordstatus = true;
                          });
                        } else {
                          var url = Uri.parse(
                              'https://leachiest-draft.000webhostapp.com/Apicalling/login.php');
                          var response = await http.post(url, body: loginmap);
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          var logindata = jsonDecode(response.body);

                          login log = login.fromJson(logindata);

                          if (log.connection == 1) {
                            if (log.result == 1) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("LogIn Successsfully !"),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Email or Password Invalid !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }

                          String? pid = log.userdata!.id;
                          String? pname = log.userdata!.name;
                          String? pcontact = log.userdata!.contact;
                          String? pemail = log.userdata!.email;
                          String? ppassword = log.userdata!.password;
                          String? pimage = log.userdata!.imagename;

                          splacescreenpg.pref!.setBool("login", true);

                          splacescreenpg.pref!.setString("id", pid!);
                          splacescreenpg.pref!.setString("name", pname!);
                          splacescreenpg.pref!.setString("contact", pcontact!);
                          splacescreenpg.pref!.setString("mail", pemail!);
                          splacescreenpg.pref!
                              .setString("password", ppassword!);
                          splacescreenpg.pref!.setString("image", pimage!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text("Sign in")),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return signuppg();
                      },
                    ));
                  },
                  child: Container(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Don't have account ? ",
                          style: TextStyle(fontSize: 10, color: Colors.black)),
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(fontSize: 20, color: Colors.blue))
                    ])),
                  ),
                )
              ],
            ),
          )
        ],
      )))),
    );
  }
}

class login {
  int? connection;
  int? result;
  Userdata? userdata;

  login({this.connection, this.result, this.userdata});

  login.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? contact;
  String? email;
  String? password;
  String? imagename;

  Userdata(
      {this.id,
      this.name,
      this.contact,
      this.email,
      this.password,
      this.imagename});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    email = json['email'];
    password = json['password'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['password'] = this.password;
    data['imagename'] = this.imagename;
    return data;
  }
}

// class Userdata {
//   String? id;
//   String? name;
//   String? contact;
//   String? email;
//   String? password;
//   String? imagename;
//
//   Userdata(
//       {this.id,
//       this.name,
//       this.contact,
//       this.email,
//       this.password,
//       this.imagename});
//
//   Userdata.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     contact = json['contact'];
//     email = json['email'];
//     password = json['password'];
//     imagename = json['imagename'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['contact'] = this.contact;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['imagename'] = this.imagename;
//     return data;
//   }
// }
