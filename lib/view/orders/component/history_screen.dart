import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/models/listhistory.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/widget/orderhistory_card.dart';
import 'package:java_code_app/view/orders/widget/skeletonorder_card.dart';
import 'package:loadmore/loadmore.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static String _dropdownValue = 'Semua Status';
  static final List<String> _item = ["Semua Status", "Selesai", "Dibatalkan"];
  static List<History> _data = [];
  static List<History> _orders = [];
  static int _status = 0;
  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static final DateTime _dateNow = DateTime.now();
  static DateTime? _dateStart;
  static DateTime? _dateEnd;

  String _dateRange = dateFormat.format(_dateNow) +
      " - " +
      dateFormat.format(
        DateTime(_dateNow.year, _dateNow.month, _dateNow.day + 7),
      );

  bool _loading = false;

  Future<void> _onRefresh() async {
    _orders.clear();
    var _duration = const Duration(seconds: 1);
    if (mounted) {
      setState(() => _loading = true);

      _orders = await Provider.of<OrderProviders>(context, listen: false)
              .getHistoryList() ??
          [];

      _data = _orders;

      Timer(_duration, () {
        if (mounted) setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  void _pickDateRange() async {
    final value = await showDialog(
      barrierColor: ColorSty.grey.withOpacity(0.2),
      context: context,
      builder: (_) => const DateRangePickerDialog(),
    );

    if (value != null) {
      final val = (value as PickerDateRange);

      _dateStart = val.startDate;
      _dateEnd = val.endDate;
      _status = 0;
      _dropdownValue = "Semua Status";
      _data = _orders
          .where((element) => (element.tanggal.compareTo(_dateStart!) >= 0 &&
              element.tanggal.compareTo(_dateEnd!) <= 0))
          .toList();

      _dateRange = dateFormat.format(val.startDate!) +
          " - " +
          dateFormat.format(val.endDate!);
      setState(() {});
    }
  }

  void _changeStatus(String? newValue) {
    if (newValue == "Semua Status") {
      _status = 0;
    } else if (newValue == "Selesai") {
      _status = 3;
    } else if (newValue == "Dibatalkan") {
      _status = 4;
    }

    if (_dateStart != null && _dateEnd != null) {
      _data = _orders
          .where((element) => (element.tanggal.compareTo(_dateStart!) >= 0 &&
                  element.tanggal.compareTo(_dateEnd!) <= 0 &&
                  _status == 0
              ? true
              : element.status == _status))
          .toList();
    } else {
      _data = _orders
          .where((element) => (_status == 0 ? true : element.status == _status))
          .toList();
    }
    _setStatus();
    setState(() => _dropdownValue = newValue!);
  }

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  bool _openStatus = false;

  _setStatus() {
    setState(() => _openStatus = !_openStatus);
  }

  List<History> list = [];

  void load() {
    print("load");
    setState(() {
      // list.addAll(List.generate(3, (v) => v));

      _orders.add(_orders[0]);
      print("data count = ${list.length}");
    });
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    // _onRefresh();
    await Future.delayed(const Duration(seconds: 0, milliseconds: 2000));
    load();
    // _onRefresh();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // tambahkan loadmore
    return Scaffold(
      body: SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: LoadMore(
          textBuilder: DefaultLoadMoreTextBuilder.english,
          isFinish: _orders.length >= 100,
          onLoadMore: _loadMore,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDims.sp18,
                  vertical: SpaceDims.sp14,
                ),
                child: _orders.isNotEmpty
                    ? Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              children: [
                                if (_loading)
                                  const SkeletonOrderCard()
                                else
                                  Column(
                                    children: [
                                      for (final item in _data)
                                        OrderHistoryCard(
                                          onPressed: () {},
                                          data: item,
                                        ),
                                      const SizedBox(height: 10.0)
                                    ],
                                  ),
                                const SizedBox(height: SpaceDims.sp8),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 160,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    if (_openStatus)
                                      Positioned(
                                        top: 25,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 123,
                                          width: 170,
                                          padding: const EdgeInsets.only(
                                            top: SpaceDims.sp12,
                                            left: SpaceDims.sp8,
                                            right: SpaceDims.sp8,
                                          ),
                                          decoration: const BoxDecoration(
                                              color: ColorSty.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1,
                                                  spreadRadius: 0.2,
                                                  offset: Offset(0, 0),
                                                  color: ColorSty.grey,
                                                )
                                              ],
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(20.0),
                                                bottomLeft:
                                                    Radius.circular(20.0),
                                              )),
                                          child: AnimatedBuilder(
                                              animation: LangProviders(),
                                              builder: (context, snapshot) {
                                                final lang = context
                                                    .watch<LangProviders>()
                                                    .lang;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                        height: SpaceDims.sp16),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _changeStatus(
                                                              "Semua Status"),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    SpaceDims
                                                                        .sp12),
                                                        child: Text(
                                                          lang.pesanan
                                                              .allStatus,
                                                          style: TypoSty.caption
                                                              .copyWith(
                                                            fontSize: 13.0,
                                                            color: _status == 0
                                                                ? ColorSty
                                                                    .primary
                                                                : ColorSty
                                                                    .black,
                                                            fontWeight:
                                                                _status == 0
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                        thickness: 1.5),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _changeStatus(
                                                              "Selesai"),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    SpaceDims
                                                                        .sp12),
                                                        child: Text(
                                                          lang.pesanan.status3,
                                                          style: TypoSty.caption
                                                              .copyWith(
                                                            fontSize: 13.0,
                                                            color: _status == 3
                                                                ? ColorSty
                                                                    .primary
                                                                : ColorSty
                                                                    .black,
                                                            fontWeight:
                                                                _status == 3
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Divider(
                                                        thickness: 1.5),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _changeStatus(
                                                              "Dibatalkan"),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    SpaceDims
                                                                        .sp12),
                                                        child: Text(
                                                          lang.pesanan.status4,
                                                          style: TypoSty.caption
                                                              .copyWith(
                                                            fontSize: 13.0,
                                                            color: _status == 4
                                                                ? ColorSty
                                                                    .primary
                                                                : ColorSty
                                                                    .black,
                                                            fontWeight:
                                                                _status == 4
                                                                    ? FontWeight
                                                                        .bold
                                                                    : FontWeight
                                                                        .w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: ColorSty.grey60,
                                        minimumSize: const Size(0, 0),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: SpaceDims.sp8 + 0.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: ColorSty.primary,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: _setStatus,
                                      child: SizedBox(
                                        width: 170.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                                width: SpaceDims.sp12),
                                            AnimatedBuilder(
                                                animation: LangProviders(),
                                                builder: (context, snapshot) {
                                                  final lang = context
                                                      .watch<LangProviders>()
                                                      .lang;
                                                  String _ttile =
                                                      lang.pesanan.allStatus;
                                                  if (_dropdownValue ==
                                                      "Selesai") {
                                                    _ttile =
                                                        lang.pesanan.status3;
                                                  }
                                                  if (_dropdownValue ==
                                                      "Dibatalkan") {
                                                    _ttile =
                                                        lang.pesanan.status4;
                                                  }
                                                  return Text(
                                                    _ttile,
                                                    textAlign: TextAlign.center,
                                                    style: TypoSty.caption
                                                        .copyWith(
                                                      fontSize: 13.0,
                                                      color: ColorSty.black60,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                }),
                                            const SizedBox(
                                                width: SpaceDims.sp8),
                                            const Icon(Icons.arrow_drop_down,
                                                size: 18.0,
                                                color: ColorSty.black),
                                            const SizedBox(
                                                width: SpaceDims.sp8),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorSty.grey60,
                                  minimumSize: const Size(0, 0),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpaceDims.sp8 + 0.5),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: ColorSty.primary),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onPressed: _pickDateRange,
                                child: SizedBox(
                                  width: 170.0,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: SpaceDims.sp12),
                                      Text(
                                        _dateRange,
                                        style: TypoSty.caption2.copyWith(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: SpaceDims.sp8),
                                      const Icon(
                                        IconsCs.date,
                                        size: 18.0,
                                        color: ColorSty.primary,
                                      ),
                                      const SizedBox(width: SpaceDims.sp8),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 120,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset("assert/image/bg_findlocation.png"),
                            AnimatedBuilder(
                                animation: LangProviders(),
                                builder: (context, snapshot) {
                                  final lang =
                                      context.watch<LangProviders>().lang;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        IconsCs.order,
                                        size: 120,
                                        color: ColorSty.primary,
                                      ),
                                      const SizedBox(height: SpaceDims.sp22),
                                      Text(
                                        lang.pesanan.riwayatCaption,
                                        textAlign: TextAlign.center,
                                        style: TypoSty.title2,
                                      ),
                                      const SizedBox(height: SpaceDims.sp12),
                                      Text(
                                        lang.pesanan.riwayatCaption2,
                                        textAlign: TextAlign.center,
                                        style: TypoSty.title2,
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _data.isNotEmpty
          ? Container(
              height: 110,
              padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDims.sp22, vertical: SpaceDims.sp14),
              decoration: const BoxDecoration(
                color: ColorSty.grey60,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedBuilder(
                      animation: LangProviders(),
                      builder: (context, snapshot) {
                        final lang = context.watch<LangProviders>().lang;
                        return Text(
                          lang.pesanan.totalOr,
                          style: TypoSty.title,
                        );
                      }),
                  _loading
                      ? const SizedBox(
                          width: 120.0,
                          child: SkeletonText(height: 16.0),
                        )
                      : Text(
                          "Rp ${oCcy.format(_data.map((e) => e.totalBayar).reduce((a, b) => a + b))}",
                          style: TypoSty.titlePrimary),
                ],
              ),
            )
          : null,
    );
  }
}

class DateRangePickerDialog extends StatelessWidget {
  const DateRangePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(SpaceDims.sp12),
          child: SizedBox(
            height: 0.5.sh,
            width: double.infinity,
            child: SfDateRangePicker(
              onSubmit: (value) {
                if (value.runtimeType == PickerDateRange &&
                    (value as PickerDateRange).endDate != null) {
                  Navigator.pop(context, value);
                }
              },
              onCancel: () => Navigator.pop(context),
              showActionButtons: true,
              selectionMode: DateRangePickerSelectionMode.range,
              extendableRangeSelectionDirection:
                  ExtendableRangeSelectionDirection.both,
              view: DateRangePickerView.month,
            ),
          ),
        ),
      );
    });
  }
}
