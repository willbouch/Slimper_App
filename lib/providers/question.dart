import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slimper/main.dart';

class Question with ChangeNotifier {
  String id;
  String question;
  int upVotes;
  String askerId;
  List<dynamic> likers;

  Question({
    @required this.id,
    @required this.question,
    @required this.askerId,
    @required this.likers,
    this.upVotes = 1,
  });

  Future<void> upVote(String sessionId, String questionId) async {
    final url = MyApp.backendUrl + 'questions/upvote/$sessionId/$questionId';
    final userId = MyApp.userId;

    try {
      final response = await http.patch(url, body: {
        'userId': userId,
      });

      if (response.statusCode == 500) {
        throw new Exception(response.body.substring(
            response.body.indexOf("message") + 10, response.body.length - 2));
      }

      likers.add(userId);
      upVotes++;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> downVote(String sessionId, String questionId) async {
    final url = MyApp.backendUrl + 'questions/downvote/$sessionId/$questionId';
    final userId = MyApp.userId;

    try {
      final response = await http.patch(url, body: {
        'userId': userId,
      });

      if (response.statusCode == 500) {
        throw new Exception(response.body.substring(
            response.body.indexOf("message") + 10, response.body.length - 2));
      }

      likers.remove(userId);
      upVotes--;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
