import 'package:e_app/splacescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepg extends StatefulWidget {
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  String? username;
  String? useremail;
  String? userimage;

  List<Widget> widgetlist = [Addproduct(), Viewproduct()];
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
      username = splacescreenpg.pref!.getString("name");
      // splacescreenpg.pref!.getString("contact");
      useremail = splacescreenpg.pref!.getString("mail");
      // splacescreenpg.pref!.getString("password");
      userimage = splacescreenpg.pref!.getString("image");

      print("image== ${userimage}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Homepage",
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
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
      backgroundColor: Colors.yellowAccent,
    );
  }
}
