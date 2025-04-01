import 'package:flutter/material.dart';
import 'package:instagram/pages/home_page.dart';
import 'package:instagram/pages/user_page.dart';
import 'package:instagram/pages/video_page.dart';
import 'package:instagram/pages/error_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        UserPage.routeName: (context) => const UserPage(),
        ErrorPage.routeName: (context) => const ErrorPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == VideoPage.routeName) {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null ||
              args['videoUrl'] == null ||
              args['caption'] == null ||
              args['username'] == null ||
              args['profileImageUrl'] == null ||
              args['likeCount'] == null ||
              args['commentCount'] == null ||
              args['shareCount'] == null) {
            return MaterialPageRoute(builder: (context) => const ErrorPage());
          }

          return MaterialPageRoute(
            builder:
                (context) => VideoPage(
                  videoUrl: args['videoUrl'] as String,
                  caption: args['caption'] as String,
                  username: args['username'] as String,
                  profileImageUrl: args['profileImageUrl'] as String,
                  likeCount: args['likeCount'] as String,
                  commentCount: args['commentCount'] as String,
                  shareCount: args['shareCount'] as String,
                ),
          );
        }

        // Handle unknown routes
        return MaterialPageRoute(builder: (context) => const ErrorPage());
      },
    );
  }
}
