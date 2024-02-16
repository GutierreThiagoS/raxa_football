
import 'package:flutter/material.dart';

void showDialogConfirm(
    BuildContext context,
    String? title,
    String message,
    Function() confirm
) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        scrollable: true,
        content: Container(
            child: Text(message)
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Não'),
          ),
          TextButton(
            onPressed: () {
              confirm();
              Navigator.of(context).pop();
            },
            child: Text('Sim'),
          ),
        ],
      );
    },
  );
}

void showAlertConfirm(
    BuildContext context,
    String message,
    Function() confirm
) {
  showDialogConfirm(context, null, message, confirm);
}