import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pageview extends StatefulWidget {
  @override
  State<pageview> createState() => _pageviewState();
}

class _pageviewState extends State<pageview> {
  CarouselController buttonCarouselController = CarouselController();
  int position = 0;

  List<String> img = [
    "carouselimage/c1.png",
    "carouselimage/c2.png",
    "carouselimage/c3.png",
    "carouselimage/c4.png",
    "carouselimage/c5.png",
    "carouselimage/c6.png",
    "carouselimage/c7.png",
    "carouselimage/c8.png",
    "carouselimage/c9.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF84E586),
      body: SafeArea(
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: img.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(color: Colors.greenAccent),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "${img[index]}",
                        fit: BoxFit.cover,
                      ),
                    ));
              },
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    position = index;
                  });
                },
                height: MediaQuery.of(context).size.height,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: img.map((e) {
            //     int index = img.indexOf(e);
            //     return Align(
            //       alignment: Alignment.bottomCenter,
            //       child: Container(
            //         height: 8,
            //         decoration: BoxDecoration(
            //             border: Border.all(width: 5),
            //             shape: BoxShape.circle,
            //             color: position == index ? Colors.black : Colors.grey),
            //         width: 8,
            //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            //       ),
            //     );
            //   }).toList(),
            // ),

            Align(
              alignment: Alignment.bottomCenter,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return loginpage();
                      },
                    ));
                  },
                  style: OutlinedButton.styleFrom(
                      elevation: 10,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: CupertinoColors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
