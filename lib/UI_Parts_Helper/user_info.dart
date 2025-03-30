import 'package:flutter/material.dart';
import 'package:instagram/Tools/format_number.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.userInfo,
    required this.posts,
    required this.isPrivate,
  });
  final Map userInfo;
  final int posts;
  final bool isPrivate;
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
              backgroundImage: NetworkImage(
                userInfo['hd_profile_pic_url_info']['url'],
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
                formatNumber(userInfo['follower_count']),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
                userInfo['following_count'].toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
