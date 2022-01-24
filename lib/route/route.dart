import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/singletons/check_connectivity.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/chekout/checkout_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/branda/detailmenu_page.dart';
import 'package:java_code_app/view/chekout/detailvoucher_page.dart';
import 'package:java_code_app/view/chekout/editorder_page.dart';
import 'package:java_code_app/view/auth/findlocation_page.dart';
import 'package:java_code_app/view/orders/ongoingorder_page.dart';
import 'package:java_code_app/view/branda/promo_page.dart';
import 'package:java_code_app/view/chekout/selection_vocher_page.dart';
import 'package:java_code_app/widget/view_image.dart';

class Navigate {
  static void toFindLocation(context) => Navigator.of(context).pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context).pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context, {required String title, required String  police, int? discount, int? nominal}) => Navigator.of(context).push(routeTransition(PromoPage(title: title, police: police, discount: discount, nominal: nominal,)));
  static void toChekOut(context) => Navigator.of(context).push(routeTransition(const CheckOutPage()));
  static Future toSelectionVoucherPage(context, {LVoucher? initialData}) async => await Navigator.of(context).push(routeTransition(SelectionVoucherPage(initialData: initialData)));
  static Future<bool>? toDetailVoucherPage(context, {required LVoucher voucher}) async => await Navigator.of(context).push(routeTransition(DetailVoucherPage(voucher: voucher))) ?? false;
  static Future toDetailMenu(context, {required int id, required int countOrder}) async => await Navigator.of(context).push(routeTransition(DetailMenu(countOrder: countOrder, id: id)));
  static Future toEditOrderMenu(context, {required Map<String, dynamic> data, required int countOrder}) async => await Navigator.of(context).push(routeTransition(EditOrderPage(data:data, countOrder: countOrder)));
  static void toViewOrder(context, {required int id}) => Navigator.of(context).push(routeTransition( OngoingOrderPage(id: id)));
  // static void toViewOrderKasir(context, {required Map<String, dynamic> dataOrders, bool? preparing}) => Navigator.of(context).push(routeTransition(OrderDetailPage(dataOrder: dataOrders, preparing: preparing)));

  //Costume route
  static Future? toViewImage(context, {required String urlImage, File? file}) async => await Navigator.push(context, PageRouteBuilder(
      fullscreenDialog: true,
      opaque: false,
      barrierDismissible:true,
      pageBuilder: (BuildContext context, _, __) {
        return ViewImage(urlImage: urlImage);
      }
  ));
}
