import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String message,
  required void Function() ok,
  bool trueFalseOption = true,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: trueFalseOption
            ? <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    ok();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes"),
                ),
              ]
            : <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    ok();
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
      );
    },
  );
}
