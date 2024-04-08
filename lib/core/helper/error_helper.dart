import 'package:flutter/material.dart';

class ErrorHelper {
  ErrorHelper._();
  static Widget basicErrorWidget() {
    return const Center(
      child: Text("Something went wrong"),
    );
  }

  static Widget itemErrorWidget() {
    return const Text("Something went wrong");
  }
}
