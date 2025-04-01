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
    // Handle empty state when not loading
    if (!isLoading && items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPrivate ? Icons.lock_outline : Icons.photo_library_outlined,
              size: 50,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              isPrivate ? 'This account is private' : 'No posts yet',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade400),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: isLoading ? 9 : items.length,
      itemBuilder: (context, index) {
        // Show loading placeholders
        if (isLoading) {
          return Container(color: Colors.grey.shade200).redacted(
            context: context,
            redact: true,
            configuration: RedactedConfiguration(
              defaultBorderRadius: BorderRadius.circular(1),
              animationDuration: const Duration(milliseconds: 800),
            ),
          );
        }

        // Handle actual content
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
          child:
              imageUrl != null
                  ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(color: Colors.grey.shade200);
                    },
                    errorBuilder:
                        (_, error, stackTrace) => _buildErrorPlaceholder(),
                  )
                  : _buildErrorPlaceholder(),
        );
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey.shade800,
      child: const Icon(Icons.error_outline, color: Colors.white),
    );
  }
}
