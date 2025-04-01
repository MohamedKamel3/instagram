import 'package:flutter/material.dart';

InputDecoration decoration() {
  return InputDecoration(
    hintText: "Username",
    hintStyle: TextStyle(color: Colors.white54),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.pinkAccent),
    ),
    filled: true,
    fillColor: Colors.white24,
  );
}
