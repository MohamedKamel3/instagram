import 'package:flutter/material.dart';
import 'package:instagram/Pages/error_page.dart';
import 'package:instagram/Pages/user.dart';
import 'package:instagram/Services/insta_api.dart';
import 'package:instagram/Tools/custom_text.dart';
import 'package:instagram/Tools/text_field_decoration.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  Map userInfo = {};
  var api = InstaApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instagram",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Ionicons.logo_instagram,
                size: 100,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 20),
            CustomText(text: "Enter your username"),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: decoration(),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                if (controller.text.isEmpty) {
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }
                var username = controller.text;
                var result = await api.getUserInfo(username, userInfo);
                var response = result;
                if (response == "200") {
                  print(userInfo['username']);
                  Navigator.pushNamed(
                    context,
                    UserPage.id,
                    arguments: userInfo,
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    ErrorPage.id,
                    arguments: {'errorMessage': response},
                  );
                }
                setState(() {
                  isLoading = false;
                });
              },
              child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
