import 'package:instagram/utils/default_values.dart';

class FollowerModel {
  final String username;
  final String fullName;
  final String profilePicUrl;

  FollowerModel({String? username, String? fullName, String? profilePicUrl})
    : username = username ?? DefaultValues.defaultUsername,
      fullName = fullName ?? 'Instagram User',
      profilePicUrl = profilePicUrl ?? DefaultValues.defaultProfileImage;

  factory FollowerModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return FollowerModel();

    return FollowerModel(
      username: json['username']?.toString(),
      fullName: json['full_name']?.toString(),
      profilePicUrl: json['profile_pic_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'full_name': fullName,
    'profile_pic_url': profilePicUrl,
  };
}
