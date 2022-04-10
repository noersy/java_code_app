// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

library java_code_app.post_penilaian;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:logging/logging.dart' as logging;

final _log = logging.Logger('OrderProvider');
var img =
    'iVBORw0KGgoAAAANSUhEUgAAAQ4AAAC7CAMAAACjH4DlAAAAXVBMVEUpMTRnjLEiJiNcfJxrkbgkKSgoLzEmLS5EWWxXdpM0QkxAVGUuOT9kiKslKytSbohPaYJggqM+UF8wO0I6SldIX3Q2RE9LY3oyP0crNDk+UWFWdJA7S1lPaH9jhacMRR/OAAADlElEQVR4nO3c7XKqMBSFYSi4CSCB8CGkKvd/mUfAVoNgHUiPdbuef51aprwDAQLiOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.........';
Future postPenilaian(score, type, review, img) async {
  final user = UserInstance.getInstance().user;
  if (user == null) return null;
  try {
    // print('score: $score | type: $type | review: $review  | image: $img ');
    final body = <String, dynamic>{
      'id_user': '${user.data.idUser}',
      'score': '$score',
      'type': '$type',
      'review': '$review',
      'image': img
    };
    _log.fine("Try to post review");
    final response = await http.post(
      Uri.parse("https://$host/api/review/add"),
      headers: await getHeader(),
      body: body,
    );
    // print('response: ${response.body}');

    // if (response.statusCode == 204) {
    //   _log.info("review if empty");
    //   return [];
    // }

    Map? data = json.decode(response.body);

    if (response.statusCode == 200 && data!["status_code"] == 200) {
      _log.fine("Success get all review:");
      return {
        'success': true,
      };
      // return listHistoryFromJson(response.body).data;
    } else if (data!["status_code"] == 422) {
      return {
        'success': false,
        'message': 'Gagal megngirim penilaian',
      };
    } else {
      return {
        'success': false,
        'message': data['errors']['message'],
      };
    }
  } catch (e, r) {
    _log.warning(e);
    _log.warning(r);
  }
  return {
    'success': false,
    'message': 'Gagal megngirim penilaian',
  };
}
