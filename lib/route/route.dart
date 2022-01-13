import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/orders/checkout_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/orders/detailmenu_page.dart';
import 'package:java_code_app/view/orders/detailvoucher_page.dart';
import 'package:java_code_app/view/orders/editorder_page.dart';
import 'package:java_code_app/view/auth/findlocation_page.dart';
import 'package:java_code_app/view/orders/ordersdetail_page.dart';
import 'package:java_code_app/view/orders/ongoingorder_page.dart';
import 'package:java_code_app/view/branda/promo_page.dart';
import 'package:java_code_app/view/orders/selection_vocher_page.dart';
import 'package:java_code_app/widget/view_image.dart';

class Navigate {
  static void toFindLocation(context) => Navigator.of(context).pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context).pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context) => Navigator.of(context).push(routeTransition(const PromoPage()));
  static void toChekOut(context) => Navigator.of(context).push(routeTransition(const CheckOutPage()));
  static Future toSelectionVoucherPage(context, {Map<String, dynamic>? initialData}) async => await Navigator.of(context).push(routeTransition(SelectionVoucherPage(initialData: initialData)));
  static Future<bool>? toDetailVoucherPage(context, {required String urlImage, required String title}) async => await Navigator.of(context).push(routeTransition(DetailVoucherPage(urlImage: urlImage, title: title,))) ?? false;
  static Future toDetailMenu(context, {required Map<String, dynamic> data, required int countOrder}) async => await Navigator.of(context).push(routeTransition(DetailMenu(data:data, countOrder: countOrder)));
  static Future toEditOrderMenu(context, {required Map<String, dynamic> data, required int countOrder}) async => await Navigator.of(context).push(routeTransition(EditOrderPage(data:data, countOrder: countOrder)));
  static void toViewOrder(context, {required Map<String, dynamic> dataOrders}) => Navigator.of(context).push(routeTransition( OngoingOrderPage(dataOrder: dataOrders)));
  static void toViewOrderKasir(context, {required Map<String, dynamic> dataOrders, bool? preparing}) => Navigator.of(context).push(routeTransition(OrderDetailPage(dataOrder: dataOrders, preparing: preparing)));

  //Costume route
  static void toViewImage(context, {required String urlImage}) =>    Navigator.push(context, PageRouteBuilder(
      fullscreenDialog: true,
      opaque: false,
      barrierDismissible:true,
      pageBuilder: (BuildContext context, _, __) {
        return ViewImage(urlImage: urlImage);
      }
  ));
}
