import 'package:flutter/material.dart';

class DisplayMessage {
  static void showMessage(String message, BuildContext context,
      {Color? backgroundColor}) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor ?? Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      animation: kAlwaysDismissedAnimation,
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void errorMessage(String message, BuildContext context) {
    showMessage(message, context, backgroundColor: Colors.red);
  }

  static void successMessage(String message, BuildContext context) {
    showMessage(message, context, backgroundColor: Colors.green);
  }
}
