import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';



class FileUpload extends StatefulWidget {
  static const String routeName='\FileUpload';
  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  dynamic _files;
  String ? uploadFileName;

  pickFile()async{
    FilePickerResult? result= await FilePicker.platform
        .pickFiles(allowMultiple: false,type: FileType.any);
    if(result!= null){
      setState(() {
        _files=result.files.first.bytes;
        uploadFileName=result.files.first.name;
      });
    }
  }

  _uploadFilesToStorage (dynamic xfiles)async{
    Reference ref= _storage.ref().child('FilesLibrary').child(uploadFileName!);
    UploadTask uploadTask=ref.putData(xfiles);
    TaskSnapshot snapshot = await uploadTask;
    String downloadFileUrl= await snapshot.ref.getDownloadURL();
    return downloadFileUrl;
  }

  uploadToFileFireStore()async{
    EasyLoading.show();
    if(_files!= null){
      String fileUrl= await _uploadFilesToStorage(_files);
      await _firestore.collection('fileslibrary').doc(uploadFileName).
      set({
        'files':fileUrl,
        'Fname': uploadFileName
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _files=null;
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
                'Upload Files',
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



          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Files Library',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),

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
                        color: Color(0xff292D3F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _files!= null? Image.memory(_files):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.add,color: Colors.white70,),
                          SizedBox(width: 5,),
                          Text("Add Files",style: TextStyle(color: Colors.white70),),
                        ],
                      )
                    ),

                    SizedBox(height: 10,),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff292D3F),
                        ),
                        onPressed: (){
                          pickFile();
                        }, child: Text("Upload Files from library"))
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff292D3F),
                  ),
                  onPressed: (){
                    uploadToFileFireStore();
                  }, child: Text("Save"))
            ],
          ),



        ],
      ),
    );
  }
}