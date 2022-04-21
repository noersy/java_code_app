// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

library java_code_app.fetch_rating;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:java_code_app/constans/gettoken.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:logging/logging.dart' as logging;
import 'package:provider/provider.dart';

final _log = logging.Logger('OrderProvider');

class Review {
  var id_review, id_user, nama, score, type, review, image, created_at;
  Review(
      {this.id_review,
      this.id_user,
      this.nama,
      this.score,
      this.type,
      this.review,
      this.image,
      this.created_at});
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id_review: json['id_review'],
      id_user: json['id_user'],
      nama: json['nama'],
      score: json['score'],
      type: json['type'],
      review: json['review'],
      image: json['image'],
      created_at: json['created_at'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id_review': id_review,
        'id_user': id_user,
        'nama': nama,
        'score': score,
        'type': type,
        'review': review,
        'image': image,
        'created_at': created_at,
      };
}

List listReview = [];
Future getAllReview(BuildContext context) async {
  OrderProviders orderProviders =
      Provider.of<OrderProviders>(context, listen: false);
  if (orderProviders.isNetworkError!) return false;

  final user = UserInstance.getInstance().user;
  if (user == null) return null;

  final Uri _api = Uri.http(host, "$sub/api/review/${user.data.idUser}");
  try {
    final response = await http
        .get(
          _api,
          headers: await getHeader(),
        )
        .timeout(
          const Duration(seconds: 4),
        );

    var responseBody = json.decode(response.body);
    if (response.statusCode == 200 && responseBody == 200) {
      return (response.body);
    }
    return null;
  } on SocketException {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Terjadi masalah dengan server.',
    );
    return null;
  } on TimeoutException {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Koneksi time out.',
    );
    return null;
  } catch (e) {
    orderProviders.setNetworkError(
      true,
      context: context,
      title: 'Terjadi masalah dengan server.',
    );
    return null;
  }
}
