import 'package:chaya_webadmin/views/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: kIsWeb || Platform.isAndroid?
    FirebaseOptions(
      apiKey: "AIzaSyCf6SGpTiTv5_zH7Vu9xI8SrNYSEqpPWUE",
      appId:"1:7385295636:web:4e2d53a8a669a7a2c57001" ,
      messagingSenderId: "7385295636",
      projectId:"chaya-final",
      storageBucket: "chaya-final.appspot.com",
    ):null );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: AddDataScreen(),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

//flutter run -d chrome --web-renderer html
// (ctrl+ enter)

