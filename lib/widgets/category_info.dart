import 'package:flutter/material.dart';
import 'package:instagram/Models/follower_model.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/widgets/custom_text.dart';
import 'package:instagram/utils/format_followers.dart';
import 'package:redacted/redacted.dart';

class CategoryInfo extends StatelessWidget {
  const CategoryInfo({
    super.key,
    required this.isPrivate,
    required this.user,
    required this.followers,
    required this.isLoading,
  });

  final UserModel user;
  final bool isPrivate;
  final List<FollowerModel> followers;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final firstThreeNames = getFirstThreeFollowerNames(followers);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          CustomText(
            text: user.fullName,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ).redacted(
            context: context,
            redact: isLoading,
            configuration: RedactedConfiguration(
              defaultBorderRadius: BorderRadius.circular(20),
              animationDuration: const Duration(milliseconds: 800),
            ),
          ),
          const SizedBox(height: 10),
          CustomText(
            text: user.biography,
            fontSize: 16,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ).redacted(
            context: context,
            redact: isLoading,
            configuration: RedactedConfiguration(
              defaultBorderRadius: BorderRadius.circular(20),
              animationDuration: const Duration(milliseconds: 800),
            ),
          ),
          const SizedBox(height: 10),
          if (isPrivate)
            CustomText(text: "", fontSize: 16, color: Colors.white70)
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: (3 * 27) + 10,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < followers.length && i < 3; i++)
                        Positioned(
                          left: i * 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundImage: NetworkImage(
                                followers[i].profilePicUrl,
                              ),
                              onBackgroundImageError:
                                  (_, __) => const Icon(Icons.person),
                            ),
                          ),
                        ),
                    ],
                  ),
                ).redacted(
                  context: context,
                  redact: isLoading,
                  configuration: RedactedConfiguration(
                    defaultBorderRadius: BorderRadius.circular(20),
                    animationDuration: const Duration(milliseconds: 800),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: formatFollowers(firstThreeNames, followers.length),
                    fontSize: 16,
                    color: Colors.white70,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).redacted(
                    context: context,
                    redact: isLoading,
                    configuration: RedactedConfiguration(
                      defaultBorderRadius: BorderRadius.circular(20),
                      animationDuration: const Duration(milliseconds: 800),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  List<String> getFirstThreeFollowerNames(List<FollowerModel> followers) {
    return followers
        .take(3)
        .map((user) => user.username)
        .where((name) => name.isNotEmpty)
        .toList();
  }
}
