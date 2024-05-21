import 'dart:convert';
import 'dart:typed_data';
import 'package:allcon/model/review_model.dart';
import 'package:allcon/pages/review/controller/review_controller.dart';
import 'package:allcon/service/review/reviewService.dart';
import 'package:allcon/utils/Loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewList extends StatefulWidget {
  final Review review;
  final String userId;

  const ReviewList({
    super.key,
    required this.review,
    required this.userId,
  });

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late final ReviewController _reviewController;

  @override
  void initState() {
    super.initState();
    _reviewController = Get.put(ReviewController());
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (widget.review.image != null && widget.review.image!.isNotEmpty) {
      imageBytes = base64Decode(widget.review.image!);
    }

    late int onChangedGood = 0;

    return FutureBuilder<bool>(
      future: ReviewService.toggleGoodReview(
        widget.review.reviewId,
        widget.userId,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Loading());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          bool istoggleGood = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.review.nickname,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      Row(
                        children:
                            _reviewController.starCounts(widget.review.rating),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(widget.review.text),
                  ),
                  Container(
                    child: imageBytes != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.memory(
                              imageBytes,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Helpful ?',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          TextButton(
                            onPressed: () async {
                              await ReviewService.toggleGoodReview(
                                widget.review.reviewId,
                                widget.userId,
                              );
                              setState(() {});
                            },
                            style: TextButton.styleFrom(
                                foregroundColor:
                                    istoggleGood ? Colors.blue : Colors.grey),
                            child: Text(
                              'Good (${widget.review.goodCount})',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.review.badCount;
                              });
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red),
                            child: Text(
                              'Bad (${widget.review.badCount})',
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd')
                            .format(widget.review.createdAt),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black12),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('No goodCounts found'));
        }
      },
    );
  }
}
