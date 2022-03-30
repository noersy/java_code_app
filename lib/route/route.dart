import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:java_code_app/main.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/branda/detail_gambar.dart';
import 'package:java_code_app/view/chekout/checkout_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/branda/detailmenu_page.dart';
import 'package:java_code_app/view/chekout/detailvoucher_page.dart';
import 'package:java_code_app/view/chekout/editorder_page.dart';
import 'package:java_code_app/view/auth/findlocation_page.dart';
import 'package:java_code_app/view/orders/ongoingorder_page.dart';
import 'package:java_code_app/view/branda/promo_page.dart';
import 'package:java_code_app/view/chekout/selection_vocher_page.dart';
import 'package:java_code_app/view/profile/penilaian/balasan_review.dart';
import 'package:java_code_app/view/profile/penilaian/daftar_penilaian.dart';
import 'package:java_code_app/view/profile/penilaian/penilaian.dart';
import 'package:java_code_app/widget/view_image.dart';
import 'package:provider/provider.dart';

import '../view/profile/penilaian/chatt_page.dart';

class Navigate {
  static Future to(Widget target) async =>
      await navigatorKey.currentState?.push(routeTransition(target));
  static Future toRaw(PageRouteBuilder target) async =>
      await navigatorKey.currentState?.push(target);
  static back(Object? value) => navigatorKey.currentState?.pop(value);

  static void toFindLocation(context) => Navigator.of(context)
      .pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context)
      .pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context,
          {required String title,
          required String police,
          int? discount,
          int? nominal}) =>
      Navigator.of(context).push(routeTransition(PromoPage(
        title: title,
        police: police,
        discount: discount,
        nominal: nominal,
      )));
  static void toChekOut(context) =>
      Navigator.of(context).push(routeTransition(const CheckOutPage())).then(
            (value) => Provider.of<OrderProviders>(context, listen: false)
                .clearCheckout(),
          );
  static Future toSelectionVoucherPage(context,
          {LVoucher? initialData}) async =>
      await Navigator.of(context).push(
          routeTransition(SelectionVoucherPage(initialData: initialData)));
  static Future<bool>? toDetailVoucherPage(context,
          {required LVoucher voucher}) async =>
      await Navigator.of(context)
          .push(routeTransition(DetailVoucherPage(voucher: voucher))) ??
      false;
  static Future toDetailMenu(context,
          {required int id, required int countOrder}) async =>
      await Navigator.of(context)
          .push(routeTransition(DetailMenu(countOrder: countOrder, id: id)));
  static Future toEditOrderMenu(context,
          {required Map<String, dynamic> data,
          required int countOrder}) async =>
      await Navigator.of(context).push(
          routeTransition(EditOrderPage(data: data, countOrder: countOrder)));
  static void toViewOrder(context, {required int id}) =>
      Navigator.of(context).push(routeTransition(OngoingOrderPage(id: id)));
  static void toDaftarPenilaian(context) =>
      Navigator.of(context).push(routeTransition(const DaftarPenilaian()));

  static void toPenilaian(context) =>
      Navigator.of(context).push(routeTransition(const Penilaian()));

  static void toBalasanReview(context, idReviews) =>
      Navigator.of(context).push(routeTransition(BalasanReview(
        idReview: idReviews,
      )));
  static void toChattReview(context) =>
      Navigator.of(context).push(routeTransition(const ChatPage()));
  // static void toViewOrderKasir(context, {required Map<String, dynamic> dataOrders, bool? preparing}) => Navigator.of(context).push(routeTransition(OrderDetailPage(dataOrder: dataOrders, preparing: preparing)));
  static void toDetailGambar(context, foto) =>
      Navigator.of(context).push(routeTransition(DetailGambar(
        foto: foto,
      )));
  //Costume route
  static Future? toViewImage({required String urlImage, File? file}) async =>
      await Navigate.toRaw(PageRouteBuilder(
          fullscreenDialog: true,
          opaque: false,
          barrierDismissible: true,
          pageBuilder: (BuildContext context, _, __) {
            return ViewImage(urlImage: urlImage);
          }));
}
