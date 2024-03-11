import 'package:allcon/Data/Content.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ContentController extends GetxController {
  RxList<Content> contents = <Content>[].obs;

  ContentController._internal();

  factory ContentController() {
    return ContentController._internal();
  }

  List<Content> getAllLikedContents() {
    return contents.where((content) => content.isLike == true).toList();
  }

  void setContentList(List<Content> initialContents) {
    contents.value = List.from(initialContents);
  }

  void toggleLike(int postId) {
    final int index =
        contents.indexWhere((content) => content.postId == postId);

    if (index != -1) {
      final Content content = contents[index];

      final int currentLike = content.like ?? 0;
      content.isLike = !(content.isLike ?? false);
      content.like = content.isLike ? currentLike + 1 : currentLike - 1;

      contents[index] = content;
    }
  }

  Content? getContent(int postId) {
    return contents.firstWhere(
      (content) => content.postId == postId,
    );
  }

  void updateContent(Content updatedContent) {
    final int index = contents
        .indexWhere((content) => content.postId == updatedContent.postId);

    if (index != -1) {
      contents[index] = updatedContent;
      update();
    }
  }
}