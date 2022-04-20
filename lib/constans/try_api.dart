import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:java_code_app/constans/hosts.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:provider/provider.dart';

tryApi(BuildContext context, Function? function) {
  OrderProviders orderProviders =
      Provider.of<OrderProviders>(context, listen: false);
  if (!orderProviders.isNetworkError!) {
    try {
      function!();
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
}

Future<bool> checkConnection({
  BuildContext? context,
  String? titleInput,
}) async {
  bool hasConnection = true;

  try {
    final resultHost = await InternetAddress.lookup(
      host,
    );

    if (resultHost.isNotEmpty && resultHost[0].rawAddress.isNotEmpty) {
      hasConnection = true;
    } else {
      hasConnection = false;
    }
  } on SocketException catch (_) {
    hasConnection = false;
  }

  return hasConnection;
}
