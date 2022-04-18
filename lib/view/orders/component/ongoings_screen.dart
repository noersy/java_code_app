import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/providers/lang_providers.dart';
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

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen>
    with AutomaticKeepAliveClientMixin<OngoingScreen> {
  @override
  bool get wantKeepAlive => true;

  bool _loading = false;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 1);

    await Provider.of<OrderProviders>(context, listen: false).getListOrder();

    Timer(_duration, () {
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
    _onRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SmartRefresher(
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp22),
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
                      const SizedBox(height: SpaceDims.sp8),
                      for (final item in orders)
                        OrderMenuCard(
                          onPressed: () => Navigate.toViewOrder(
                            context,
                            id: item.idOrder,
                          ),
                          data: item,
                        ),
                      const SizedBox(height: 80.0)
                    ],
                  );
                }
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 120,
                  child: Stack(
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
                          AnimatedBuilder(
                              animation: LangProviders(),
                              builder: (context, snapshot) {
                                final lang =
                                    Provider.of<LangProviders>(context).lang;
                                return Text(
                                  lang.pesanan.ongoingCaption,
                                  textAlign: TextAlign.center,
                                  style: TypoSty.title2,
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
