import 'package:flutter/material.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/utils/format_number.dart';
import 'package:redacted/redacted.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.userInfo,
    required this.posts,
    required this.isPrivate,
    required this.isLoading,
  });
  final UserModel userInfo;
  final int posts;
  final bool isPrivate;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.orangeAccent],
              ),
            ),
            child: CircleAvatar(
              radius: 45,
              backgroundImage:
                  isLoading ? null : NetworkImage(userInfo.profilePicUrl),
              backgroundColor: isLoading ? Colors.grey : Colors.transparent,
            ).redacted(
              context: context,
              redact: isLoading,
              configuration: RedactedConfiguration(
                defaultBorderRadius: BorderRadius.circular(20),
                animationDuration: const Duration(milliseconds: 800),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                isPrivate ? "?" : formatNumber(posts),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).redacted(
                context: context,
                redact: isLoading,
                configuration: RedactedConfiguration(
                  defaultBorderRadius: BorderRadius.circular(20),
                  animationDuration: const Duration(milliseconds: 800),
                ),
              ),
              SizedBox(height: 1),
              Text(
                "Posts",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatNumber(userInfo.followerCount),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).redacted(
                context: context,
                redact: isLoading,
                configuration: RedactedConfiguration(
                  defaultBorderRadius: BorderRadius.circular(20),
                  animationDuration: const Duration(milliseconds: 800),
                ),
              ),
              SizedBox(height: 1),
              Text(
                "Followers",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatNumber(userInfo.followingCount),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).redacted(
                context: context,
                redact: isLoading,
                configuration: RedactedConfiguration(
                  defaultBorderRadius: BorderRadius.circular(20),
                  animationDuration: const Duration(milliseconds: 800),
                ),
              ),
              SizedBox(height: 1),
              Text(
                "Following",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
