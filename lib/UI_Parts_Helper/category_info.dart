import 'package:flutter/material.dart';
import 'package:instagram/Tools/custom_text.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({super.key, required this.img});
  final List img;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Category", fontSize: 20),
        const SizedBox(height: 1),

        Row(
          children: [
            Transform.rotate(angle: -10, child: Icon(Icons.link)),
            const SizedBox(width: 10),
            CustomText(text: "https://www.example.com"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              height: 40,
              width: (img.length * 27) + 10,
              child: Stack(
                children: [
                  for (int i = 0; i < img.length; i++)
                    Positioned(
                      left: i * 22,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(img[i]),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                child: CustomText(
                  text: "Followed by mo12kw , khaled , messi and 3 others",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
