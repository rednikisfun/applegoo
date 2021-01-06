import 'package:applegoo/app_data.dart';
import 'package:applegoo/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String _name = '';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: width * 0.5,
          height: height * 0.7,
          child: Column(
            children: [
              Text(
                'What is your name?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width / 20,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  _name = value;
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.05,
                ),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.yellow[700],
                      width: 2.0,
                    ),
                  ),
                ),
                cursorColor: Colors.yellow[700],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              SizedBox(
                width: width * 0.2,
                height: height * 0.08,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Provider.of<AppData>(context, listen: false)
                          .setName(_name);
                      Provider.of<AppData>(context, listen: false)
                          .addToAnswers(_name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Quiz(
                            name: _name,
                          ),
                        ),
                      );
                    },
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: width * 0.2,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.grey[400],
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: width * 0.02,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
