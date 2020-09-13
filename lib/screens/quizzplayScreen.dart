import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:small_quizz/helper/data.dart';
import 'package:small_quizz/model/question_model.dart';
import 'package:small_quizz/screens/ResultScreen.dart';

class QuizPlay extends StatefulWidget {
  @override
  _QuizPlayState createState() => _QuizPlayState();
}

class _QuizPlayState extends State<QuizPlay>
    with SingleTickerProviderStateMixin {
  //from this list we will (get) the question models which have set
  List<QuestionModel> questions = List<QuestionModel>();
  int index = 0;
  int correct = 0, incorrect = 0, notAttempted = 0, points = 0;
  double beginAnim = 0.0;
  double endAnim = 1.0;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questions = getQuestions();
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    animation =
        Tween(begin: beginAnim, end: endAnim).animate(animationController);
    startAnim();
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          if (index < questions.length - 1) {
            index++;
            resetAnim();
            startAnim();
            notAttempted++;
          }else{
            notAttempted++;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ResultScreen(
              score: points,
              totalQuestion: questions.length,
              correct: correct,
              incorrect: incorrect,
              notAttempted: notAttempted,
            )));
          }
        });
      }
    });
  }

  startAnim() {
    animationController.forward();
  }

  resetAnim() {
    animationController.reset();
  }

  stopAnim() {
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${index + 1}/${questions.length}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Question',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    '$points',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Points',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Text('${questions[index].getQuestion()}?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 20.0),
            LinearProgressIndicator(
              value: animation.value,
            ),
            CachedNetworkImage(
              imageUrl: questions[index].getImageUrl(),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (questions[index].getAnswer() == 'True') {
                          setState(() {
                            points = points + 20;
                            index++;
                            correct++;
                            resetAnim();
                            startAnim();
                          });
                        } else {
                          points = points - 5;
                          index++;
                          incorrect++;
                          resetAnim();
                          startAnim();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text('True',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (questions[index].getAnswer() == 'False') {
                          setState(() {
                            points = points + 20;
                            index++;
                            correct++;
                            resetAnim();
                            startAnim();
                          });
                        } else {
                          points = points - 5;
                          index++;
                          incorrect++;
                          resetAnim();
                          startAnim();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Text('False',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
