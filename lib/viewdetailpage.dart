import 'package:flutter/material.dart';

class viewdetailpg extends StatefulWidget {
  @override
  State<viewdetailpg> createState() => _viewdetailpgState();
}

class _viewdetailpgState extends State<viewdetailpg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Productname"),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Productname",
                textScaleFactor: 1,
              ),
            ),
          ),
          // SliverList(delegate: SliverChildBuilderDelegate())
        ],
      ),
    );
  }
}
