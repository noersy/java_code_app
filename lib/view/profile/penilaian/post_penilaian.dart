// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

library java_code_app.post_penilaian;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:provider/provider.dart';

var img =
    'iVBORw0KGgoAAAANSUhEUgAAAQ4AAAC7CAMAAACjH4DlAAAAXVBMVEUpMTRnjLEiJiNcfJxrkbgkKSgoLzEmLS5EWWxXdpM0QkxAVGUuOT9kiKslKytSbohPaYJggqM+UF8wO0I6SldIX3Q2RE9LY3oyP0crNDk+UWFWdJA7S1lPaH9jhacMRR/OAAADlElEQVR4nO3c7XKqMBSFYSi4CSCB8CGkKvd/mUfAVoNgHUiPdbuef51aprwDAQLiOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.........';
Future postPenilaian(BuildContext context, score, type, review, img) async {
  OrderProviders orderProviders =
      Provider.of<OrderProviders>(context, listen: false);
  if (orderProviders.isNetworkError!) return false;

  final user = UserInstance.getInstance().user;
  if (user == null) return null;

  try {
    final body = <String, dynamic>{
      'id_user': '${user.data.idUser}',
      'score': '$score',
      'type': '$type',
      'review': '$review',
      'image': img
    };
    final Uri _api = Uri.http(host, "$sub/api/review/add");
    final response = await http.post(
      _api,
      headers: await getHeader(),
      body: jsonEncode(body),
    );

    var responseBody = json.decode(response.body);
    if (response.statusCode == 200 && responseBody['status_code'] == 200) {
      return {
        'success': true,
        'message': 'Sukses mengirim penilaian',
      };
    } else {
      return {
        'success': false,
        'message': responseBody['message'] ??
            responseBody['errors']?[0] ??
            'Gagal mengirim penilaian',
      };
    }
  } on SocketException {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Terjadi masalah dengan server.',
    );
    return {
      'success': false,
      'message': 'Gagal mengirim penilaian',
    };
  } on TimeoutException {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Koneksi time out.',
    );
    return {
      'success': false,
      'message': 'Gagal mengirim penilaian',
    };
  } catch (e) {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Terjadi masalah dengan server.',
    );
    return {
      'success': false,
      'message': 'Gagal mengirim penilaian',
    };
  }
}
