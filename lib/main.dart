import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:provider/provider.dart';
import 'package:slimper/providers/questions.dart';
import 'package:slimper/screens/questions_screen.dart';
import 'package:slimper/screens/session_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static String userId = ' ';
  static String backendUrl = 'https://slimper-backend.herokuapp.com/';
  static int themeColor = 0xff00bc65;
  static int themeColorLight = 0xff00d06f;
  static int themeColorDark = 0xff009550;

  void fetchUserId() async {
    userId = await FlutterUdid.udid;
  }

  @override
  Widget build(BuildContext context) {
    fetchUserId();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Questions(),
        ),
      ],
      child: MaterialApp(
        title: 'Slimper',
        theme: ThemeData(
          primaryColor: Color(themeColor),
          primaryColorDark: Color(themeColorDark),
          primaryColorLight: Color(themeColorLight),
          accentColor: Colors.black,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontFamily: 'PaytoneOne',
              fontSize: 80,
              color: Color(themeColor),
            ),
            headline2: TextStyle(
              fontFamily: 'PaytoneOne',
              fontSize: 40,
              color: Color(themeColor),
            ),
            subtitle1: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700
            ),
            bodyText1: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontFamily: 'Roboto',
              fontStyle: FontStyle.italic,
              fontSize: 15,
              color: Colors.black,
            ),
            caption: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.black,
            ),
            button: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(themeColor),
            ),
          ),
        ),
        home: SessionScreen(),
        routes: {
          QuestionsScreen.routeName: (ctx) => QuestionsScreen(),
        },
      ),
    );
  }
}
