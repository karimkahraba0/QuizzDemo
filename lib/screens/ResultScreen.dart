import 'package:flutter/material.dart';
import 'package:small_quizz/screens/homeScreen.dart';
import 'package:small_quizz/screens/quizzplayScreen.dart';

class ResultScreen extends StatefulWidget {
  final int score, totalQuestion, correct, incorrect, notAttempted;
  ResultScreen(
      {this.score,
      this.totalQuestion,
      this.correct,
      this.incorrect,
      this.notAttempted});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var greeting = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var percentage = (widget.score / (widget.totalQuestion * 20)) * 100;
    if (percentage >= 90) {
      greeting = 'Outstanding';
    } else if (percentage > 80 && percentage < 90) {
      greeting = 'Good Work';
    } else if (percentage > 70 && percentage < 80) {
      greeting = 'Good Effort';
    } else if (percentage < 70) {
      greeting = 'Needs Improvement';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$greeting',style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w500)),
            SizedBox(height: 14),
            Text(
                'You Scored ${widget.score} out of ${widget.totalQuestion * 20}',style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Text(
                '${widget.correct} Correct , ${widget.incorrect} Incorrect & ${widget.notAttempted} NotAttempted out of  ${widget.totalQuestion}'),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => QuizPlay()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                child: Text('Replay Quiz Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 54),
                child: Text('Go To Home',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(color: Colors.blue, width: 2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
