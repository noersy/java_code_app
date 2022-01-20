import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/widget/ordemenu_card.dart';
import 'package:java_code_app/view/orders/widget/skeletonorder_menu.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> with AutomaticKeepAliveClientMixin<OngoingScreen> {

  @override
  bool get wantKeepAlive => true;

  bool _loading = false;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 1);

    await Provider.of<OrderProviders>(context, listen: false).getListOrder();

    if (mounted) setState(() => _loading = true);
    Timer(_duration, () {
      if (mounted) setState(() => _loading = false);
      _refreshController.refreshCompleted();
    });
  }

  getListOrder() async {
    if (mounted) setState(() => _loading = true);
    await Provider.of<OrderProviders>(context, listen: false).getListOrder();
    if (mounted) setState(() => _loading = false);
  }

  @override
  void initState() {
    getListOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _orderOngoing = Provider.of<OrderProviders>(context, listen: false).orderProgress;
    // print(_orderOngoing[0]);
    return SmartRefresher(
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              right: SpaceDims.sp18,
              left: SpaceDims.sp18,
              top: SpaceDims.sp12,
            ),
            child: AnimatedBuilder(
              animation: OrderProviders(),
              builder: (BuildContext context, Widget? child) {
                final orders = Provider.of<OrderProviders>(context).listOrders;
                if (orders.isNotEmpty) {
                  if (_loading) {
                    return const SkeletonOrderMenuCard();
                  } else {
                    return Column(
                      children: [
                        for (final item in orders)
                          OrderMenuCard(
                            onPressed: () => Navigate.toViewOrder(
                              context,
                              id: item.idOrder,
                            ),
                            data: item,
                          ),
                      ],
                    );
                  }
                } else {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assert/image/bg_findlocation.png"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            IconsCs.order,
                            size: 120,
                            color: ColorSty.primary,
                          ),
                          const SizedBox(height: SpaceDims.sp22),
                          Text(
                            "Sudah Pesan?\nLacak pesananmu\ndi sini.",
                            textAlign: TextAlign.center,
                            style: TypoSty.title2,
                          ),
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


