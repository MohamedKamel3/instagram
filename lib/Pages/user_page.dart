import 'dart:math';

import 'package:flutter/material.dart';
import 'package:instagram/Models/follower_model.dart';
import 'package:instagram/Models/reel_model.dart';
import 'package:instagram/Pages/error_page.dart';
import 'package:instagram/Pages/video_page.dart';
import 'package:instagram/models/user_model.dart';
import 'package:instagram/models/post_model.dart';
import 'package:instagram/services/insta_api.dart';
import 'package:instagram/widgets/profile_header.dart';
import 'package:instagram/widgets/content_grid.dart';
import 'package:instagram/widgets/tab_bar.dart';

class UserPage extends StatefulWidget {
  static const String routeName = '/user';

  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final InstaApi _api = InstaApi();
  Map? _args;

  // Initialize with empty/default values
  List<PostModel> _posts = [];
  UserModel _user = UserModel(
    username: '',
    fullName: '',
    biography: '',
    profilePicUrl: '',
    followerCount: 0,
    followingCount: 0,
  );
  List<ReelModel> _reels = [];
  List<FollowerModel> _followers = [];

  bool _isLoading = true;
  bool _isPrivate = false;
  bool _hasReels = false;
  String? _errorMessage;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed) {
        final args = ModalRoute.of(context)?.settings.arguments as Map?;
        if (args != null && args['username'] != null) {
          _fetchUserData(args['username'] as String);
        }
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData(String username) async {
    try {
      if (!mounted) return;
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _isPrivate = false;
        _hasReels = true;
      });

      final results = await Future.wait([
        _api.getUserInfo(username),
        _api.getUserPosts(username),
        _api.getUserFollowers(username),
        _api.getUserReels(username),
      ], eagerError: true);

      if (!mounted) return;

      // Check for invalid username
      if (results.any((r) => r['status'] == 'Invalid')) {
        setState(() {
          _hasReels = false;
          _isLoading = false;
          _errorMessage = 'Invalid username';
        });
        return;
      }

      // Check for no reels
      if (results.any((r) => r['status'] == 'no reels')) {
        setState(() {
          _hasReels = false;
        });
      }

      // Check for private account
      if (results.any((r) => r['status'] == 'private')) {
        setState(() {
          _isPrivate = true;
          _isLoading = false;
          _user = UserModel.fromJson(results[0]['data'] ?? {});
        });
        return;
      }

      // Verify all responses have data
      for (final result in results) {
        if (result['data'] == null) {
          throw Exception('Missing data in API response');
        }
      }

      if (!mounted) return;
      setState(() {
        _user = UserModel.fromJson(results[0]['data']);
        _posts =
            (results[1]['data']['items'] as List)
                .map((e) => PostModel.fromJson(e))
                .toList();
        _followers =
            (results[2]['data']['items'] as List)
                .map((e) => FollowerModel.fromJson(e))
                .toList();
        if (_hasReels) {
          _reels =
              (results[3]['data']['items'] as List)
                  .map((e) => ReelModel.fromJson(e))
                  .toList();
        }
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('Error fetching user data: $e\n$stackTrace');
      if (!mounted) return;
      setState(() {
        _errorMessage = _getUserFriendlyError(e);
        _isLoading = false;
      });
    }
  }

  String _getUserFriendlyError(dynamic error) {
    final errorStr = error.toString();
    if (errorStr.contains('Network error')) {
      return 'Please check your internet connection';
    } else if (errorStr.contains('404')) {
      return 'User not found';
    } else if (errorStr.contains('API key')) {
      return 'Service configuration error';
    } else if (errorStr.contains('Private account')) {
      return 'This account is private';
    } else if (errorStr.contains('Invalid')) {
      return 'Invalid username';
    }
    return 'Failed to load data. Please try again later.';
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return ErrorPage(errorMessage: _errorMessage!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_user.username),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          ProfileHeader(
            user: _user,
            postCount: _posts.length,
            isPrivate: _isPrivate,
            isLoading: _isLoading,
            followers: _followers,
          ),
          const SizedBox(height: 16),
          if (!_isPrivate) CustomTabBar(controller: _tabController),
          Expanded(
            child:
                _isPrivate
                    ? _buildPrivateAccountContent()
                    : TabBarView(
                      controller: _tabController,
                      children: [
                        ContentGrid(
                          items: _posts,
                          isLoading: _isLoading,
                          imageKey: 'thumbnailUrl',
                          isPrivate: _isPrivate,
                        ),
                        ContentGrid(
                          items: _reels,
                          isLoading: _isLoading,
                          imageKey: 'thumbnailUrl',
                          onItemTap: _navigateToVideo,
                          isPrivate: _isPrivate,
                        ),
                        ContentGrid(
                          items: _followers,
                          isLoading: _isLoading,
                          imageKey: 'profilePicUrl',
                          isPrivate: _isPrivate,
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivateAccountContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 60, color: Colors.white70),
          const SizedBox(height: 20),
          Text(
            'This Account is Private',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'Follow to see their photos and videos',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _navigateToVideo(int index) {
    final reel = _reels[index];
    Navigator.pushNamed(
      context,
      VideoPage.routeName,
      arguments: {
        'videoUrl': reel.videoUrl ?? '',
        'caption': reel.caption ?? '',
        'username': reel.username ?? 'Unknown',
        'profileImageUrl': reel.profileImageUrl ?? 'assets/default_profile.png',
        'likeCount': (reel.likeCount ?? 0).toString(),
        'commentCount': (reel.commentCount ?? 0).toString(),
        'shareCount': '0', // Default value
      },
    );
  }
}
