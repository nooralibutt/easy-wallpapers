import 'dart:async' show Future;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future showCustomAlertDialog(BuildContext context, String title, String message,
    [String? buttonTitle]) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonTitle ?? "OK"),
    onPressed: () => Navigator.of(context).pop(),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [okButton],
  );
  // show the dialog
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future showRewardedAdAlertDialog(BuildContext context,
    {required VoidCallback onWatchAd,
    required String title,
    required String content}) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () => Navigator.of(context).pop(),
  );
  Widget watchAdButton = TextButton(
    onPressed: () {
      Navigator.of(context).pop();
      onWatchAd.call();
    },
    child: const Text("Watch Ad"),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [okButton, watchAdButton],
  );
  // show the dialog
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => alert,
  );
}

void printLog(String str) {
  if (kDebugMode) {
    print(str);
  }
}
