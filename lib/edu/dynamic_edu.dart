
// class AddDataScreen extends StatefulWidget {
//   @override
//   _AddDataScreenState createState() => _AddDataScreenState();
// }
//
// class _AddDataScreenState extends State<AddDataScreen> {
//   TextEditingController questionController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   List<QuestionWidget> questionWidgets = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadQuestions();
//   }
//
//   void loadQuestions() async {
//     final firestore = FirebaseFirestore.instance;
//     final collection = firestore.collection('final_collection');
//     final doc = await collection.doc('TIS').get();
//
//     if (doc.exists) {
//       final List<dynamic> data = doc['data'];
//       setState(() {
//         questionWidgets.addAll(data.map((item) {
//           return QuestionWidget(
//             item['question'],
//             item['description'],
//             removeQuestion: removeQuestion,
//           );
//         }));
//       });
//     }
//     // Add one empty field for adding new questions
//     addQuestion();
//   }
//
//   void addQuestion() {
//     setState(() {
//       questionWidgets.add(QuestionWidget(
//         questionController.text,
//         descriptionController.text,
//         removeQuestion: removeQuestion,
//       ));
//       questionController.clear();
//       descriptionController.clear();
//     });
//   }
//
//   void removeQuestion(QuestionWidget questionWidget) {
//     setState(() {
//       questionWidgets.remove(questionWidget);
//     });
//   }
//
//   Future<void> saveDataToFirestore() async {
//     final firestore = FirebaseFirestore.instance;
//     final collection = firestore.collection('final_collection');
//     final data = questionWidgets.map((questionWidget) {
//       final question = questionWidget.questionController.text;
//       final description = questionWidget.descriptionController.text;
//       return {'question': question, 'description': description};
//     }).toList();
//
//     await collection.doc('TIS').set({'data': data});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Data to Firestore'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: questionWidgets,
//             ),
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: questionController,
//                     decoration: InputDecoration(labelText: 'Question'),
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: descriptionController,
//                     decoration: InputDecoration(labelText: 'Description'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: addQuestion,
//                 ),
//               ],
//             ),
//             Spacer(),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   saveDataToFirestore();
//                 },
//                 child: Text('Save'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class QuestionWidget extends StatelessWidget {
//   final TextEditingController questionController;
//   final TextEditingController descriptionController;
//   final Function(QuestionWidget) removeQuestion;
//
//   QuestionWidget(
//       String question,
//       String description, {
//         required this.removeQuestion,
//       })  : questionController = TextEditingController(text: question),
//         descriptionController = TextEditingController(text: description);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: questionController,
//                 decoration: InputDecoration(labelText: 'Question'),
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.cancel),
//               onPressed: () => removeQuestion(this),
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDataScreen extends StatefulWidget {
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<QuestionWidget> questionWidgets = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('final_collection');
    final doc = await collection.doc('TIS').get();

    if (doc.exists) {
      final List<dynamic> data = doc['data'];
      setState(() {
        questionWidgets.addAll(data.map((item) {
          return QuestionWidget(
            question: item['question'],
            description: item['description'],
            removeQuestion: removeQuestion,
            onDelete: () async {
              // Remove the data from Firestore and update the UI
              data.remove(item);
              await collection.doc('TIS').update({'data': data});
              removeQuestion(item);
            },
          );
        }));
      });
    }
    // Add one empty field for adding new questions
    addQuestion();
  }

  void addQuestion() {
    setState(() {
      questionWidgets.add(
        QuestionWidget(
          removeQuestion: removeQuestion,
          onDelete: () {},
        ),
      );
    });
  }

  void removeQuestion(QuestionWidget questionWidget) {
    setState(() {
      questionWidgets.remove(questionWidget);
    });
  }

  Future<void> saveDataToFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('final_collection');
    final data = questionWidgets.map((questionWidget) {
      final question = questionWidget.questionController.text;
      final description = questionWidget.descriptionController.text;
      return {'question': question, 'description': description};
    }).toList();

    await collection.doc('TIS').set({'data': data});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data is saved.'),
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => AddDataScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, //// Set the scaffold key
      backgroundColor: Color(0xff212333),
      appBar: AppBar(
        title: Center(child: Text('Dynamic Add Data to DataBase')),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: questionWidgets,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add, size: 50, color: Colors.white),
                  onPressed: addQuestion,
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 40,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    saveDataToFirestore();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Background color of the button
                    onPrimary: Colors.white, // Text color of the button
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding around the button's content
                    textStyle: TextStyle(
                      fontSize: 18, // Text size
                      fontWeight: FontWeight.w400, // Text weight
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // Button border radius
                    ),
                  ),
                  child: Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Function(QuestionWidget) removeQuestion;
  final VoidCallback onDelete;
  final String? question;
  final String? description;

  QuestionWidget({
    required this.removeQuestion,
    required this.onDelete,
    this.question,
    this.description,
  }) {
    questionController.text = question ?? '';
    descriptionController.text = description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                // onDelete();
                removeQuestion(this);
              },
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}



