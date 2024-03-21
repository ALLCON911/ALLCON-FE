import 'package:allcon/Data/Concert.dart';
import 'package:allcon/Data/Sample/concert_sample.dart';
import 'package:allcon/Widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:allcon/pages/concert/concertinfo.dart' as concertinfo;

class WatchAllConcert extends StatefulWidget {
  const WatchAllConcert({super.key});

  @override
  State<WatchAllConcert> createState() => _WatchAllConcertState();
}

class _WatchAllConcertState extends State<WatchAllConcert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '전체공연'),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: allConcertSample.length,
        itemBuilder: (context, index) {
          return _buildContentItem(context, allConcertSample[index]);
        },
      ),
    );
  }

  Widget _buildContentItem(BuildContext context, Concert concert) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
      child: GestureDetector(
        onTap: () {
          print('항목이 클릭되었습니다: ${concert.title}');
          Get.to(
            const concertinfo.ConcertInfo(),
            arguments: concert,
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Image.network(
                concert.imgUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    concert.title ?? 'Unknown Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    concert.performer ?? 'Unknown Performer',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
