import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/text_field_decoration.dart';
import 'package:instagram/widgets/custom_text.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = '/';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    controller.text = "";
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
            CustomText(text: "Enter  username", fontSize: 20),
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
              onPressed: () {
                if (controller.text.isEmpty) {
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                Navigator.pushNamed(
                  context,
                  '/user',
                  arguments: {'username': controller.text},
                ).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              child:
                  isLoading
                      ? const CupertinoActivityIndicator(color: Colors.black)
                      : const CustomText(
                        text: "Search",
                        fontSize: 20,
                        color: Colors.white,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
