import 'dart:convert';
import 'dart:io';
import 'package:e_app/homepage.dart';
import 'package:e_app/splacescreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class updatepg extends StatefulWidget {
  String Productid;
  String Productname;
  String Productprice;
  String Productdetail;
  String Productimg;

  updatepg(this.Productid, this.Productname, this.Productprice,
      this.Productdetail, this.Productimg);

  @override
  State<updatepg> createState() => _updatepgState();
}

class _updatepgState extends State<updatepg> {
  final ImagePicker _picker = ImagePicker();
  String productimg = "";
  bool pnamestatus = false;
  bool ppricestatus = false;
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdiscription = TextEditingController();
  String? userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userid = splacescreenpg.pref!.getString("id") ?? "";
    });
    String pofname = widget.Productname;
    productname.text = pofname;
    String pofprice = widget.Productprice;
    productprice.text = pofprice;
    String pofdetail = widget.Productdetail;
    productdiscription.text = pofdetail;
    String pofimg = widget.Productimg;

    print("IMG====$pofimg");
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double tnavigator = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyh = theight - tstatusbar - tnavigator;
    return Scaffold(
      // backgroundColor: Color(0xFFEE9E9E),
      body: WillPopScope(
        onWillPop: onback,
        child: SafeArea(
          child: Container(
            height: bodyh,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("backgroundimg/back1.jpeg"),
                    fit: BoxFit.cover,
                    opacity: 150)),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Update Product Image",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  thickness: 3,
                                  endIndent: 20,
                                  indent: 20,
                                ),
                                TextButton(
                                    onPressed: () async {
                                      // Capture a photo
                                      final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      setState(() {
                                        productimg = image!.path;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("Take Image")),
                                TextButton(
                                    onPressed: () async {
                                      // Pick an image
                                      final XFile? image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      setState(() {
                                        productimg = image!.path;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("Choose Image"))
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          border: Border.all(width: 1)),
                      child: Container(
                        // height: 100,
                        // width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://leachiest-draft.000webhostapp.com/Apicalling/${widget.Productimg}"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      toolbarOptions: ToolbarOptions(
                          cut: true, paste: true, selectAll: true, copy: true),
                      onChanged: (value) {
                        setState(() {
                          pnamestatus = false;
                        });
                      },
                      controller: productname,
                      decoration: InputDecoration(
                          errorText: pnamestatus ? "Enter Product name" : null,
                          hintText: "Enter product name",
                          labelText: "Product Name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      toolbarOptions: ToolbarOptions(
                          cut: true, paste: true, selectAll: true, copy: true),
                      onChanged: (value) {
                        setState(() {
                          ppricestatus = false;
                        });
                      },
                      controller: productprice,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          errorText:
                              ppricestatus ? "Enter Product price" : null,
                          hintText: "Enter product price",
                          labelText: "Product Price"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      toolbarOptions: ToolbarOptions(
                          cut: true, paste: true, selectAll: true, copy: true),
                      controller: productdiscription,
                      maxLines: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Discription",
                          labelText: "Product Discription"),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 10,
                            shadowColor: Colors.black),
                        onPressed: () async {
                          print("hello");
                          String pname = productname.text;
                          String pprice = productprice.text;
                          String pdetail = productdiscription.text;
                          List<int> ll = File(productimg).readAsBytesSync();
                          String productimagepic = base64Encode(ll);

                          Map editmap = {
                            "productid": widget.Productid,
                            "productname": pname,
                            "productprice": pprice,
                            "productdetail": pdetail,
                            "productdata": productimagepic,
                            "imageofproduct": widget.Productimg,
                          };

                          print("pathh==${widget.Productimg}");

                          if (pname.isEmpty) {
                            setState(() {
                              pnamestatus = true;
                            });
                          } else if (pprice.isEmpty) {
                            setState(() {
                              ppricestatus = true;
                            });
                          } else {
                            var url = Uri.parse(
                                'https://leachiest-draft.000webhostapp.com/Apicalling/updateproduct.php');
                            var response = await http.post(url, body: editmap);
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');

                            var update = jsonDecode(response.body);
                            myUpdatedetail detailupdate =
                                myUpdatedetail.fromJson(update);

                            if (detailupdate.connetion == 1) {
                              if (detailupdate.result == 1) {
                                EasyLoading.show(status: "Update....")
                                    .whenComplete(() {
                                  Future.delayed(Duration(seconds: 10))
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Update Successfully !"),
                                      duration: Duration(seconds: 2),
                                    ));

                                    EasyLoading.dismiss();
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return Homepg();
                                      },
                                    ));
                                  });
                                });
                              }
                            }
                          }
                        },
                        child: Text("Edit Details")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onback() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Save changes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure save this changes ?"),
          actions: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Homepg();
                          },
                        ));
                      },
                      child: Text("Yes")),
                  Divider(
                    height: 1,
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"))
                ],
              ),
            )
          ],
        );
      },
    );
    return Future.value(true);
  }
}

class myUpdatedetail {
  int? connetion;
  int? result;

  myUpdatedetail({this.connetion, this.result});

  myUpdatedetail.fromJson(Map<String, dynamic> json) {
    connetion = json['connetion'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connetion'] = this.connetion;
    data['result'] = this.result;
    return data;
  }
}
