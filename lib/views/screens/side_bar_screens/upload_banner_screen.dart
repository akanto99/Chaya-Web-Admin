import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/banner_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class UploadBannerScreen extends StatefulWidget {
  static const String routeName='\ UploadBannerScreen';
  @override
  State<UploadBannerScreen> createState() => _UploadBannerScreenState();
}

class _UploadBannerScreenState extends State<UploadBannerScreen> {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  dynamic _image;
  String? fileName;

  pickImage()async{
    FilePickerResult? result= await FilePicker.platform
        .pickFiles(allowMultiple: false,type: FileType.image);
    if(result!= null){
      setState(() {
        _image=result.files.first.bytes;
        fileName=result.files.first.name;
      });
    }
  }

  _uploadBannersToStorage (dynamic image)async{
    Reference ref= _storage.ref().child('Banners').child(fileName!);
    UploadTask uploadTask=ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadToFireStore()async{
    EasyLoading.show();
    if(_image!= null){
      String imageUrl= await _uploadBannersToStorage(_image);
      await _firestore.collection('banners').doc(fileName).
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
                'Upload Banner',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey,),

          Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _image!= null? Image.memory(_image, fit: BoxFit.cover):
                    Center(
                      child: Text("Banner"),
                    ),
                  ),

                  SizedBox(height: 10,),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70
                      ),
                      onPressed: (){
                        pickImage();
                      }, child: Text("Upload Banners"))
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70
                ),
                onPressed: (){
                  uploadToFireStore();
                }, child: Text("Save"))
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
              child: Text("Banners",
                style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent
                ),
              ),
            ),
          ),

          BannerWidget(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text("Help and guidance",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent
                ),
              ),
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              tileColor: Color(0xff292D3F),
              leading: Icon(Icons.book_rounded,color: Colors.yellow.shade900,),
              title: Text('New Pages guide',style: TextStyle(color: Colors.white70),),
              subtitle: Text('Learn how to use your Page and get answers to frequently asked questions',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              tileColor: Color(0xff292D3F),
              leading: Icon(Icons.account_circle_outlined,color: Color(0xff2697ff),),
              title: Text('Creator Support',style: TextStyle(color: Colors.white70),),
              subtitle: Text('Centralised support and education for creator'
                ,style: TextStyle(color: Colors.white70),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              tileColor: Color(0xff292D3F),
              leading: Icon(Icons.question_mark),
              title: Text('Help Centre',style: TextStyle(color: Colors.white70),),
              subtitle: Text('Find articles and other resources to help solve common problems.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



