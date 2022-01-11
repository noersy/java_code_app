import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _dropdownValue = 'Semua Status';
  final List<String> _item = ["Semua Status", "Selesai", "Dibatalkan"];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 3);

    if (mounted) {
      setState(() => _loading = true);
      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpaceDims.sp18,
              vertical: SpaceDims.sp14,
            ),
            child: true
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              right: SpaceDims.sp8,
                              left: SpaceDims.sp12,
                              bottom: SpaceDims.sp4,
                              top: SpaceDims.sp4,
                            ),
                            width: 160.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorSty.grey60,
                                border: Border.all(color: ColorSty.primary),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: DropdownButton<String>(
                              isDense: true,
                              value: _dropdownValue,
                              alignment: Alignment.topCenter,
                              borderRadius: BorderRadius.circular(30.0),
                              icon: const Icon(Icons.arrow_drop_down),
                              style: TypoSty.caption2.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: ColorSty.black),
                              onChanged: (String? newValue) {
                                setState(() => _dropdownValue = newValue!);
                              },
                              items: [
                                for (String item in _item)
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  ),
                              ],
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: ColorSty.grey60,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: ColorSty.primary),
                                    borderRadius: BorderRadius.circular(30.0))),
                            onPressed: null,
                            child: SizedBox(
                              width: 160.0,
                              child: Row(
                                children: [
                                  const SizedBox(width: SpaceDims.sp12),
                                  Text("25/12/21 - 30/12/21",
                                      style: TypoSty.caption2.copyWith(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(width: SpaceDims.sp8),
                                  const Icon(IconsCs.date,
                                      size: 18.0, color: ColorSty.primary),
                                  const SizedBox(width: SpaceDims.sp8),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _loading
                          ? const SkeletonOrderCad()
                          : OrderHistoryCard(onPressed: () {}),
                      const SizedBox(height: SpaceDims.sp8),
                    ],
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assert/image/bg_findlocation.png"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(IconsCs.order,
                                size: 120, color: ColorSty.primary),
                            const SizedBox(height: SpaceDims.sp22),
                            Text("Mulai buat pesanan.",
                                textAlign: TextAlign.center,
                                style: TypoSty.title2),
                            const SizedBox(height: SpaceDims.sp12),
                            Text(
                                "Makanan yang kamu pesan\nakan muncul di sini agar\nkamu bisa menemukan\nmenu favoritmu lagi!.",
                                textAlign: TextAlign.center,
                                style: TypoSty.title2),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(
            horizontal: SpaceDims.sp22, vertical: SpaceDims.sp14),
        decoration: const BoxDecoration(
          color: ColorSty.grey60,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Pesanan",
              style: TypoSty.title,
            ),
            _loading
                ? const SizedBox(
                    width: 120.0,
                    child: SkeletonText(height: 16.0),
                  )
                : Text("Rp. 40.000", style: TypoSty.titlePrimary),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final VoidCallback onPressed;

  const OrderHistoryCard({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorSty.white80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
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
                child: Image.asset("assert/image/menu/1637916792.png"),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: SpaceDims.sp8),
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
                                  Icons.check,
                                  size: 18.0,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: SpaceDims.sp4),
                                Text(
                                  "Selesai",
                                  style: TypoSty.mini
                                      .copyWith(color: Colors.green),
                                ),
                              ],
                            ),
                            Text(
                              "20 Des 2021",
                              style: TypoSty.mini
                                  .copyWith(color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp2),
                      Text("Fried Rice, Chicken Katsu", style: TypoSty.title),
                      const SizedBox(height: SpaceDims.sp4),
                      Row(
                        children: [
                          Text(
                            "Rp 20.000",
                            style: TypoSty.mini.copyWith(
                                fontSize: 14.0, color: ColorSty.primary),
                          ),
                          const SizedBox(width: SpaceDims.sp8),
                          Text(
                            "(3 Menu)",
                            style: TypoSty.mini.copyWith(
                              fontSize: 12.0,
                              color: ColorSty.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              primary: ColorSty.white,
                              onPrimary: ColorSty.primary,
                              padding: const EdgeInsets.symmetric(
                                vertical: SpaceDims.sp8,
                                horizontal: SpaceDims.sp12,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: ColorSty.primaryDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Beri Penilaian",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
                            ),
                          ),
                          const SizedBox(width: SpaceDims.sp8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              primary: ColorSty.primary,
                              padding: const EdgeInsets.symmetric(
                                vertical: SpaceDims.sp8,
                                horizontal: SpaceDims.sp12,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: ColorSty.primaryDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Pesan Lagi",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SkeletonOrderCad extends StatelessWidget {
  const SkeletonOrderCad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorSty.white80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
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
                padding: const EdgeInsets.only(
                  top: SpaceDims.sp8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: SpaceDims.sp18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(
                            width: 40.0,
                            child: SkeletonText(height: 11),
                          ),
                          SizedBox(
                            width: 90.0,
                            child: SkeletonText(height: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    const SkeletonText(height: 26.0),
                    const SizedBox(height: SpaceDims.sp8),
                    Expanded(
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 60.0,
                            child: SkeletonText(height: 14.0),
                          ),
                          SizedBox(width: SpaceDims.sp8),
                          SizedBox(
                            width: 30.0,
                            child: SkeletonText(height: 12.0),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            primary: ColorSty.white,
                            onPrimary: ColorSty.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: SpaceDims.sp8,
                              horizontal: SpaceDims.sp12,
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: ColorSty.primaryDark,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Beri Penilaian",
                            style: TypoSty.button.copyWith(fontSize: 11.0),
                          ),
                        ),
                        const SizedBox(width: SpaceDims.sp8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.zero,
                            primary: ColorSty.primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: SpaceDims.sp8,
                              horizontal: SpaceDims.sp12,
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: ColorSty.primaryDark,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Pesan Lagi",
                            style: TypoSty.button.copyWith(fontSize: 11.0),
                          ),
                        )
                      ],
                    ),
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
