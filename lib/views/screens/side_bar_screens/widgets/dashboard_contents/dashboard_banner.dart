import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBannerWidget extends StatefulWidget {
  const DashBannerWidget({Key? key}) : super(key: key);
  @override
  _DashBannerWidgetState createState() => _DashBannerWidgetState();
}

class _DashBannerWidgetState extends State<DashBannerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  @override
  void initState() {
    super.initState();
    final Stream<QuerySnapshot> _bannerStream = FirebaseFirestore.instance.collection('banners').snapshots();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Set the animation duration
    );

    _animation = IntTween(begin: 0, end: 0).animate(_controller);

    _bannerStream.listen((snapshot) {
      final length = snapshot.docs.length;
      _controller.reset();
      _animation = IntTween(begin: 0, end: length).animate(_controller);
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 5;

    return Container(
      height: 80,
      width: screenWidth/1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff292D3F),
      ),
      child: ListTile(
        leading: Icon(Icons.ads_click_rounded, color: Colors.white),
        title: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Text(
                'The Total Number Of Uses Banners : ${_animation.value}',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
