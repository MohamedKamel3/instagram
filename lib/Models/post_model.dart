import 'package:instagram/utils/default_values.dart';

class PostModel {
  final String thumbnailUrl;
  final String? caption;
  final int likeCount;
  final int commentCount;

  PostModel({
    String? thumbnailUrl,
    this.caption,
    int? likeCount,
    int? commentCount,
  }) : thumbnailUrl = thumbnailUrl ?? DefaultValues.defaultProfileImage,
       likeCount = likeCount ?? 0,
       commentCount = commentCount ?? 0;

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PostModel();

    return PostModel(
      thumbnailUrl: json['thumbnail_url']?.toString(),
      caption: json['caption']?['text']?.toString(),
      likeCount: json['like_count'] as int?,
      commentCount: json['comment_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'thumbnail_url': thumbnailUrl,
    'caption': caption,
    'like_count': likeCount,
    'comment_count': commentCount,
  };
}
