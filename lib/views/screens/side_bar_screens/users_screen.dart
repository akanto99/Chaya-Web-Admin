import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  static const String routeName = '\ UserScreen';
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {


  Widget _Header(String image, int flex) {
    return Expanded(
        flex: flex,
        child: Container(
          height: 80,
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border.all(
               width: 1,
                color: Colors.white10,
              ),
              color: Color(0xff292D3F) // color: Colors.yellow,
          ),
          child: Image.network(image)
        )
    );
  }

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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('buyers').snapshots();

    return SingleChildScrollView(
      child: Column(
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
                'Users',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
                stream:_usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                    );
                  }

                  return

                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black38,
                      child: Column(
                        children: [

                      Row(
                    children: [
                      _rowHeader('Image', 2),
                      _rowHeader('Full Name', 2),
                      _rowHeader('Email', 3),
                      _rowHeader('Address', 3),
                      _rowHeader('Number', 2),
                    ],
                  ),


                          SingleChildScrollView(
                            child: Container(
                               height: MediaQuery.of(context).size.height-22,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                final userData = snapshot.data!.docs[index];
                                return Row(
                                  children: [
                                // Image.network(carouselData['image'],
                                    _Header(userData['profileImage'], 2),
                                    _rowHeader(userData['fullName'], 2),
                                    _rowHeader(userData['email'], 3),
                                    _rowHeader(userData['address'], 3),
                                    _rowHeader(userData['phoneNumber'], 2),
                                  ],
                                );
                              },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                }
            ),
          ),
        ],
      ),
    );
  }
}
