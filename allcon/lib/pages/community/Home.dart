import 'package:allcon/pages/community/sub/Likes.dart';
import 'package:allcon/pages/community/sub/Post.dart';
import 'package:allcon/pages/community/sub/Search.dart';
import 'package:allcon/pages/community/sub/tabcontent/ContentListView.dart';
import 'package:allcon/pages/community/controller/content_controller.dart';
import 'package:allcon/utils/Colors.dart';
import 'package:allcon/widget/app_bar.dart';
import 'package:allcon/widget/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCommunity extends StatefulWidget {
  final int initialTabIndex;
  const MyCommunity({super.key, required this.initialTabIndex});

  @override
  State<MyCommunity> createState() => _MyCommunityState();
}

class _MyCommunityState extends State<MyCommunity>
    with TickerProviderStateMixin {
  final List<String> categoryList = ['자유게시판', '후기', '카풀'];
  late final TabController _tabController;
  late final ContentController _contentController;

  String searchText = '';
  String? loginUserId;

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: categoryList.length,
        vsync: this,
        initialIndex: widget.initialTabIndex);
    _contentController = ContentController();
    _loadInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        text: "커뮤니티",
        automaticallyImplyLeading: false,
        actions: const Padding(
          padding: EdgeInsets.only(right: 8.0, top: 5.0),
          child: Icon(
            CupertinoIcons.heart_circle,
            size: 30.0,
          ),
        ),
        onActionPressed: () {
          Get.to(MyContentLikes(
            contentController: _contentController,
            tabIdx: _tabController.index,
            initialCategory: categoryList[_tabController.index],
            userId: loginUserId!,
          ));
        },
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        currentIndex: 3,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 130.0,
            height: 45.0,
            child: FloatingActionButton(
              backgroundColor: lavenderColor,
              onPressed: () {
                Get.to(MyContentWrite(
                  initialCategory:
                      categoryList[_tabController.index], // 현재 선택된 탭의 이름 전달
                  tabIdx: _tabController.index,
                ));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.pencil_outline,
                    size: 16.0,
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    '글쓰기',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: MyContentSearch(
              onSearch: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: tabBar(
              context,
              _tabController,
            ),
          ),
        ],
      ),
    );
  }

  Widget tabBar(BuildContext context, TabController tabController) {
    return DefaultTabController(
      length: categoryList.length,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: categoryList.map((category) => Tab(text: category)).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: categoryList.map((category) {
                return MyContentListView(
                  category: category,
                  tabIdx: _tabController.index,
                  contentController: _contentController,
                  searchText: searchText,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
