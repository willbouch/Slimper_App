import 'package:flutter/material.dart';

class AddQuestionPopup extends StatelessWidget {
  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Add a new question !'),
      ),
      contentTextStyle: Theme.of(context).textTheme.caption,
      content: Container(
        height: MediaQuery.of(context).size.height / 5,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    size: 15,
                  ),
                  Text(' Has between 20 and 150 characters')
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.check_box,
                    size: 15,
                  ),
                  Text(' Ends with a ?')
                ],
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
                expands: false,
                maxLines: 3,
                maxLength: 150,
                controller: questionController,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(questionController.text);
          },
          child: Text(
            'Add question',
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ],
    );
  }
}
