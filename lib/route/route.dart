import 'package:flutter/material.dart';
import 'package:java_code_app/transision/route_transisition.dart';
import 'package:java_code_app/view/dashboard_page.dart';
import 'package:java_code_app/view/findlocation_page.dart';
import 'package:java_code_app/view/promo_page.dart';

class Navigate {
  static void toFindLocation(context) => Navigator.of(context).pushReplacement(routeTransition(const FindLocationPage()));
  static void toDashboard(context) => Navigator.of(context).pushReplacement(routeTransition(const DashboardPage()));
  static void toPromoPage(context) => Navigator.of(context).push(routeTransition(const PromoPage()));
}
