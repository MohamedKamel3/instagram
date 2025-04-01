import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:instagram/widgets/custom_text.dart';

class VideoPage extends StatefulWidget {
  static const String routeName = '/video';

  final String videoUrl;
  final String caption;
  final String username;
  final String profileImageUrl;
  final String likeCount;
  final String commentCount;
  final String shareCount;

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

  // Factory constructor for route arguments
  static Route route(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    return MaterialPageRoute(
      builder:
          (context) => VideoPage(
            videoUrl: args['videoUrl'],
            caption: args['caption'],
            username: args['username'],
            profileImageUrl: args['profileImageUrl'],
            likeCount: args['likeCount'],
            commentCount: args['commentCount'],
            shareCount: args['shareCount'],
          ),
    );
  }

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool _showControls = false;
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = int.tryParse(widget.likeCount) ?? 0;
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
            ..addListener(_videoListener)
            ..initialize().then((_) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _controller.play();
                  _controller.setLooping(true);
                });
              }
            });
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load video: ${e.toString()}')),
        );
      }
    }
  }

  void _videoListener() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
      _showControls = true;
    });
    _hideControlsAfterDelay();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() => _showControls = false);
      }
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video Background
          Container(color: Colors.black),

          // Video Player
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            GestureDetector(
              onTap: _togglePlayPause,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

          // Video Controls
          if (_showControls || !_controller.value.isPlaying)
            Positioned.fill(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),

          // Right Action Buttons
          Positioned(right: 16, bottom: 100, child: _buildActionButtons()),

          // Bottom User Info
          Positioned(left: 16, right: 16, bottom: 16, child: _buildUserInfo()),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(
          icon: _isLiked ? Icons.favorite : Icons.favorite_border,
          count: _likeCount.toString(),
          color: _isLiked ? Colors.red : Colors.white,
          onTap: _toggleLike,
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          icon: Icons.comment,
          count: widget.commentCount,
          onTap: () => _showComments(context),
        ),
        const SizedBox(height: 20),
        _buildActionButton(
          icon: Icons.send,
          count: widget.shareCount,
          onTap: _shareVideo,
        ),
        const SizedBox(height: 20),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onPressed: _showMoreOptions,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String count,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        IconButton(icon: Icon(icon, color: color), onPressed: onTap),
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.profileImageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.caption,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Comments', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder:
                        (context, index) => ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/200',
                            ),
                          ),
                          title: const Text('User'),
                          subtitle: const Text('This is a sample comment'),
                        ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void _shareVideo() {
    // Implement share functionality
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sharing video...')));
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Save'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text('Report'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }
}
