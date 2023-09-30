import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashCarouselWidget extends StatelessWidget {
  const DashCarouselWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _carouselsStream = FirebaseFirestore.instance.collection('carousels').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _carouselsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: Colors.cyan,
          )); // Loading indicator
        }

        final int length = snapshot.data?.docs.length ?? 0;
        final ScreenWidth=MediaQuery.of(context).size.width/5;
        return Container(
          height: 80,
          width: ScreenWidth/1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff292D3F),
          ),
          child: Center(
            child: Text('Total Carousels: $length', style: TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }
}
