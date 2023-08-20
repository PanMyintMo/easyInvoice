import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showDeleteConfirmationDialogs(BuildContext context,String confirmationMessage, Function deleteAction,) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content:  Text(confirmationMessage),
        actions: [
          TextButton(
            onPressed: () {
              deleteAction();
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
