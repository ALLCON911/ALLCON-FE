import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:allcon/model/review_model.dart';
import 'package:allcon/service/baseUrl.dart';

class MyReviewService {
  // 내 리뷰 조회
  static Future<List<Review>> getMyReviews(String userId, String hallId) async {
    final url =
        Uri.parse('${BaseUrl.baseUrl}my_review_thiszone/$userId/$hallId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  // 리뷰 수정
  static Future<void> updateReview(
      String reviewId,
      String userId,
      String userNickname,
      String reviewToUpdate,
      String zoneId,
      List<String> imageFiles,
      int ratingToUpdate) async {
    var url = Uri.parse('${BaseUrl.baseUrl}modify_review_with_image/$reviewId');
    var request = http.MultipartRequest('PUT', url);

    request.fields.addAll({
      'userId': userId,
      'userNickname': userNickname,
      'reviewText': reviewToUpdate,
      'rating': ratingToUpdate.toString(),
      'zoneId': zoneId,
    });

    // 이미지 파일들을 배열로 묶어서 보냄
    for (var file in imageFiles) {
      if (file.startsWith('http://') || file.startsWith('https://')) {
        // 웹 URL인 경우 필드로 직접 추가
        request.fields['image'] = file; // 이 방식이 허용된다면 여러 이미지를 처리하는 방식 변경 필요
      } else {
        // 로컬 파일인 경우 파일로 추가
        request.files.add(await http.MultipartFile.fromPath('image', file));
      }
    }

    var res = await request.send();

    if (res.statusCode == 200) {
      print(await res.stream.bytesToString());
    } else {
      print("Failed to submit review: ${res.statusCode}");
    }
  }

  // 리뷰 삭제
  static Future<bool> deleteReview(String reviewId, String zoneId) async {
    final url = '${BaseUrl.baseUrl}delete_review/$reviewId';
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'zoneId': zoneId,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete review: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }
}
