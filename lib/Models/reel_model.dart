import 'package:instagram/utils/default_values.dart';

class ReelModel {
  final String videoUrl;
  final String thumbnailUrl;
  final String caption;
  final String username;
  final String profileImageUrl;
  final int likeCount;
  final int commentCount;

  ReelModel({
    String? id,
    String? videoUrl,
    String? thumbnailUrl,
    String? caption,
    String? username,
    String? profileImageUrl,
    int? likeCount,
    int? commentCount,
  }) : videoUrl = videoUrl ?? '',
       thumbnailUrl = thumbnailUrl ?? DefaultValues.defaultProfileImage,
       caption = caption ?? '',
       username = username ?? DefaultValues.defaultUsername,
       profileImageUrl = profileImageUrl ?? DefaultValues.defaultProfileImage,
       likeCount = likeCount ?? 0,
       commentCount = commentCount ?? 0;

  factory ReelModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ReelModel();

    return ReelModel(
      videoUrl: json['video_url']?.toString(),
      thumbnailUrl: json['thumbnail_url']?.toString(),
      caption: json['caption']?.toString() ?? json['title']?.toString() ?? '',
      username: json['user']?['username']?.toString(),
      profileImageUrl: json['user']?['profile_pic_url']?.toString(),
      likeCount: json['like_count'] as int?,
      commentCount: json['comment_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'video_url': videoUrl,
    'thumbnail_url': thumbnailUrl,
    'caption': caption,
    'username': username,
    'profile_image_url': profileImageUrl,
    'like_count': likeCount,
    'comment_count': commentCount,
  };
}
