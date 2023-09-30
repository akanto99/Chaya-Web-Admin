import 'package:chaya_webadmin/edu/dynamic_edu.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  static const String routeName = '\ EducationScreen';

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
              'Educations',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              ),
              textAlign: TextAlign.start,
            ),

          ),
        ),
        SizedBox(height: 10,),
       Expanded(child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Tapcon(context, () => AddDataScreen(), "TIS"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
               Tapcon(context, () => AddDataScreen(), "PSC"),
             ],
           ),
         ],
       ))
      ],
    );

  }

  Widget Tapcon(BuildContext context, Widget Function() Screen, String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
        },
        child: Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blue],
              stops: [0.0, 1.0], // Optional: Stops define the position of each color
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
