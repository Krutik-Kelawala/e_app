import 'dart:convert';
import 'dart:io';

import 'package:e_app/splacescreen.dart';
import 'package:e_app/updatepage.dart';
import 'package:e_app/viewdetailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
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

  List<Widget> widgetlist = [View_product(), Addproduct()];
  int productpage = 0;

  // bool searchiconstatus = false;

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
      // backgroundColor: Color(0xFF84E586),
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
    setState(() {
      userloginid = splacescreenpg.pref!.getString("id") ?? "";
      appload = true;
    });
  }

  String? userloginid;
  final ImagePicker _picker = ImagePicker();
  String productimg = "";
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController productdiscription = TextEditingController();

  bool pnamestatus = false;
  bool ppricestatus = false;

  bool appload = false;

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double tnavigator = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyh = theight - tstatusbar - tnavigator - appbarheight;
    return appload
        ? Scaffold(
            // backgroundColor: Color(0xFFEE9E9E),
            body: WillPopScope(
              onWillPop: getback,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Update Product Image",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                                    source:
                                                        ImageSource.gallery);
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
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                border: Border.all(width: 1)),
                            child: productimg == ""
                                ? Icon(Icons.add_a_photo)
                                : Container(
                                    // height: 100,
                                    // width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                20),
                                        image: DecorationImage(
                                            image: FileImage(File(productimg)),
                                            fit: BoxFit.cover)),
                                  ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            toolbarOptions: ToolbarOptions(
                                cut: true,
                                paste: true,
                                selectAll: true,
                                copy: true),
                            onChanged: (value) {
                              setState(() {
                                pnamestatus = false;
                              });
                            },
                            controller: productname,
                            decoration: InputDecoration(
                                errorText:
                                    pnamestatus ? "Enter Product name" : null,
                                hintText: "Enter product name",
                                labelText: "Product Name"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            toolbarOptions: ToolbarOptions(
                                cut: true,
                                paste: true,
                                selectAll: true,
                                copy: true),
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
                                cut: true,
                                paste: true,
                                selectAll: true,
                                copy: true),
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
                                List<int> ll =
                                    File(productimg).readAsBytesSync();
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
                                  var response =
                                      await http.post(url, body: productmap);
                                  print(
                                      'Response status: ${response.statusCode}');
                                  print('Response body: ${response.body}');

                                  var productadd = jsonDecode(response.body);

                                  Addproductdata add_product =
                                      Addproductdata.fromJson(productadd);

                                  if (add_product.connection == 1) {
                                    if (add_product.result == 1) {
                                      EasyLoading.show(status: "Add to cart..")
                                          .whenComplete(() {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Product Successfully Added !"),
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
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Error !"),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  }
                                }
                              },
                              child: Text("Add Product")),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ));
  }

  Future<bool> getback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Homepg();
      },
    ));
    return Future.value(true);
  }
}

class Addproductdata {
  int? connection;
  int? result;

  Addproductdata({this.connection, this.result});

  Addproductdata.fromJson(Map<String, dynamic> json) {
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

class View_product extends StatefulWidget {
  @override
  State<View_product> createState() => _ViewproductState();
}

class _ViewproductState extends State<View_product> {
  String? userloginid;

  // List pofid = [];
  // List pname = [];
  // List pprice = [];
  // List pdetail = [];
  // List productimagepic = [];

  // int viewproductlength = 0;

  bool screenload = false;
  myviewproduct? View_product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      userloginid = splacescreenpg.pref!.getString("id") ?? "";
    });
    viewproductdata();
  }

  Future<void> viewproductdata() async {
    print("helloooo");
    var url = Uri.parse(
        'https://leachiest-draft.000webhostapp.com/Apicalling/viewproductdata.php');
    var response = await http.post(url, body: {
      "userid": userloginid,
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // if (View_product!.connection == 1) {
    //   if (View_product!.result == 1) {}
    // }

    setState(() {
      var viewdata = jsonDecode(response.body);
      View_product = myviewproduct.fromJson(viewdata);
      screenload = true;
    });
    return Future.value();

    // setState(() {
    //   viewproductlength = viewofproduct.viewproduct!.length;
    // });
    // for (int i = 0; i < viewproductlength; i++) {
    //   print("Length==${viewproductlength}");
    //   pofid.add(viewofproduct.viewproduct![i].productid);
    //   pname.add(viewofproduct.viewproduct![i].productname);
    //   pprice.add(viewofproduct.viewproduct![i].productprice);
    //   pdetail.add(viewofproduct.viewproduct![i].productdetail);
    //   productimagepic.add(viewofproduct.viewproduct![i].productimage);
    // }
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double tnavigator = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyh = theight - tstatusbar - tnavigator - appbarheight;
    return screenload
        ? Scaffold(
            body: RefreshIndicator(
              color: Colors.black,
              onRefresh: viewproductdata,
              child: Container(
                height: bodyh,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("backgroundimg/cart3.jpeg"),
                        fit: BoxFit.fill,
                        opacity: 200)),
                child: GridView.builder(
                  padding: EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  itemCount: View_product!.viewproduct!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return viewdetailpg(
                                View_product!.viewproduct![index].productimage!,
                                View_product!.viewproduct![index].productname!,
                                View_product!.viewproduct![index].productprice!,
                                View_product!
                                    .viewproduct![index].productdetail!);
                          },
                        ));
                      },
                      child: Card(
                        shadowColor: Colors.red,
                        elevation: 10,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.topEnd,
                              child: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == "edit") {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return updatepg(
                                            View_product!
                                                .viewproduct![index].productid!,
                                            View_product!.viewproduct![index]
                                                .productname!,
                                            View_product!.viewproduct![index]
                                                .productprice!,
                                            View_product!.viewproduct![index]
                                                .productdetail!,
                                            View_product!.viewproduct![index]
                                                .productimage!);
                                      },
                                    ));
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                        value: "edit",
                                        onTap: () {},
                                        child: Text("Edit")),
                                    PopupMenuItem(
                                      child: Text("Delete"),
                                      value: "delete",
                                      onTap: () async {
                                        Map deletemap = {
                                          "productid": View_product!
                                              .viewproduct![index].productid
                                        };

                                        var url = Uri.parse(
                                            'https://leachiest-draft.000webhostapp.com/Apicalling/delete.php');
                                        var response = await http.post(url,
                                            body: deletemap);
                                        print(
                                            'Response status: ${response.statusCode}');
                                        print(
                                            'Response body: ${response.body}');
                                      },
                                    )
                                  ];
                                },
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  // border: Border.all(width: 1),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://leachiest-draft.000webhostapp.com/Apicalling/${View_product!.viewproduct![index].productimage}"),
                                      fit: BoxFit.fill)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  padding: EdgeInsets.only(left: 10),
                                  height: 30,
                                  width: 100,
                                  child: Text(
                                      "${View_product!.viewproduct![index].productname}"),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  padding: EdgeInsets.only(right: 10),
                                  height: 20,
                                  // width: dou,
                                  child: Text(
                                      "Rs ${View_product!.viewproduct![index].productprice}"),
                                )
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       height: 30,
                            //       width: 50,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(width: 1), color: Colors.green),
                            //     ),
                            //
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ));
  }
}

class myviewproduct {
  int? connection;
  int? result;
  List<Viewproduct>? viewproduct;

  myviewproduct({this.connection, this.result, this.viewproduct});

  myviewproduct.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['viewproduct'] != null) {
      viewproduct = <Viewproduct>[];
      json['viewproduct'].forEach((v) {
        viewproduct!.add(new Viewproduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.viewproduct != null) {
      data['viewproduct'] = this.viewproduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Viewproduct {
  String? productid;
  String? productname;
  String? productprice;
  String? productdetail;
  String? productimage;
  String? userid;

  Viewproduct(
      {this.productid,
      this.productname,
      this.productprice,
      this.productdetail,
      this.productimage,
      this.userid});

  Viewproduct.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    productname = json['productname'];
    productprice = json['productprice'];
    productdetail = json['productdetail'];
    productimage = json['productimage'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['productprice'] = this.productprice;
    data['productdetail'] = this.productdetail;
    data['productimage'] = this.productimage;
    data['userid'] = this.userid;
    return data;
  }
}
