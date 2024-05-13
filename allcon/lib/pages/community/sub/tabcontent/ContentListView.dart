import 'package:allcon/pages/community/controller/post_controller.dart';
import 'package:allcon/pages/community/sub/GetPost.dart';
import 'package:allcon/model/community_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyContentListView extends StatefulWidget {
  final String category;
  final int tabIdx;
  final String title;
  final String searchText;

  const MyContentListView({
    super.key,
    required this.category,
    required this.tabIdx,
    this.title = '',
    this.searchText = '',
  });

  @override
  State<MyContentListView> createState() => _MyContentListViewState();
}

class _MyContentListViewState extends State<MyContentListView> {
  final PostController _postController = PostController();
  String? loginUserId;
  String? loginUserNickname;

  _loadInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginUserId = prefs.getString('userId');
    loginUserNickname = prefs.getString('userNickname');
  }

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _postController.fetchPosts(widget.category);
      setState(() {});
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: _postController.posts.length,
          itemBuilder: (context, index) {
            // 거꾸로 된 인덱스 계산
            final reversedIndex = _postController.posts.length - index - 1;
            return _buildContentItem(
                context, _postController.posts[reversedIndex], reversedIndex);
          },
        ),
      ),
    );
  }

  Widget _buildContentItem(BuildContext context, Post post, int index) {
    final lowercaseSearchText = widget.searchText.toLowerCase();
    final lowercaseContent = post.text.toLowerCase();

    if (widget.searchText.isNotEmpty &&
        !lowercaseContent.contains(lowercaseSearchText)) {
      return Container();
    } else {
      return createBox(context, post);
    }
  }

  Widget createBox(
    BuildContext context,
    Post post,
  ) {
    DateTime dateTime =
        DateFormat('yyyy-MM-dd').parse(post.createdAt.toString());

    return GestureDetector(
      onTap: () {
        Get.to(() => MyContentDetail(
              category: widget.category,
              tabIdx: widget.tabIdx,
              post: post,
              userId: loginUserId ?? '',
              nickname: loginUserNickname ?? '',
            ));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              height: 80.0,
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Text(
                              post.nickname,
                              style: const TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              '|',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              DateFormat('yyyy-MM-dd').format(dateTime),
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red[300],
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${post.likesCount}",
                              style: TextStyle(
                                color: Colors.red[300],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              CupertinoIcons.chat_bubble,
                              color: Colors.blueAccent,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "${post.commentCount}",
                              style: const TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    icon: const Icon(
                      // widget.contentController.posts[index].isLike
                      //     ? CupertinoIcons.heart_fill
                      CupertinoIcons.heart,
                      // color: widget.contentController.posts[index].isLike
                      //     ? Colors.redAccent
                      //     : Colors.grey,
                    ),
                    onPressed: () {
                      // widget.contentController.toggleLike(content.postId);
                      // widget.contentController.update();
                    },
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
          Container(height: 1.0, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
