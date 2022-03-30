import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

void showSnackbar(
    {required String text,
    required BuildContext context,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
    ),
  );
}
