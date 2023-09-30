import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashUsersWidget extends StatelessWidget {
  const DashUsersWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _carouselsStream =
        FirebaseFirestore.instance.collection('buyers').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _carouselsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.cyan,
          )); // Loading indicator
        }

        final int length = snapshot.data?.docs.length ?? 0;

        final screenWidth = MediaQuery.of(context).size.width / 3;

        return Container(
          //height: 80,
          width: screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff292D3F),
          ),
          child: ListTile(
            leading: Icon(Icons.people_alt_outlined,color: Colors.white,),
            title: Center(
              child: Text(
                'The Total Number Of Users Authenticated : $length',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
