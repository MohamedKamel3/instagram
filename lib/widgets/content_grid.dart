import 'package:flutter/material.dart';
import 'package:instagram/Models/follower_model.dart';
import 'package:instagram/Models/reel_model.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/utils/default_values.dart';
import 'package:redacted/redacted.dart';

class ContentGrid extends StatelessWidget {
  final List<dynamic> items;
  final bool isLoading;
  final Function(int)? onItemTap;
  final String imageKey;
  final bool isPrivate;

  const ContentGrid({
    super.key,
    required this.items,
    required this.isLoading,
    this.onItemTap,
    required this.imageKey,
    required this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: isLoading ? 0 : items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        String? imageUrl;

        if (item is PostModel) {
          imageUrl = item.thumbnailUrl;
        } else if (item is ReelModel) {
          imageUrl = item.thumbnailUrl;
        } else if (item is FollowerModel) {
          imageUrl = item.profilePicUrl;
        } else if (item is Map) {
          imageUrl = item[imageKey]?.toString();
        }

        return GestureDetector(
          onTap: () => onItemTap?.call(index),
          child: Image.network(
            imageUrl ?? DefaultValues.defaultProfileImage,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.error, color: Colors.white),
                ),
          ).redacted(
            context: context,
            redact: isLoading,
            configuration: RedactedConfiguration(
              defaultBorderRadius: BorderRadius.circular(1),
              animationDuration: const Duration(milliseconds: 800),
            ),
          ),
        );
      },
    ).redacted(context: context, redact: isLoading);
  }
}
