import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class pageview extends StatefulWidget {
  @override
  State<pageview> createState() => _pageviewState();
}

class _pageviewState extends State<pageview> {
  CarouselController buttonCarouselController = CarouselController();
  int position = 0;

  List<String> img = [
    "backgroundimg/p1.jpg",
    "backgroundimg/p1.jpg",
    "backgroundimg/p1.jpg",
    "backgroundimg/p1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Center(
                      child: Center(
                        child: Image.asset(
                          "backgroundimg/pngwing.com.png",
                          fit: BoxFit.fill,
                        ),
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
                height: 500,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: img.map((e) {
                int index = img.indexOf(e);
                return Container(
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: position == index ? Colors.black : Colors.grey),
                  width: 8,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
