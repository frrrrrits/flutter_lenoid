import 'package:flutter/material.dart';

extension Toast on BuildContext {
  void showSnackBar(String text) {
    final scaffold = ScaffoldMessenger.of(this);
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
