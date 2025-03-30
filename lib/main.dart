import 'package:flutter/material.dart';
import 'package:instagram/Pages/error_page.dart';
import 'package:instagram/Pages/home_page.dart';
import 'package:instagram/Pages/user.dart';
import 'package:instagram/Pages/video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
      routes: {
        UserPage.id: (context) => UserPage(),
        VideoPage.id: (context) => VideoPage(),
        HomePage.id: (context) => HomePage(),
        ErrorPage.id: (context) => ErrorPage(),
      },
    );
  }
}
