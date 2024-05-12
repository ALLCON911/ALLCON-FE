import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/hall_controller.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/pages/review/ReviewList.dart';
import 'package:allcon/pages/review/MyReview.dart';
import 'package:allcon/widget/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ReviewMain extends StatefulWidget {
  final String title;
  final List<Hall> hallList;

  const ReviewMain({
    super.key,
    required this.title,
    required this.hallList,
  });

  @override
  State<ReviewMain> createState() => _ReviewMainState();
}

class _ReviewMainState extends State<ReviewMain> {
  late final ReviewController _reviewController;
  late final HallController _hallController;
  late int selectedZoneIdx = 0;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
    _hallController = Get.put(HallController());
  }

  bool recommend = false;
  bool reviewWrite = true;
  bool mine = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(
                  height: 300,
                  child: _hallController.getSeatingChartByHallName(
                      widget.title, widget.hallList)),
              const SizedBox(height: 5),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: '추천순'),
                          Tab(text: '최신순'),
                          Tab(text: '내 리뷰'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            reviewTab(context, true, false),
                            reviewTab(context, false, false),
                            reviewTab(context, false, true)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget reviewTab(BuildContext context, bool isRecommend, bool mine) {
    List<String> zoneTotal =
        _hallController.getZoneNames(widget.title, widget.hallList);
    late String selectedZone = zoneTotal[selectedZoneIdx];

    List<Review> reviewList = widget
        .hallList[_hallController.getHallIdx(widget.title, widget.hallList)]
        .zone[selectedZoneIdx]
        .review;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // initState 대신 build 메서드 외부에서 초기화
      _reviewController.setReviewList(reviewList);
    });

    List<Zone> zoneList = widget
        .hallList[_hallController.getHallIdx(widget.title, widget.hallList)]
        .zone;

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 8.0),
          child: Column(
            children: [
              if (!mine)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: CustomDropdownButton(
                        items: zoneTotal,
                        value: selectedZone,
                        onChanged: (value) {
                          setState(() {
                            selectedZone = value.toString();
                            // 선택된 구역의 인덱스 찾기
                            selectedZoneIdx =
                                zoneTotal.indexWhere((zone) => zone == value);
                          });
                        },
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _reviewController.showWriteModalSheet(
                              context, reviewList, selectedZone);
                        });
                      },
                      child: const Text(
                        '리뷰 작성하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10.0),
              Obx(() {
                List<Widget> reviewWidgets = List.generate(
                  _reviewController.reviews.length,
                  (index) {
                    int reversedIndex =
                        _reviewController.reviews.length - 1 - index;

                    // goodCount가 높은 순으로 정렬합니다.
                    List<Review> sortedReviews = List.from(reviewList);
                    sortedReviews
                        .sort((a, b) => b.goodCount.compareTo(a.goodCount));

                    return mine
                        ? MyReview(
                            index: _reviewController
                                .reviews[reversedIndex].reviewId,
                            reviewList: reviewList,
                            zoneList: zoneList,
                            zone: selectedZone,
                            zoneTotal: zoneTotal,
                          )
                        : isRecommend
                            ? ReviewList(
                                review: sortedReviews[index],
                              )
                            : ReviewList(
                                review: reviewList[reversedIndex],
                              );
                  },
                );

                return Column(
                  children: reviewWidgets,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
