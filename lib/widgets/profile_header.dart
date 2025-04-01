import 'package:flutter/material.dart';
import 'package:instagram/Models/follower_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/widgets/button_card.dart';
import 'package:instagram/widgets/category_info.dart';
import 'package:instagram/widgets/user_info.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final int postCount;
  final bool isPrivate;
  final bool isLoading;
  final List<FollowerModel> followers;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.postCount,
    required this.isPrivate,
    required this.isLoading,
    required this.followers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          UserInfo(
            userInfo: user,
            posts: postCount,
            isPrivate: isPrivate,
            isLoading: isLoading,
          ),
          const SizedBox(height: 10),
          CategoryInfo(
            user: user,
            isPrivate: isPrivate,
            followers: followers,
            isLoading: isLoading,
          ),
          const SizedBox(height: 10),
          ButtonCard(),
        ],
      ),
    );
  }
}
