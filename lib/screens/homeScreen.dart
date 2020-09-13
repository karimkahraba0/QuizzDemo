import 'package:flutter/material.dart';
import 'package:small_quizz/screens/quizzplayScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => QuizPlay()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Text('Start Quiz Now',
                style: TextStyle(color: Colors.white, fontSize: 17)),
          ),
        ),
      ),
    );
  }
}
