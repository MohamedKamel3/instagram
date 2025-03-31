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

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;

    Map info = {};
    Map userPosts = {'items': []};
    Map userReels = {'items': []};
    Map userFollowers = {'items': []};
    bool isPrivate = false;

    if (args != null) {
      info = args['userInfo']['data'] ?? {};
      if (args['userPosts']['data'] != null) {
        userPosts = args['userPosts']['data'];
        userReels = args['userReels']['data'];
        userFollowers = args['userFollowers']['data'];
      } else {
        isPrivate = true;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: info['username'] ?? "Unknown User"),
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
                  posts: userPosts['items'].length,
                  isPrivate: isPrivate,
                ),
                CategoryInfo(
                  posts: userPosts,
                  p: info['biography'] ?? "",
                  fullName: info['full_name'] ?? "User",
                  img:
                      isPrivate
                          ? []
                          : [
                            userFollowers['items'][0]['profile_pic_url'] ??
                                "assets/default_avatar.jpg",
                            userFollowers['items'][1]['profile_pic_url'] ??
                                "assets/default_avatar.jpg",
                            userFollowers['items'][2]['profile_pic_url'] ??
                                "assets/default_avatar.jpg",
                          ],
                  followersNames:
                      isPrivate
                          ? []
                          : [
                            userFollowers['items'][0]['username'] ?? "Unknown",
                            userFollowers['items'][1]['username'] ?? "Unknown",
                            userFollowers['items'][2]['username'] ?? "Unknown",
                            userFollowers['items'][3]['username'] ?? "Unknown",
                            userFollowers['items'][4]['username'] ?? "Unknown",
                            userFollowers['items'][5]['username'] ?? "Unknown",
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
            tabs: const [
              Icon(Icons.grid_on),
              Icon(Icons.video_library_outlined),
              Icon(Icons.person_add_alt),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                isPrivate
                    ? const Center(child: Text("This account is private"))
                    : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                isPrivate
                    ? const Center(child: Text("This account is private"))
                    : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.3 / 2,
                          ),
                      itemCount: userReels['items'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          userReels['items'][index]['thumbnail_url'],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                isPrivate
                    ? const Center(child: Text("This account is private"))
                    : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 1.3 / 2,
                          ),
                      itemCount: userFollowers['items'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          userFollowers['items'][index]['profile_pic_url'],
                          fit: BoxFit.cover,
                        );
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
