import 'package:e_app/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class viewdetailpg extends StatefulWidget {
  String productimg;
  String productname;
  String productprice;
  String productdetail;

  viewdetailpg(
      this.productimg, this.productname, this.productprice, this.productdetail);

  @override
  State<viewdetailpg> createState() => _viewdetailpgState();
}

class _viewdetailpgState extends State<viewdetailpg> {
  bool detailscreeload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      detailscreeload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double tstatusbar = MediaQuery.of(context).padding.top;
    double tnavigator = MediaQuery.of(context).padding.bottom;
    double appbarheight = kToolbarHeight;
    double bodyh = theight - tstatusbar - tnavigator - appbarheight;

    return detailscreeload
        ? Scaffold(
            appBar: AppBar(
              title: Text("Productname"),
            ),
            body: WillPopScope(
              onWillPop: back,
              child: SingleChildScrollView(
                child: Container(
                  height: bodyh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 300,
                        width: 200,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            // color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://leachiest-draft.000webhostapp.com/Apicalling/${widget.productimg}"),
                                fit: BoxFit.fill)),
                      ),
                      Divider(
                        height: 1,
                        thickness: 3,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "${widget.productname}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Rs ${widget.productprice}\t /-",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 3,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                                "Description : \n${widget.productdetail}")),
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          icon: Icon(Icons.shop),
                          label: Text("Buy now"))
                    ],
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

  Future<bool> back() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Homepg();
      },
    ));
    return Future.value(true);
  }
}
