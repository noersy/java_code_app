// // To parse this JSON data, do
// //
// //     final listHistory = listHistoryFromJson(jsonString);

// import 'dart:convert';

// import 'package:java_code_app/providers/rating_providers.dart';

// ListReview listReviewFromJson(String str) =>
//     ListReview.fromJson(json.decode(str));

// String listHistoryToJson(ListReview data) => json.encode(data.toJson());

// class ListReview {
//   ListReview({
//     required this.statusCode,
//     required this.data,
//   });

//   final int statusCode;
//   final List<Review> data;

//   factory ListReview.fromJson(Map<String, dynamic> json) => ListReview(
//         statusCode: json["status_code"],
//         data: List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status_code": statusCode,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }


