//import the material package
import 'package:flutter/material.dart';

import './models/db_connect.dart';
import './screens/home_screen.dart'; //the file we created

//run the main method
void main() {
  var db = DBconnect();
  // db.addQuestion(Question(id: '20', title: 'what is 20 x 10 ?', options: {
  //   '100': false,
  //   '200': true,
  //   '300': false,
  //   '400': false,
  // }));
  db.fetchQuestions();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //remove the debug banner
      debugShowCheckedModeBanner: false,
      //set a homepage
      home: HomeScreen(), //in a separate file
    );
  }
}
