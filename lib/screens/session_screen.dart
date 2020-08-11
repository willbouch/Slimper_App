import 'dart:math';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:slimper/providers/questions.dart';
import 'package:slimper/screens/questions_screen.dart';
import 'package:slimper/widgets/alert_message.dart';
import 'package:slimper/widgets/animated_wave.dart';
import 'package:slimper/widgets/background.dart';
import 'package:slimper/widgets/top_banner.dart';

class SessionScreen extends StatefulWidget {
  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  bool _isLoading = false;

  void joinSession(BuildContext ctx, String sessionId) async {
    setState(() {
      _isLoading = true;
    });
    var isValidSession = await Provider.of<Questions>(ctx, listen: false)
        .fetchSessionQuestions(sessionId);
    if (isValidSession) {
      Navigator.of(ctx).pushNamed(
        QuestionsScreen.routeName,
        arguments: sessionId,
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      await showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertMessage(
            title: 'The session could not be joined',
            message: 'This session ID corresponds to no existing session',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextEditingController t = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Background(),
          createWave(140, 1.0, 0),
          createWave(80, 0.9, pi / 2),
          createWave(180, 1.2, pi),
          Stack(
            children: <Widget>[
              TopBanner(
                screenSize: screenSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/sloth.PNG',
                    fit: BoxFit.contain,
                    width: 350,
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isLoading
                    ? Column(
                        children: <Widget>[
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            'assets/images/sloth_sleeping.jpg',
                            height: 100,
                          )
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          BorderedText(
                            strokeWidth: 4.0,
                            strokeColor: Colors.black,
                            child: Text(
                              'Slimper',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Container(
                            width: 0.75 * screenSize.width,
                            child: PinCodeTextField(
                              textStyle: Theme.of(context).textTheme.subtitle1,
                              length: 6,
                              onChanged: null,
                              animationType: AnimationType.scale,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeColor: Theme.of(context).primaryColorDark,
                                inactiveColor:
                                    Theme.of(context).primaryColorLight,
                                selectedColor: Theme.of(context).primaryColor,
                              ),
                              backgroundColor: Colors.transparent,
                              onCompleted: (value) {
                                joinSession(context, value);
                              },
                              controller: t,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Enter Session ID',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createWave(double height, double speed, double offset) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedWave(
          height: height,
          speed: speed,
          offset: offset,
        ),
      ),
    );
  }
}
