import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  static const String routeName = '\EventScreen';
  Widget _rowHeader(String text, int flex) {
    return Expanded(
        flex: flex,
        child: Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white10,
              ),
              color: Color(0xff292D3F) // color: Colors.yellow,
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF3E4685),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Events',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
            ),
          ),
        ),
        SizedBox(height: 250,),
        Center(
            child: Text("No Events Available Right Now!", style: TextStyle(color: Colors.white),),),
      ],
    );





    //   SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.all(5.0),
    //         child: Container(
    //
    //           alignment: Alignment.topLeft,
    //           padding: const EdgeInsets.all(10),
    //           child: const Text(
    //             'Products',
    //             style: TextStyle(
    //               color: Colors.white70,
    //               fontWeight: FontWeight.w700,
    //               fontSize: 22,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           _rowHeader('IMAGE', 1),
    //           _rowHeader('NAME', 3),
    //           _rowHeader('PRICE', 2),
    //           _rowHeader('QUANTITY', 2),
    //           _rowHeader('ACTION', 1),
    //           _rowHeader('VIEW MORE', 1),
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
