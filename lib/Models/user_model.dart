import 'package:instagram/utils/default_values.dart';

class UserModel {
  final String username;
  final String fullName;
  final String biography;
  final String profilePicUrl;
  final int followerCount;
  final int followingCount;

  UserModel({
    String? username,
    String? fullName,
    String? biography,
    String? profilePicUrl,
    int? followerCount,
    int? followingCount,
  }) : username = username ?? DefaultValues.defaultUsername,
       fullName = fullName ?? 'Instagram User',
       biography = biography ?? '',
       profilePicUrl = profilePicUrl ?? DefaultValues.defaultProfileImage,
       followerCount = followerCount ?? 0,
       followingCount = followingCount ?? 0;

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserModel();

    return UserModel(
      username: json['username']?.toString(),
      fullName: json['full_name']?.toString(),
      biography: json['biography']?.toString(),
      profilePicUrl: json['profile_pic_url']?.toString(),
      followerCount: json['follower_count'] as int?,
      followingCount: json['following_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'full_name': fullName,
    'biography': biography,
    'profile_pic_url': profilePicUrl,
    'follower_count': followerCount,
    'following_count': followingCount,
  };
}
