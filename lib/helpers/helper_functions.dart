import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperFunctions {
  Future showAlert(
    BuildContext context,
    String title,
    String content,
    IconData icon, {
    bool isSuccess = false,
  }) {
    return showDialog<Null>(
      context: context,
      builder: (ctx) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: !isSuccess ? Colors.red : Colors.green,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(title),
              ],
            ),
            content: Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              )
            ],
          );
        }
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                icon,
                color: !isSuccess ? Colors.red : Colors.green,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          ),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
