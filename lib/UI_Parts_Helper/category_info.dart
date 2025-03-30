import 'package:flutter/material.dart';
import 'package:instagram/Tools/custom_text.dart';
import 'package:instagram/Tools/format_followers.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({
    super.key,
    required this.posts,
    required this.p,
    required this.fullName,
    required this.img,
    required this.followersNames,
    required this.isPrivate,
  });
  final Map posts;
  final String p;
  final String fullName;
  final List img;
  final List<String> followersNames;
  final bool isPrivate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        CustomText(text: fullName, fontSize: 20),
        const SizedBox(height: 20),
        CustomText(text: p),
        const SizedBox(height: 10),
        if (isPrivate)
          CustomText(
            text: "This account is private",
            fontSize: 16,
            color: Colors.white,
          )
        else
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
                    text: formatFollowers(followersNames),
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
