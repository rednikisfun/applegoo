import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:applegoo/quiz/question_widget.dart';
import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  Quiz({
    @required this.name,
  });
  final name;
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _finished = false;
  PageController _controller = PageController();
  List<Map<String, String>> questionsSet = [
    {
      'question': 'How much of Google\'s traffic comes from Apple devices?',
      'answer0': '35%',
      'answer1': '80%',
      'answer2': '50%',
    },
    {
      'question': 'Why does Google pay Apple \$8-\$12 billions?',
      'answer0': 'To be a default search engine in Safari, Spotlight and Siri',
      'answer1':
          'To be able to show information about Apple in Google Search engine',
      'answer2': 'To get user data from Apple Inc.',
    },
    {
      'question': 'If you were Apple, what would you do?',
      'answer0': 'Create my own search engine',
      'answer1': 'Buy already existing search engine',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _finished
          ? PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                Container(
                  child: QuestionWidget(
                    height: height,
                    questionsSet: questionsSet,
                    width: width,
                    controller: _controller,
                    pageIndex: 1,
                    questionIndex: 0,
                  ),
                ),
                Container(
                  child: QuestionWidget(
                    height: height,
                    questionsSet: questionsSet,
                    questionIndex: 1,
                    width: width,
                    controller: _controller,
                    pageIndex: 2,
                  ),
                ),
                Container(
                  child: QuestionWidget(
                    height: height,
                    questionsSet: questionsSet,
                    questionIndex: 2,
                    width: width,
                    controller: _controller,
                    pageIndex: 3,
                    hasOwnVersion: true,
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          'Thank you for the replies!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          'Correct answers: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          '1. Half of Google\'s traffic comes from Apple devices',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          '2. Google pays \$8-\$12 billions to be a default search engine in several applications in Apple devices',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          '3. No correct answer, just your opinion was needed!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    widget.name != null && widget.name.isNotEmpty
                        ? 'Hello, ${widget.name}'
                        : 'Hello, stranger',
                    duration: Duration(
                      seconds: 5,
                    ),
                    textStyle: TextStyle(
                      fontSize: width * 0.1,
                    ),
                  ),
                ],
                isRepeatingAnimation: false,
                onFinished: () {
                  setState(() {
                    _finished = true;
                  });
                },
              ),
            ),
    );
  }
}
