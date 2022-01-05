import 'package:flutter/material.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/checkout_page.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/detailmenu_page.dart';
import 'package:java_code_app/view/detailvoucher_page.dart';
import 'package:java_code_app/view/findlocation_page.dart';
import 'package:java_code_app/view/promo_page.dart';
import 'package:java_code_app/view/selection_vocher_page.dart';
import 'package:java_code_app/widget/vp_pin_dialog.dart';

class Navigate {
  static void toFindLocation(context) => Navigator.of(context).pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context).pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context) => Navigator.of(context).push(routeTransition(const PromoPage()));
  static void toChekOut(context) => Navigator.of(context).push(routeTransition(const CheckOutPage()));
  static void toSelectionVoucherPage(context) => Navigator.of(context).push(routeTransition(const SelectionVoucherPage()));
  static void toDetailVoucherPage(context, {required String urlImage, required String title}) {Navigator.of(context).push(routeTransition(DetailVoucherPage(urlImage: urlImage, title: title,),));}
  static void toDetailMenu(context, {required String harga, required String urlImage, required String name, required int amount, int? count}) => Navigator.of(context).push(routeTransition(DetailMenu(harga: harga, urlImage: urlImage, name: name,count: count, amount: amount),),);
}
