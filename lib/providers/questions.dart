import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:slimper/main.dart';
import 'package:slimper/providers/question.dart';
import 'package:http/http.dart' as http;

class Questions with ChangeNotifier {
  List<Question> _questions = [];

  List<Question> getQuestions(bool filtered) {
    if (filtered) {
      return _questions
          .where((question) => question.askerId == MyApp.userId)
          .toList();
    } else {
      return List.from(_questions);
    }
  }

  Future<bool> fetchSessionQuestions(String id) async {
    final url = MyApp.backendUrl + 'questions/$id';

    try {
      final response = await http.get(url);
      final extracted = json.decode(response.body) as Map<String, dynamic>;
      List<Question> loadedQuestions = [];

      if (extracted == null || extracted['statusCode'] == 500) {
        return false;
      }

      extracted.forEach((key, value) {
        loadedQuestions.add(Question(
            id: key,
            askerId: value['userId'],
            question: value['question'],
            upVotes: value['upVotes'],
            likers: value['likers']));
      });

      loadedQuestions.sort((a, b) => b.upVotes.compareTo(a.upVotes));
      _questions = loadedQuestions;
      notifyListeners();
      return true;
    } catch (error) {
      throw error;
    }
  }

  Future<void> addQuestion(String question, String sessionId) async {
    final url = MyApp.backendUrl + 'questions/$sessionId';
    final userId = MyApp.userId;
    try {
      final response = await http.post(
        url,
        body: {
          'question': question,
          'userId': userId,
        },
      );

      if (response.statusCode == 500) {
        throw new Exception(response.body.substring(
            response.body.indexOf("message") + 10, response.body.length - 2));
      }

      _questions.add(
        Question(
          id: response.body,
          askerId: userId,
          question: question,
          likers: [userId],
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> removeQuestion(Question question, String sessionId) async {
    final url = MyApp.backendUrl + 'questions/$sessionId/${question.id}';

    try {
      await http.delete(
        url,
      );

      _questions.remove(question);
      notifyListeners();
      return true;
    } catch (error) {
      throw error;
    }
  }
}
