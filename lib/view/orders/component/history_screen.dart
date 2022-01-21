import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/models/listhistory.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/widget/orderhistory_card.dart';
import 'package:java_code_app/view/orders/widget/skeletonorder_card.dart';
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
  static final RefreshController _refreshController = RefreshController(initialRefresh: false);
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
    var _duration = const Duration(seconds:1);
    if (mounted) {
      setState(() => _loading = true);

      _orders = await Provider.of<OrderProviders>(context, listen: false)
              .getHistoryList() ??
          [];

      _data = _orders;

      Timer(_duration, () {
        setState(() => _loading = false);
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
      _data = _orders.where(
              (element) => (element.tanggal.compareTo(_dateStart!) >= 0
                  && element.tanggal.compareTo(_dateEnd!) <= 0)
      ).toList();

      _dateRange = dateFormat.format(val.startDate!) +
          " - " +
          dateFormat.format(val.endDate!);
      setState(() {});
    }
  }
  void _changeSatuts(String? newValue) {

    if(newValue == "Semua Status") {
      _status = 0;
    }else if(newValue == "Selesai"){
      _status = 3;
    }else if(newValue == "Dibatalkan"){
      _status = 4;
    }

    if(_dateStart != null && _dateEnd !=null){
      _data = _orders.where(
              (element) => (element.tanggal.compareTo(_dateStart!) >= 0
              && element.tanggal.compareTo(_dateEnd!) <= 0
              && _status == 0 ? true : element.status == _status)
      ).toList();
    }else{
      _data = _orders.where(
              (element) => (_status == 0 ? true : element.status == _status)
      ).toList();
    }

    setState(() => _dropdownValue = newValue!);
  }

  @override
  void initState() {
    _onRefresh();
    super.initState();
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
            child: _orders.isNotEmpty
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
                            width: 170.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorSty.grey60,
                              border: Border.all(color: ColorSty.primary),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: DropdownButton<String>(
                              isDense: true,
                              value: _dropdownValue,
                              alignment: Alignment.topCenter,
                              underline: const SizedBox.shrink(),
                              borderRadius: BorderRadius.circular(30.0),
                              icon: const Icon(Icons.arrow_drop_down),
                              style: TypoSty.caption2.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: ColorSty.black),
                              onChanged: _changeSatuts,
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
                              minimumSize: const Size(0, 0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: SpaceDims.sp8 + 0.5),
                              shape: RoundedRectangleBorder(
                                side:
                                    const BorderSide(color: ColorSty.primary),
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
                                  const Icon(IconsCs.date,
                                      size: 18.0, color: ColorSty.primary),
                                  const SizedBox(width: SpaceDims.sp8),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            const Icon(
                              IconsCs.order,
                              size: 120,
                              color: ColorSty.primary,
                            ),
                            const SizedBox(height: SpaceDims.sp22),
                            Text("Mulai buat pesanan.",
                                textAlign: TextAlign.center,
                                style: TypoSty.title2,
                            ),
                            const SizedBox(height: SpaceDims.sp12),
                            Text(
                                "Makanan yang kamu pesan\nakan muncul di sini agar\nkamu bisa menemukan\nmenu favoritmu lagi!.",
                                textAlign: TextAlign.center,
                                style: TypoSty.title2,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
                  Text(
                    "Total Pesanan",
                    style: TypoSty.title,
                  ),
                  _loading
                      ? const SizedBox(
                          width: 120.0,
                          child: SkeletonText(height: 16.0),
                        )
                      : Text("Rp ${oCcy.format(_data.map((e) => e.totalBayar).reduce((a, b) => a+b))}", style: TypoSty.titlePrimary),
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
