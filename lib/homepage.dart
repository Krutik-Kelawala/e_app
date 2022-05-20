import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:e_app/splacescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepg extends StatefulWidget {
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  String? username;
  String? useremail;
  String? userimage;

  List<Widget> widgetlist = [Viewproduct(), Addproduct()];
  int productpage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getprefdata();
  }

  getprefdata() async {
    splacescreenpg.pref = await SharedPreferences.getInstance();

    setState(() {
      // splacescreenpg.pref!.getString("id");
      username = splacescreenpg.pref!.getString("name") ?? "";
      // splacescreenpg.pref!.getString("contact");
      useremail = splacescreenpg.pref!.getString("mail") ?? "";
      // splacescreenpg.pref!.getString("password");
      userimage = splacescreenpg.pref!.getString("image") ?? "";

      print("image== ${userimage}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: productpage == 1
          ? AppBar(
              title: Text(
                "Add Product",
              ),
            )
          : AppBar(
              title: Text(
                "View Product",
              ),
            ),
      backgroundColor: Color(0xFF84E586),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF44DCC4)),
                currentAccountPicture: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://leachiest-draft.000webhostapp.com/Apicalling/$userimage")),
                accountName: Text(
                  "${username}",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text("${useremail}",
                    style: TextStyle(color: Colors.black))),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  productpage = 1;
                });
              },
              leading: Icon(Icons.add_shopping_cart),
              title: Text("Add Product"),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  productpage = 0;
                });
              },
              leading: Icon(Icons.shop),
              title: Text("View Product"),
            )
          ],
        ),
      ),
      body: widgetlist[productpage],
    );
  }
}

class Addproduct extends StatefulWidget {
  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userloginid = splacescreenpg.pref!.getString("id") ?? "";
  }

  String? userloginid;
  final ImagePicker _picker = ImagePicker();
  String productimg = "";
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdiscription = TextEditingController();

  bool pnamestatus = false;
  bool ppricestatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEE9E9E),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 150,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Update Product Image",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () async {
                                  // Capture a photo
                                  final XFile? image = await _picker.pickImage(
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
                                  final XFile? image = await _picker.pickImage(
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
                  child: productimg == ""
                      ? Icon(Icons.add_a_photo)
                      : Container(
                          // height: 100,
                          // width: 100,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              image: DecorationImage(
                                  image: FileImage(File(productimg)),
                                  fit: BoxFit.cover)),
                        ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
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
                onChanged: (value) {
                  setState(() {
                    ppricestatus = false;
                  });
                },
                controller: productprice,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    errorText: ppricestatus ? "Enter Product price" : null,
                    hintText: "Enter product price",
                    labelText: "Product Price"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
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
                    String pname = productname.text;
                    String pprice = productprice.text;
                    String pdetail = productdiscription.text;
                    List<int> ll = File(productimg).readAsBytesSync();
                    String productimagepic = base64Encode(ll);

                    Map productmap = {
                      "userid": userloginid,
                      "nameofproduct": pname,
                      "priceofprodut": pprice,
                      "detailofproduct": pdetail,
                      "imageofproduct": productimagepic
                    };

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
                          'https://leachiest-draft.000webhostapp.com/Apicalling/adddproduct.php');
                      var response = await http.post(url, body: productmap);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                    }
                  },
                  child: Text("Add Product")),
            )
          ],
        ),
      ),
    );
  }
}

class Viewproduct extends StatefulWidget {
  @override
  State<Viewproduct> createState() => _ViewproductState();
}

class _ViewproductState extends State<Viewproduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}
