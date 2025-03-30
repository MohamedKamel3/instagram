import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Tools/custom_text.dart';
import 'package:instagram/UI_Parts_Helper/button_card.dart';
import 'package:instagram/UI_Parts_Helper/category_info.dart';
import 'package:instagram/UI_Parts_Helper/user_info.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});
  static const String id = 'userPage';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List img = [
    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;

    Map info = {};
    Map userPosts = {};
    Map userReels = {};
    Map userFollowers = {};
    bool isPrivate = false;

    if (args != null) {
      info = args['userInfo']['data'];
      if (args['userPosts']['data'] != null) {
        userPosts = args['userPosts']['data'];
        userFollowers = args['userFollowers']['data'];
        userReels = args['userReels']['data'];
      } else {
        isPrivate = true;
        userPosts = {'data': []};
        userFollowers = {'data': []};
        userReels = {'data': []};
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: info['username'] ?? "unknown User"),
        leadingWidth: 30,
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
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                UserInfo(
                  userInfo: info,
                  posts: userPosts['count'],
                  isPrivate: isPrivate,
                ),
                CategoryInfo(
                  posts: userPosts,
                  p: info['biography'],
                  fullName: info['full_name'],
                  img: [
                    userFollowers['items'][0]['profile_pic_url'] ??
                        "assets/default_avatar.jpg",
                    userFollowers['items'][1]['profile_pic_url'] ??
                        "assets/default_avatar.jpg",
                    userFollowers['items'][2]['profile_pic_url'] ??
                        "assets/default_avatar.jpg",
                  ],
                  followersNames: [
                    userFollowers['items'][0]['full_name'] ?? "unknown",
                    userFollowers['items'][1]['full_name'] ?? "unknown",
                    userFollowers['items'][2]['full_name'] ?? "unknown",
                    userFollowers['items'][3]['full_name'] ?? "unknown",
                    userFollowers['items'][4]['full_name'] ?? "unknown",
                    userFollowers['items'][5]['full_name'] ?? "unknown",
                    userFollowers['items'][6]['full_name'] ?? "unknown",
                  ],
                  isPrivate: isPrivate,
                ),
                const SizedBox(height: 5),
                ButtonCard(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            padding: const EdgeInsets.all(3),
            labelPadding: const EdgeInsets.all(10),
            dividerColor: Colors.black,
            indicatorColor: Colors.white,
            indicatorWeight: 1,
            indicatorSize: TabBarIndicatorSize.tab,
            dragStartBehavior: DragStartBehavior.down,
            tabs: [
              Icon(Icons.grid_on),
              Icon(Icons.video_library_outlined),
              Icon(Icons.person_add_alt),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.3 / 2,
                  ),
                  itemCount: userPosts['items'].length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      userPosts['items'][index]['thumbnail_url'],
                      fit: BoxFit.cover,
                    );
                  },
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.3 / 2,
                  ),
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return Image.network(img[index]);
                  },
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1.3 / 2,
                  ),
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return Image.network(img[index]);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
