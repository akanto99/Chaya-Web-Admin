import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _carouselsStream = FirebaseFirestore.instance.collection('carousels').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream:_carouselsStream,
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

        return GridView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8
            ), itemBuilder: (context, index){
          final carouselData= snapshot.data!.docs[index];
          return Column(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.network(carouselData['image'],),
              ) ,

            ],
          );
        });
      },
    );
  }
}
