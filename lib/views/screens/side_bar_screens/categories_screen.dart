import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {

  static const String routeName='\CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
  GlobalKey<FormState> _formKey= GlobalKey<FormState>();

  dynamic _image;
  String? fileName;
  late String categoryName;

  _pickImage()async{
    FilePickerResult? result= await FilePicker.platform
        .pickFiles(allowMultiple: false,type: FileType.image);
    if(result!= null){
      setState(() {
        _image=result.files.first.bytes;
        fileName=result.files.first.name;
      });
    }
  }

  _uploadCategoryBannerToStorage (dynamic image)async{
    Reference ref= _storage.ref().child('Categories').child(fileName!);
    UploadTask uploadTask=ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl= await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  uploadCategory()async{
    EasyLoading.show();
    if(_formKey.currentState!.validate()){
      String imageUrl= await _uploadCategoryBannerToStorage(_image);
      await _firestore.collection('categories').doc(fileName).set({
        'image':imageUrl,
        'categoryName':categoryName
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _image=null;
          _formKey.currentState!.reset();
        });
      });
    }else{
      print("oh good guy");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                  'Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
              ),
            ),

            Divider(color: Colors.white10,),

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
                        child:_image!= null? Image.memory(_image, fit: BoxFit.cover):
                        Center(
                          child: Text("Categories"),
                        ),
                      ),

                      SizedBox(height: 10,),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white70
                          ),
                          onPressed: (){
                            _pickImage();
                          }, child: Text("Upload Image"))
                    ],
                  ),
                ),
                Flexible(child:  SizedBox(
                  width: 180,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value){
                      categoryName=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please Category Name Must Not Be Empty";
                      }else{
                        return null;
                      }},
                      decoration: InputDecoration(
                        labelText: "Enter Category Name",
                        hintText:  "Enter Category Name",
                      ),
                    ),
                ),
    ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70
                    ),
                    onPressed: (){
                      uploadCategory();
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
                child: Text("Categories",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent
                  ),
                ),
              ),
            ),

           CategoryWidget(),


          ],
        ),
      ),
    );
  }
}