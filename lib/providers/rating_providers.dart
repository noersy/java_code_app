// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:java_code_app/models/listreview.dart';
// import 'package:logging/logging.dart' as logging;
// import 'package:http/http.dart' as http;
// import '../constans/hosts.dart';
// import '../singletons/user_instance.dart';

// class RatingProviders extends ChangeNotifier {
//   List<Review> listReview = [];
//   static final _log = logging.Logger('OrderProvider');
//   static const headers = {"Content-Type": "application/json", "token": "m_app"};
//   Future<List<Review>?> getAllReview() async {
//     final user = UserInstance.getInstance().user;
//     if (user == null) return null;
//     try {
//       _log.fine("Try to get list review");
//       final response = await http.get(Uri.parse("https://$host/api/review"),
//           headers: headers);
//       if (response.statusCode == 204) {
//         _log.info("review if empty");
//         return [];
//       }

//       if (response.statusCode == 200 &&
//           json.decode(response.body)["status_code"] == 200) {
//         _log.fine("Success get all review:");
//         return listReviewFromJson(response.body).data;
//         // print('body sukses:\n${response.body}');
//         // return listHistoryFromJson(response.body).data;
//       }
//       _log.info("Fail to get list review");
//       _log.info(response.body);
//     } catch (e, r) {
//       _log.warning(e);
//       _log.warning(r);
//     }
//     return null;
//   }
// }
