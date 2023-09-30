import 'package:chaya_webadmin/views/screens/side_bar_screens/dynamic_carsoul.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/dynamic_file_upload.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/education_screen.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/events_screen.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/upload_banner_screen.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/users_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _filesList = [];
  String _urlPrivacy = "https://simpleacademysa.blogspot.com/2022/11/privacy-policy-for-chaya-app.html";

  getFiles() {
    return _firestore.collection('fileslibrary').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _filesList.add(doc['files']);
        });
      });
    });
  }

  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });
        break;

      case UserScreen.routeName:
        setState(() {
          _selectedItem = UserScreen();
        });
        break;


      case EducationScreen.routeName:
        setState(() {
          _selectedItem = EducationScreen();
        });
        break;

      case EventScreen.routeName:
        setState(() {
          _selectedItem = EventScreen();
        });
        break;

      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });
        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });
        break;

      case DynamicCarousel.routeName:
        setState(() {
          _selectedItem = DynamicCarousel();
        });
        break;

      case FileUpload.routeName:
        setState(() {
          _selectedItem = FileUpload();
        });
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Color(0xff212333),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white70
        ),
        title: Text('MenuBar',style: TextStyle(color: Colors.white70),),
        backgroundColor: Color(0xff292D3F)
      ),
      sideBar: SideBar(
        iconColor: Colors.lightGreenAccent,
        textStyle: TextStyle(color: Colors.lightGreenAccent,fontSize: 12),
        backgroundColor: Color(0xff292D3F),
        borderColor: Color(0xff292D3F),
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            icon: CupertinoIcons.doc_text_fill,
            route: DashboardScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Users',
            icon: CupertinoIcons.person_3,
            route: UserScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Education',
            icon: CupertinoIcons.book,
            route: EducationScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Events',
            icon: CupertinoIcons.app_badge_fill,
            route: EventScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category_outlined,
            route: CategoriesScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            icon: CupertinoIcons.add_circled,
            route: UploadBannerScreen.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Upload Carousel ',
            icon: CupertinoIcons.photo_fill_on_rectangle_fill,
            route: DynamicCarousel.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
          AdminMenuItem(
            title: 'Upload Files',
            icon: CupertinoIcons.folder_fill_badge_person_crop,
            route: FileUpload.routeName,
            // textStyle: TextStyle(color: Colors.white),
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Color(0xff292D3F),
          child: Column(
            children: [
              CircleAvatar(
                radius: 26,
                child:Image.asset('images/chayalogo.png',fit:BoxFit.cover),
              ),
              SizedBox(height: 10,),
              Text(
                "CHAYA ADMIN PANEL",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10,),
            ],
          )
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Color(0xff292D3F),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text(
                          "About US",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  content: Container(
                                    height: 280,
                                    width: 480,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            " Company Name\n devXgeo IT",
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 16,
                                              color: const Color(0xFF2BAD93),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "\n\nDeveloped By\n",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: const Color(0xFF2BAD93),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  "Nahid Hassan Akanto\n\nFounder of devXgeo IT\n\nFlutter Developer\n\nJava \nDeveloper",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                    const Color(0xFF2BAD93),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  "Sayeem Isteak\n\nFounder  of Simple Academy\n\nFlutter Developer\n\nApp \ndesigner",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: const Color(0xFF2BAD93),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )));
                        },
                      ),
                      TextButton(
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        onPressed: _launchPrivacy,
                      ),
                      TextButton(
                        child: Text(
                          "Terms & \nConditions",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        onPressed: _launchPrivacy,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ) ,
        ),
      ),
      body: _selectedItem,
    );
  }
  void _launchPrivacy() async {
    if (!await launch(_urlPrivacy)) throw 'Couldnot launch $_urlPrivacy';
  }
}
