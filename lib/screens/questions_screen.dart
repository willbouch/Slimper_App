import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimper/providers/question.dart';
import 'package:slimper/providers/questions.dart';
import 'package:slimper/widgets/add_question_popup.dart';
import 'package:slimper/widgets/alert_message.dart';
import 'package:slimper/widgets/background.dart';
import 'package:slimper/widgets/question_item.dart';
import 'package:slimper/widgets/top_banner.dart';

class QuestionsScreen extends StatefulWidget {
  static final routeName = '/questions';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var _sessionId = '';
  var _myQuestionsOnly = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _sessionId = ModalRoute.of(context).settings.arguments as String;
      });
    });
    super.initState();
  }

  void addQuestion(String question) async {
    try {
      await Provider.of<Questions>(context).addQuestion(question, _sessionId);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) {
          return AlertMessage(
            title: 'Your question could not be sent',
            message: error.toString(),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Questions>(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Background(),
          TopBanner(
            screenSize: screenSize,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                BorderedText(
                  strokeWidth: 3.0,
                  strokeColor: Colors.black,
                  child: Text(
                    'Questions',
                    style: TextStyle(
                      fontFamily:
                          Theme.of(context).textTheme.headline2.fontFamily,
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Text(
                  'Session #$_sessionId',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('My questions',
                        style: Theme.of(context).textTheme.subtitle1),
                    Switch(
                      onChanged: (bool value) {
                        setState(() {
                          _myQuestionsOnly = !_myQuestionsOnly;
                        });
                      },
                      activeColor: Theme.of(context).accentColor,
                      value: _myQuestionsOnly,
                    ),
                  ],
                ),
              ],
            ),
          ),
          RefreshIndicator(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: screenSize.height / 1.57,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowGlow();
                        return false;
                      },
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          List<Question> questions =
                              data.getQuestions(_myQuestionsOnly);
                          return ChangeNotifierProvider.value(
                            value: questions[index],
                            child: Column(
                              children: <Widget>[
                                QuestionItem(
                                  questions[index],
                                  _sessionId,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: data.getQuestions(_myQuestionsOnly).length,
                      ),
                    ),
                  )
                ],
              ),
            ),
            onRefresh: () async {
              await data.fetchSessionQuestions(_sessionId);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final question = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return AddQuestionPopup();
            },
          );
          if (question != null) addQuestion(question);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
