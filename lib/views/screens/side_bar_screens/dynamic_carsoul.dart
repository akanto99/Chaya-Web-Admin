
import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/carousel_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DynamicCarousel extends StatefulWidget {
  static const String routeName='\NewUploadLibrary';
  @override
  State<DynamicCarousel> createState() => _DynamicCarouselState();
}

class _DynamicCarouselState extends State<DynamicCarousel> {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  dynamic _image;
  String? fileName;

  pickCarouselImage()async{
    FilePickerResult? result= await FilePicker.platform
        .pickFiles(allowMultiple: false,type: FileType.image);
    if(result!= null){
      setState(() {
        _image=result.files.first.bytes;
        fileName=result.files.first.name;
      });
    }
  }

  _uploadCarouselToStorage (dynamic image)async{
    Reference ref= _storage.ref().child('CarouselS').child(fileName!);
    UploadTask uploadTask=ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadCarouselToFireStore()async{
    EasyLoading.show();
    if(_image!= null){
      String imageUrl= await _uploadCarouselToStorage(_image);
      await _firestore.collection('carousels').doc(fileName).
      set({'image':imageUrl}).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image=null;
        });
      })
      ;
    }
  }



  @override
  Widget build(BuildContext context) {
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
                'Carousel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.white10,
          ),

          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image!= null? Image.memory(_image, fit: BoxFit.cover):
                      Center(
                        child: Text("Carousel Banners"),
                      ),
                    ),

                    SizedBox(height: 10,),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white70
                        ),
                        onPressed: (){
                          pickCarouselImage();
                        }, child: Text("Upload Carousel Banners"))
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70
                  ),
                  onPressed: (){
                    uploadCarouselToFireStore();
                  }, child: Text("Save")),
              SizedBox(width: 50,),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Color(0xff2697ff),
                    width: 5
                  )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Storage',style: TextStyle(color: Colors.white70),),
                      Text('11%',style: TextStyle(color: Colors.white70),),
                    ],
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey,),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text("List Of Carousels",
                style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent
                ),
              ),
            ),
          ),

          CarouselWidget(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(color: Colors.red,),
          ),






        ],
      ),
    );
  }
}