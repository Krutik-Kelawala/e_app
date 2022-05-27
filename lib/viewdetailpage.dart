import 'package:e_app/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      detailscreeload = true;
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
              title: Text("${widget.productname}"),
            ),
            body: WillPopScope(
              onWillPop: back,
              child: SingleChildScrollView(
                child: Container(
                  height: bodyh,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            // color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://leachiest-draft.000webhostapp.com/Apicalling/${widget.productimg}"),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1,
                        thickness: 3,
                      ),
                      SizedBox(
                        height: 20,
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
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1,
                        thickness: 3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                                "Description : \n${widget.productdetail}")),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: openCheckout,
                          icon: Icon(Icons.shopping_cart_outlined),
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

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_msWrDdI2wpXI8F',
      'amount': int.parse(widget.productprice) * 100,
      'name': widget.productname,
      // 'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '9638968680',
        'email': 'krutikkelawala181818@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }
}
