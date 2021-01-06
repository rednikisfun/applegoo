import 'package:flutter/material.dart';
import 'package:applegoo/app_data.dart';
import 'package:gsheets/gsheets.dart';

import 'package:provider/provider.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    @required this.height,
    @required this.questionsSet,
    @required this.width,
    @required this.pageIndex,
    @required this.questionIndex,
    @required this.controller,
    this.hasOwnVersion = false,
  });

  final double height, width;
  final List<Map<String, String>> questionsSet;
  final int pageIndex;
  final int questionIndex;
  final PageController controller;
  final bool hasOwnVersion;

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool isTapped = false;
  String text = '';
  GSheets gsheets;
  final _credentials = r'''
{
  "type": "service_account",
  "project_id": "applegoo",
  "private_key_id": "d26819f93af38658403acc21bcabfe1b6e12c22b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC9RVqw7kVQY3AH\nlcdAIBc4OMVtUeR2LKHuGu5mYhH5JWGTbxkBo7pX3G84LvLtA4S7il4XB/a6ly+E\nXxZcJ9ZT82CV2Ym4yWz1aFZWIizjuBcJ0ONEudHDCUM6K2A7d2AnMItTi8OCrICR\n6WGbPUTrX8O85KrmmzAsPPhJ3aiWzt+s+6vYdoQGiAPtOoWEkFCZYYKgH1JS6fNg\nSnW/OCHVhVBYidoiV00RuM1PMrcXPPYumo7ogKpBXa7qCc6StjmxjQ6CiMou9Bsf\nM1OTulvuQocRjEQknL2Gltb5RAWH6ZRxtzXd63V0DuKJnuGOg6VJpQZQr9Mk6zGQ\nqzBqi2dXAgMBAAECggEACZ0mVdqWGoog5iaImB+PkZNpcwiX9LXtEbwJEQB5QXEE\nvrYdcvTFYdiFRuxnk+KiXg5Rgi6TrN2oeofqVr41R+iSwHnSYfIyGFl3TTYi/Pwp\nIdGcKBQ4oFIHoEKuYPoXoCLHAo4Uw730ZLT4kfSWQoIH3lmB7s3CMChDdykM4Uze\nMeeYIbECyyUZ6bFWn9+PZSBRKg0le1fTxVUhJYP3XUJGk0sStskBbxCbhdY/8x/S\njafPN9JQn+yJsMRKhEiAP2gQipulrdE5MyvN8UlhLY5yVEnL7nt181wh/gNZLAU6\nrb4mKBWv/ErC4L6TZOeY96+qQgdNLJwFBM33Zn4LmQKBgQDnhULupNvCmJpUXf2/\nNV0oTO5hzFX3TQzpb5zIxdXN1zCMb0kptMTMLLiCEtGHlfdubYWMROSISy1Uxmbp\nF8N4XPqLRY+dv8qwmHPdyecHXsZ3kmvsKWPg/y8In2sh+T6RkKERRcObv6u1uAzG\nUsM2mEtFWzvxf0YukkrtQPwOSQKBgQDRSH2TSnrL0Ipofp1ookFm87Qcg/gGZoN2\nRI5DQM1grDgvjbw5dKlB5gFhEKPEwkd8Pl/G2F64/qigS/sM/qBtzmRr4pNZJ9eo\n9L+izMrP8JJk4OXdm72nXWMqMxPhvLOd3sj0yBfZbesSR3saGMT8tZ+1VuAm5Y78\nFgJdQipInwKBgENq3s63WvcTkP04UYe4dmQh4ti/s9jLqxLe2XztfxDttMlwLpHi\nfdwmuaPG7xTYarDRW6448YNuwMiK7bS6osUN7jdYDjYVf2RlQHg5LvlKc+ilzp96\nfgcqx/tu0LeX6MxinUR2WDumWM4VxkKKHyZquqB7rLzqHvm4x/DGl59hAoGAMWkt\nBMZz4YT1+J/UKC0OxfDJ2GWr/E7dwOGEuQomsylWBpwvEV2izIUyVClqkPzRhdrw\nH/Fbw8+UHmxx9Gp1lBdDjFktMsJ+X0yRpi01wQxqc9jJTJ4Fk+svi3oNuqEjwyUj\nSu+m+dXCx0kLHmk0sPlsoJLHT0epj4jevAfwFb8CgYB7Y+fzYtIn08ndV+YwNhL0\nBXpqvieHoAOZfLmhylJANAoBO3f16eR8PGTWNNNQS5fJ3uBqBkR36WP+3HKpHjM1\nCZrwjOXOWPs5/K30SRAOBEDCUydHfGjCz0gTyomlDxwgnz1YjmtGajojdqgZnC/f\nPfhyvRSUeCpf5+3XePXiSQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "applegoo@applegoo.iam.gserviceaccount.com",
  "client_id": "111836921608862634396",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/applegoo%40applegoo.iam.gserviceaccount.com"
}
''';
  final spreadsheetId = '1g57hI3VZT4i-omwVd0fUToaf-DM6fiVLDufxxKeYP5U';
  @override
  void initState() {
    gsheets = GSheets(_credentials);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: widget.height * 0.2,
              ),
              Text(
                widget.questionsSet[widget.questionIndex]['question'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.width * 0.04,
                ),
              ),
              SizedBox(
                height: widget.height * 0.1,
              ),
              SizedBox(
                width: widget.width * 0.6,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: widget.height * 0.05,
                        ),
                        shrinkWrap: true,
                        itemCount:
                            widget.questionsSet[widget.questionIndex].length -
                                1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await Provider.of<AppData>(context, listen: false)
                                  .addToAnswers(index);
                              if (widget.questionIndex == 2) {
                                Spreadsheet ss =
                                    await gsheets.spreadsheet(spreadsheetId);
                                // get worksheet by its title
                                Worksheet sheet =
                                    ss.worksheetByTitle('applegoo');
                                List answers =
                                    Provider.of<AppData>(context, listen: false)
                                        .answers;
                                // answers.add(index);

                                sheet.values.appendRow(
                                  answers,
                                );
                              }
                              widget.controller.animateToPage(
                                widget.pageIndex,
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Container(
                              width: widget.width * 0.5,
                              height: widget.height * 0.1,
                              child: Center(
                                child: Text(
                                  widget.questionsSet[widget.questionIndex]
                                      ['answer$index'],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: widget.height * 0.05,
                      ),
                      widget.hasOwnVersion
                          ? SizedBox(
                              width: widget.width * 1,
                              child: TextField(
                                onTap: () {
                                  setState(() {
                                    isTapped = true;
                                  });
                                },
                                onChanged: (value) {
                                  text = value;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: 'Your version',
                                ),
                                cursorColor: Colors.black,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: widget.height * 0.05,
                      ),
                      !isTapped
                          ? Container()
                          : FlatButton(
                              onPressed: () async {
                                await Provider.of<AppData>(context,
                                        listen: false)
                                    .addToAnswers(text);
                                if (widget.questionIndex == 2) {
                                  Spreadsheet ss =
                                      await gsheets.spreadsheet(spreadsheetId);
                                  // get worksheet by its title
                                  Worksheet sheet =
                                      ss.worksheetByTitle('applegoo');
                                  List answers = Provider.of<AppData>(context,
                                          listen: false)
                                      .answers;
                                  // answers.add(text);

                                  sheet.values.appendRow(
                                    answers,
                                  );
                                }
                                widget.controller.animateToPage(
                                  widget.pageIndex,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeIn,
                                );
                              },
                              color: Colors.white,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                width: widget.width * 0.2,
                                height: widget.height * 0.08,
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
                                      fontSize: widget.width * 0.02,
                                    ),
                                  ),
                                ),
                              ),
                            )
                    ],
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
