import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "UserName"),
        automaticallyImplyLeading: false,
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
                UserInfo(),
                CategoryInfo(
                  img: [
                    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
                    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
                    "assets/WhatsApp Image 2025-02-03 at 18.32.53_6c168231.jpg",
                  ],
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
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return Image.asset(img[index]);
                  },
                ),
                Icon(Icons.add_circle),
                Icon(Icons.add_circle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
