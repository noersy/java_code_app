import 'package:flutter/material.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/checkout_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/detailmenu_page.dart';
import 'package:java_code_app/view/detailvoucher_page.dart';
import 'package:java_code_app/view/editorder_page.dart';
import 'package:java_code_app/view/findlocation_page.dart';
import 'package:java_code_app/view/ongoingorder_page.dart';
import 'package:java_code_app/view/promo_page.dart';
import 'package:java_code_app/view/selection_vocher_page.dart';
import 'package:java_code_app/widget/vp_pin_dialog.dart';

class Navigate {
  static void toFindLocation(context) => Navigator.of(context).pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context).pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context) => Navigator.of(context).push(routeTransition(const PromoPage()));
  static void toChekOut(context) => Navigator.of(context).push(routeTransition(const CheckOutPage()));
  static Future toSelectionVoucherPage(context, {Map<String, dynamic>? initialData}) async => await Navigator.of(context).push(routeTransition(SelectionVoucherPage(initialData: initialData)));
  static Future<bool>? toDetailVoucherPage(context, {required String urlImage, required String title}) async => await Navigator.of(context).push(routeTransition(DetailVoucherPage(urlImage: urlImage, title: title,))) ?? false;
  static Future toDetailMenu(context, {required Map<String, dynamic> data, required int countOrder}) => Navigator.of(context).push(routeTransition(DetailMenu(data:data, countOrder: countOrder)));
  static void toEditOrderMenu(context, {required Map<String, dynamic> data, required int countOrder}) => Navigator.of(context).push(routeTransition(EditOrderPage(data:data, countOrder: countOrder)));
  static void toViewOrder(context, {required Map<String, dynamic> dataOrders}) => Navigator.of(context).push(routeTransition( OngoingOrderPage(dataOrder: dataOrders)));
}
