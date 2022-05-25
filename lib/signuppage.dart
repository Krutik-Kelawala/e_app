import 'dart:convert';
import 'dart:io';

import 'package:e_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'homepage.dart';

class signuppg extends StatefulWidget {
  @override
  State<signuppg> createState() => _signuppgState();
}

class _signuppgState extends State<signuppg> {
  final ImagePicker _picker = ImagePicker();

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController signuppassword = TextEditingController();
  String profileimg = "";
  // var emailvalid =
  //     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.com", caseSensitive: false);

  bool namestatus = false;
  bool numberstatus = false;
  bool emailstatus = false;
  bool passwordstatus = false;
  bool passwordhideshow = true; // for password hide show

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double tnavigator = MediaQuery.of(context).padding.bottom;
    double bodyh = theight - tstatusbar - tnavigator;
    return Scaffold(
      // backgroundColor: Color(0xFF84E586),
      body: SafeArea(
          child: Container(
        height: bodyh,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("backgroundimg/cart2.jpeg"),
                fit: BoxFit.cover,
                opacity: 200)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Sign Up ",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "here",
                      style: TextStyle(color: Colors.black, fontSize: 30))
                ])),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: IconButton(
                                          onPressed: () async {
                                            // Capture a photo
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              profileimg = image!.path;
                                            });
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.camera_alt,
                                            size: 40,
                                          )),
                                    ),
                                    Container(
                                      child: IconButton(
                                          onPressed: () async {
                                            // Pick an image
                                            final XFile? image =
                                                await _picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              profileimg = image!.path;
                                            });
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.image,
                                            size: 40,
                                          )),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: profileimg == ""
                            ? Container(
                                child: Icon(Icons.account_circle_rounded,
                                    size: 100),
                              )
                            : Container(
                                child: CircleAvatar(
                                  maxRadius: 100,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: FileImage(File(profileimg)),
                                ),
                              )),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            namestatus = false;
                          });
                        },
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true),
                        controller: name,
                        decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Enter Name here",
                            errorText:
                                namestatus ? "Please enter your name" : null,
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            numberstatus = false;
                          });
                        },
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true),
                        keyboardType: TextInputType.number,
                        controller: number,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            hintText: "Enter Number here",
                            errorText: numberstatus
                                ? "Please enter your number"
                                : null,
                            prefixIcon: Icon(Icons.call),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            emailstatus = false;
                          });
                        },
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter Email here",
                            errorText:
                                emailstatus ? "Please enter your email" : null,
                            prefixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true),
                        onChanged: (value) {
                          setState(() {
                            passwordstatus = false;
                          });
                        },
                        obscureText: passwordhideshow,
                        controller: signuppassword,
                        decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Password here",
                            errorText: passwordstatus
                                ? "Please enter your password"
                                : null,
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordhideshow = !passwordhideshow;
                                  });
                                },
                                icon: Icon(passwordhideshow
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: () async {
                            String pname = name.text;
                            String pnumber = number.text;
                            String pemail = email.text;
                            String personpassword = signuppassword.text;
                            List<int> iii = File(profileimg).readAsBytesSync();
                            String imagedata = base64Encode(iii);

                            Map map = {
                              "Name": pname,
                              "Contact": pnumber,
                              "Email": pemail,
                              "Password": personpassword,
                              "Imagedata": imagedata
                            };

                            if (pname.isEmpty) {
                              setState(() {
                                namestatus = true;
                              });
                            } else if (pnumber.isEmpty) {
                              setState(() {
                                numberstatus = true;
                              });
                            } else if (pemail.isEmpty &&
                                !pemail.contains("@") &&
                                !pemail.contains(".com")) {
                              setState(() {
                                emailstatus = true;
                              });
                            } else if (personpassword.isEmpty) {
                              setState(() {
                                passwordstatus = true;
                              });
                            } else {
                              var url = Uri.parse(
                                  'https://leachiest-draft.000webhostapp.com/Apicalling/register.php');
                              var response = await http.post(url, body: map);
                              print('Response status: ${response.statusCode}');
                              print('Response body: ${response.body}');

                              var regstration = jsonDecode(response.body);

                              Myreg reg = Myreg.fromJson(regstration);

                              if (reg.connection == 1) {
                                if (reg.result == 1) {
                                  EasyLoading.show(status: 'loading...')
                                      .whenComplete(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text("Registration Successsfully !"),
                                      duration: Duration(seconds: 2),
                                    ));
                                    EasyLoading.dismiss();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return loginpage();
                                      },
                                    ));
                                  });
                                } else if (reg.result == 2) {
                                  Fluttertoast.showToast(
                                      msg: "Email Already exits...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("Please try after some time..."),
                                  duration: Duration(seconds: 2),
                                ));
                              }
                            }

                            // EasyLoading.show(status: 'Loading.....');

                            // if (emailvalid.hasMatch(email.text.toString())) {
                            //   print("KrutikK18@gmail.com");
                            // } else {
                            //   print("KrutikK 18 @gmail .com");
                            // }
                            // else {
                            //   namestatus = false;
                            //   numberstatus = false;
                            //   emailstatus = false;
                            //   passwordstatus = false;
                            // }
                          },
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text("Sign Up")),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return loginpage();
                          },
                        ));
                      },
                      child: Container(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: "Already have account ? ",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black)),
                          TextSpan(
                              text: "Log in",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue))
                        ])),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class Myreg {
  int? connection;
  int? result;

  Myreg({this.connection, this.result});

  Myreg.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
