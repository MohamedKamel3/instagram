import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:instagram/Tools/custom_text.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({
    super.key,
    required this.videoUrl,
    required this.caption,
    required this.username,
    required this.profileImageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });
  static const String id = 'videoPage';
  final String videoUrl;
  final String username;
  final String profileImageUrl;
  final String likeCount;
  final String commentCount;
  final String shareCount;
  final String caption;

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.setLooping(true);
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const CustomText(
          text: "Reel",
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Video Player
          GestureDetector(
            onTap: togglePlayPause,
            child: Center(
              child:
                  _controller.value.isInitialized
                      ? VideoPlayer(_controller)
                      : const CircularProgressIndicator(),
            ),
          ),

          // Right Floating Buttons
          Positioned(
            right: 15,
            bottom: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildIconWithText(Icons.favorite_border, widget.likeCount),
                const SizedBox(height: 20),
                _buildIconWithText(Icons.comment, widget.commentCount),
                const SizedBox(height: 20),
                _buildIconWithText(Icons.send, widget.shareCount),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Bottom User Info & Actions
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  backgroundImage: NetworkImage(widget.profileImageUrl),
                ),
                const SizedBox(width: 10),
                // User Info & Caption
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.caption,
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Floating Icon + Text
  Widget _buildIconWithText(IconData icon, String text) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: Colors.white), onPressed: () {}),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
