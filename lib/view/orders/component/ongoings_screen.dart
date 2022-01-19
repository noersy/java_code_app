import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class OngoingScreen extends StatefulWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  State<OngoingScreen> createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 3);

     if(mounted) setState(() => _loading = true);
      Timer(_duration, () {
        if(mounted) setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });

  }

  @override
  Widget build(BuildContext context) {
    // final _orderOngoing = Provider.of<OrderProviders>(context, listen: false).orderProgress;
    // print(_orderOngoing[0]);
    return SmartRefresher(
      onRefresh: _onRefresh,
      controller: _refreshController,
      child: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: const EdgeInsets.only(
            right: SpaceDims.sp18,
            left: SpaceDims.sp18,
            top: SpaceDims.sp12,
          ),
          child: AnimatedBuilder(
            animation: OrderProviders(),
            builder: (BuildContext context, Widget? child) {
              final _orderOngoing = Provider.of<OrderProviders>(context).orderProgress;

              return _orderOngoing.isNotEmpty
                  ? _loading
                      ? const SkeletonOrderMenuCard()
                      : Column(
                          children: [
                            for (Map<String, dynamic> item in _orderOngoing)
                              OrderMenuCard(
                                onPressed: () => Navigate.toViewOrder(
                                  context,
                                  dataOrders: item,
                                ),
                                date: "date",
                                harga: "Rp ${item["orders"][0]["harga"]}",
                                title: item["orders"][0]["name"],
                                urlImage: item["orders"][0]["image"] ?? "",
                                jumlah: "${item["orders"].length}",
                              ),
                          ],
                        )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assert/image/bg_findlocation.png"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(IconsCs.order,
                              size: 120,
                              color: ColorSty.primary,
                            ),
                            const SizedBox(height: SpaceDims.sp22),
                            Text("Sudah Pesan?\nLacak pesananmu\ndi sini.",
                                textAlign: TextAlign.center,
                                style: TypoSty.title2,
                            ),
                          ],
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class OrderMenuCard extends StatelessWidget {
  final String urlImage, title, date, harga, jumlah;
  final Order? order;
  final VoidCallback onPressed;
  const OrderMenuCard({
    Key? key,
    required this.urlImage,
    required this.title,
    required this.date,
    required this.harga,
    required this.onPressed, required this.jumlah,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: ColorSty.white80,
          onPrimary: ColorSty.primary,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(SpaceDims.sp14),
              margin: const EdgeInsets.all(SpaceDims.sp8),
              decoration: BoxDecoration(
                color: ColorSty.grey60,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: urlImage.isNotEmpty
                  ? Image.network(urlImage)
                  : const Icon(Icons.image_not_supported, color: ColorSty.grey),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: SpaceDims.sp18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: SpaceDims.sp4),
                              Text(
                                "Sedang disiapkan",
                                style: TypoSty.mini
                                    .copyWith(color: Colors.orange),
                              ),
                            ],
                          ),
                          Text(
                            "20 Des 2021",
                            style: TypoSty.mini.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    Text(title, style: TypoSty.title),
                    const SizedBox(height: SpaceDims.sp12),
                    Row(
                      children: [
                        Text(
                          "Rp 20.000",
                          style: TypoSty.mini.copyWith(
                              fontSize: 14.0, color: ColorSty.primary),
                        ),
                        const SizedBox(width: SpaceDims.sp8),
                        Text(
                          "($jumlah Menu)",
                          style: TypoSty.mini.copyWith(
                            fontSize: 12.0,
                            color: ColorSty.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SkeletonOrderMenuCard extends StatelessWidget {
  const SkeletonOrderMenuCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp4),
          child: ElevatedButton(
           onPressed: (){},
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: ColorSty.white80,
              onPrimary: ColorSty.primary,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.all(SpaceDims.sp8),
                  decoration: BoxDecoration(
                    color: ColorSty.grey60,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Skeleton(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: SpaceDims.sp18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 14.0,
                                    child: SkeletonText(height: 14.0),
                                  ),
                                  SizedBox(width: SpaceDims.sp4),
                                  SizedBox(
                                    width: 90.0,
                                    child: SkeletonText(height: 11.0),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 56.0,
                                child: SkeletonText(height: 11.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp14),
                        const SkeletonText(height: 26.0),
                        const SizedBox(height: SpaceDims.sp24),
                        Row(
                          children: const [
                            SizedBox(
                              width: 60.0,
                              child: SkeletonText(height: 14.0),
                            ),
                            SizedBox(width: SpaceDims.sp8),
                            SizedBox(
                              width: 40.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: SkeletonText(height: 12.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp4),
          child: ElevatedButton(
           onPressed: (){},
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: ColorSty.white80,
              onPrimary: ColorSty.primary,
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  margin: const EdgeInsets.all(SpaceDims.sp8),
                  decoration: BoxDecoration(
                    color: ColorSty.grey60,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Skeleton(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: SpaceDims.sp18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 14.0,
                                    child: SkeletonText(height: 14.0),
                                  ),
                                  SizedBox(width: SpaceDims.sp4),
                                  SizedBox(
                                    width: 90.0,
                                    child: SkeletonText(height: 11.0),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 56.0,
                                child: SkeletonText(height: 11.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp14),
                        const SkeletonText(height: 26.0),
                        const SizedBox(height: SpaceDims.sp24),
                        Row(
                          children: const [
                            SizedBox(
                              width: 60.0,
                              child: SkeletonText(height: 14.0),
                            ),
                            SizedBox(width: SpaceDims.sp8),
                            SizedBox(
                              width: 40.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: SkeletonText(height: 12.0),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
