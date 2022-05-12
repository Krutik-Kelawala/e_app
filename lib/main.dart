import 'package:animate_do/animate_do.dart';
import 'package:e_app/signuppage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: loginpage(),
  ));
}

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool usernamestatus = false;
  bool passwordstatus = false;
  bool passhideshow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84E586),
      body: FadeInDown(
        delay: Duration(seconds: 5),
        child: SafeArea(
            child: SingleChildScrollView(
                child: Center(
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
                child: Image.asset("backgroundimg/pngwing.com.png"),
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
                        onChanged: (value) {
                          setState(() {
                            usernamestatus = false;
                          });
                        },
                        toolbarOptions: ToolbarOptions(
                            selectAll: true,
                            paste: true,
                            cut: true,
                            copy: true),
                        controller: username,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "User Name",
                            hintText: "Enter Name here",
                            prefixIcon: Icon(Icons.person),
                            errorText: usernamestatus
                                ? "Please enter your name"
                                : null),
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
                            selectAll: true,
                            paste: true,
                            cut: true,
                            copy: true),
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
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ElevatedButton(
                          onPressed: () {
                            String pusername = username.text;
                            String puserpassword = password.text;

                            setState(() {
                              if (pusername.isEmpty) {
                                setState(() {
                                  usernamestatus = true;
                                });
                              }
                              if (puserpassword.isEmpty) {
                                setState(() {
                                  passwordstatus = true;
                                });
                              }
                              // else {
                              //   setState(() {
                              //     usernamestatus = false;
                              //     passwordstatus = false;
                              //   });
                              // }
                            });
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
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black)),
                          TextSpan(
                              text: "Sign Up",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.blue))
                        ])),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ))),
      ),
    );
  }
}
