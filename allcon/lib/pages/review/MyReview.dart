import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyReview extends StatefulWidget {
  final int index;
  final List<Review> reviewList;
  final List<Zone> zoneList;
  final String zone;
  final List<String> zoneTotal;

  const MyReview({
    super.key,
    required this.index,
    required this.reviewList,
    required this.zoneList,
    required this.zone,
    required this.zoneTotal,
  });

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  late final ReviewController _reviewController;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext sheetContext) =>
                          CupertinoActionSheet(
                        title: const Text('옵션'),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('수정'),
                            onPressed: () {
                              Get.back();
                              setState(() {
                                _reviewController.showUpdateModalSheet(
                                    context,
                                    widget.reviewList,
                                    widget.zoneList,
                                    widget.zoneTotal,
                                    widget.zone,
                                    widget.reviewList[widget.index],
                                    widget.reviewList[widget.index].content,
                                    widget.reviewList[widget.index].starCount);
                              });
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('삭제'),
                            onPressed: () {
                              // You can handle content deletion
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, '취소');
                          },
                          child: const Text('취소'),
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '1구역',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  children: _reviewController.starCounts(
                      _reviewController.reviews[widget.index].starCount),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(_reviewController.reviews[widget.index].content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Helpful ?',
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _reviewController.reviews[widget.index].goodCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text(
                        'Good (${_reviewController.reviews[widget.index].goodCount})',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _reviewController.reviews[widget.index].badCount++;
                        });
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: Text(
                        'Bad (${_reviewController.reviews[widget.index].badCount})',
                      ),
                    ),
                  ],
                ),
                Text(
                  DateFormat('yyyy-MM-dd')
                      .format(_reviewController.reviews[widget.index].dateTime),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Divider(color: Colors.black12),
          ],
        ),
      ),
    );
  }
}