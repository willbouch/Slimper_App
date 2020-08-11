import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimper/icons/custom_icons.dart';
import 'package:slimper/main.dart';
import 'package:slimper/providers/question.dart';
import 'package:slimper/providers/questions.dart';
import 'package:slimper/widgets/alert_message.dart';

class QuestionItem extends StatefulWidget {
  final Question question;
  final String sessionId;

  QuestionItem(this.question, this.sessionId);

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  bool _isLiked;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Question>(context);
    _isLiked = widget.question.likers.contains(MyApp.userId);

    return Dismissible(
      key: ValueKey(widget.question.id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 20,
        ),
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (dir) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return (widget.question.askerId == MyApp.userId)
                ? AlertDialog(
                    title: Text(
                      'Are you sure you want to delete this question ?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    content: Text(
                      'The question and its upvotes will be deleted forever.',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          'Yes',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  )
                : AlertMessage(
                    title: 'The question could not be deleted',
                    message: 'You can\'t delete someone else\'s question',
                  );
          },
        );
      },
      onDismissed: (direction) async {
        bool wasSuccess = await Provider.of<Questions>(context, listen: false)
            .removeQuestion(widget.question, widget.sessionId);
        if (wasSuccess)
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Question was successfully deleted',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 3),
            ),
          );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.white,
          child: ListTile(
            title: Text(
              widget.question.question,
              style: widget.question.askerId == MyApp.userId
                  ? Theme.of(context).textTheme.bodyText2
                  : Theme.of(context).textTheme.bodyText1,
            ),
            leading: Text(
              '${data.upVotes}',
              style: Theme.of(context).textTheme.caption,
            ),
            trailing: widget.question.askerId != MyApp.userId
                ? _isLiked
                    ? IconButton(
                        icon: Icon(
                          CustomIcons.thumbs_up_alt,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          data.downVote(widget.sessionId, widget.question.id);
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        })
                    : IconButton(
                        icon: Icon(
                          CustomIcons.thumbs_up_alt,
                        ),
                        onPressed: () {
                          data.upVote(widget.sessionId, widget.question.id);
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        },
                      )
                : null,
          ),
        ),
      ),
    );
  }
}
