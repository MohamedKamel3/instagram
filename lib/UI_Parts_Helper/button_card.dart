import 'package:flutter/material.dart';
import 'package:instagram/Tools/custom_text.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                CustomText(
                  text: "Following",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomText(
              text: "message",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.person_add_alt_1_outlined),
          ),
        ],
      ),
    );
  }
}
