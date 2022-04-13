import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/component/voucher_skeleton.dart';
import 'package:java_code_app/widget/dialog/custom_dialog.dart';
import 'package:java_code_app/widget/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class SelectionVoucherPage extends StatefulWidget {
  final LVoucher? initialData;

  const SelectionVoucherPage({Key? key, this.initialData}) : super(key: key);

  @override
  State<SelectionVoucherPage> createState() => _SelectionVoucherPageState();
}

class _SelectionVoucherPageState extends State<SelectionVoucherPage> {
  static List<LVoucher> _listVoucher = [];
  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;
  bool _isUsed = false;
  bool isLoading = true;

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 1);
    if (mounted) {
      setState(() => _loading = true);

      await Provider.of<OrderProviders>(context, listen: false)
          .getListVoucher();

      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  setVoucher({LVoucher? data}) async {
    await Provider.of<OrderProviders>(
      context,
      listen: false,
    ).setVoucher(data ?? widget.initialData);
  }

  getData() async {
    await Provider.of<OrderProviders>(context, listen: false)
        .getListVoucher()
        .then((value) {
      if (!value) {
        showCustomSnackbar(context, 'Mohon periksa koneksi Anda');
      } else {
        if (!mounted) return false;
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderProviders? orderProviders = Provider.of<OrderProviders>(context);
    LVoucher? _selectedVoucher = orderProviders.selectedVoucher;

    return Scaffold(
      backgroundColor: ColorSty.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ColorSty.primary),
          onPressed: () async {
            bool? isVoucherUsed = orderProviders.isVoucherUsed ?? false;
            if (orderProviders.selectedVoucher != null && !isVoucherUsed) {
              await showCustomDialog(
                context,
                titleText: 'Apakah Anda yakin ingin kembali?',
                bodyText:
                    'Jika iya. Apakah Anda ingin menggunakan voucher yang terpilih?',
                labelYes: 'Gunakan',
                labelClose: 'Tidak',
                onYes: () async {
                  if (!mounted) return;
                  setState(() {
                    _isUsed = true;
                  });
                  await Provider.of<OrderProviders>(context, listen: false)
                      .setVoucherUsed(true);
                  Navigator.pop(context);
                },
                onClose: () {
                  Navigator.pop(context);
                },
              );
            }
            if (_isUsed || isVoucherUsed) {
              Navigator.of(context).pop(_selectedVoucher);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(IconsCs.voucher, color: ColorSty.primary),
            const SizedBox(width: SpaceDims.sp8),
            Text("Pilih Voucher", style: TypoSty.title),
            const SizedBox(width: SpaceDims.sp46 + 3),
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SpaceDims.sp24,
              horizontal: SpaceDims.sp24,
            ),
            child: AnimatedBuilder(
                animation: OrderProviders(),
                builder: (context, snapshot) {
                  _listVoucher =
                      Provider.of<OrderProviders>(context).listVoucher;
                  return isLoading
                      ? const VoucherSkeleton()
                      : Column(
                          children: [
                            if (_listVoucher.isEmpty)
                              const Text('Maaf, Anda Tidak Memiliki Voucher'),
                            if (_loading)
                              VoucherCard(
                                voucher: _selectedVoucher,
                                isChecked: false,
                                isLoading: true,
                                onPressed: (String value) {
                                  setState(() => _selectedVoucher = null);
                                },
                              ),
                            if (!_loading)
                              for (LVoucher item in _listVoucher)
                                VoucherCard(
                                  isChecked: _selectedVoucher?.idVoucher ==
                                      item.idVoucher,
                                  voucher: item,
                                  onChanged: (String value) {
                                    _selectedVoucher?.idVoucher ==
                                            item.idVoucher
                                        ? orderProviders.setVoucherEmpty()
                                        : orderProviders.setVoucher(item);
                                  },
                                  onPressed: (String value) {
                                    _selectedVoucher?.idVoucher ==
                                            item.idVoucher
                                        ? orderProviders.setVoucherEmpty()
                                        : orderProviders.setVoucher(item);
                                  },
                                ),
                            // if (_selectedVoucher != null && !_loading)
                            //   VoucherCard(
                            //     voucher: _selectedVoucher!,
                            //     isChecked: true,
                            //     onPressed: (String value) {
                            //       setState(() => _selectedVoucher = null);
                            //     },
                            //   ),
                          ],
                        );
                }),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 106.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorSty.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            for (int index in Iterable.generate(15))
              BoxShadow(
                offset: const Offset(0, -3),
                color: ColorSty.grey80.withOpacity(0.02),
                spreadRadius: index.toDouble(),
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp22),
          child: Column(
            children: [
              const SizedBox(height: SpaceDims.sp14),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: ColorSty.primary,
                    size: 18.0,
                  ),
                  const SizedBox(width: SpaceDims.sp8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Penggunaan voucher tidak dapat digabung dengan"),
                      Text(
                        "discount employee reward program",
                        style: TextStyle(
                          color: ColorSty.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: SpaceDims.sp8),
              ElevatedButton(
                onPressed: () async {
                  if (_selectedVoucher == null) {
                    showCustomSnackbar(
                      context,
                      'Voucher belum dipilih!',
                    );
                  } else {
                    await Provider.of<OrderProviders>(context, listen: false)
                        .setVoucherUsed(true);
                    Navigator.of(context).pop(_selectedVoucher);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Oke", style: TypoSty.button),
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

class VoucherCard extends StatefulWidget {
  final bool isChecked;
  final LVoucher? voucher;
  final bool? isLoading;
  final Function(String string) onPressed;
  final ValueChanged<String>? onChanged;

  const VoucherCard({
    Key? key,
    required this.onPressed,
    required this.isChecked,
    this.onChanged,
    required this.voucher,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _VoucherCardState createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  bool _isSelected = false;
  late final DateTime _start, _end;
  late int _difference;
  late int _months;
  @override
  void initState() {
    _isSelected = widget.isChecked;
    _start = DateTime.fromMillisecondsSinceEpoch(
        widget.voucher!.periodeMulai * 1000);
    _end = DateTime.fromMillisecondsSinceEpoch(
        widget.voucher!.periodeSelesai * 1000);
    _difference = _end.difference(_start).inDays;
    int years = _difference ~/ 365;
    _months = (_difference - years * 365) ~/ 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        onPressed: widget.voucher != null
            ? () async {
                _isSelected = (await Navigate.toDetailVoucherPage(context,
                        voucher: widget.voucher!)) ??
                    false;

                if (_isSelected && widget.onChanged != null) {
                  widget.onChanged!(widget.voucher!.nama);
                }
              }
            : () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          primary: ColorSty.bg2,
          onPrimary: ColorSty.grey80,
          // elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isLoading!)
                    const SkeletonText(height: 12.0)
                  else
                    Text(
                      "${widget.voucher?.nama}",
                      style: TypoSty.button.copyWith(color: ColorSty.black60),
                    ),
                  IconButton(
                    onPressed: widget.voucher != null
                        ? () async {
                            setState(() => _isSelected = !_isSelected);
                            widget.onPressed("${widget.voucher?.nama}");

                            // _isSelected = (await Navigate.toDetailVoucherPage(
                            //         context,
                            //         voucher: widget.voucher!)) ??
                            //     false;

                            // if (_isSelected && widget.onChanged != null) {
                            //   widget.onChanged!(widget.voucher!.nama);
                            // }
                          }
                        : () {},
                    // : () {
                    //     setState(() => _isSelected = !_isSelected);
                    //     widget.onPressed("${widget.voucher?.nama}");
                    //   },
                    icon: widget.isChecked
                        ? const Icon(
                            Icons.check_box_outlined,
                            color: ColorSty.black60,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank_sharp,
                            color: ColorSty.black60,
                          ),
                  )
                ],
              ),
            ),
            if (widget.isLoading!)
              Skeleton(
                height: 160,
                width: double.infinity,
              )
            else
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        "${widget.voucher?.infoVoucher}",
                        errorBuilder: imageError,
                        loadingBuilder: imageOnLoad,
                      ),
                    ),
                    Positioned(
                      right: 12.0,
                      bottom: 60.0,
                      child: SizedBox(
                        width: (width * 0.35) - 12,
                        child: AutoSizeText(
                          " ${oCcy.format(widget.voucher?.nominal)} ",
                          maxLines: 1,
                          style: TextStyle(
                            backgroundColor: Colors.white,
                            color: const Color.fromRGBO(0, 154, 173, 1),
                            fontSize: 32.0.sp,
                            decorationThickness: 2.85,
                          ),
                          textAlign: TextAlign.end,
                          minFontSize: 0,
                          stepGranularity: 0.1,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Valid Date:",
                            style: TextStyle(
                              color: ColorSty.black,
                              fontSize: 10.0.sp,
                            ),
                          ),
                          if (_end.difference(_start).inDays < 31)
                            Text(
                              """(${_end.difference(_start).inDays} Days) ${dateFormat.format(_start)} - ${dateFormat.format(_end)} 
                          """,
                              style: TypoSty.mini.copyWith(
                                color: ColorSty.black60,
                                fontSize: 8.0.sp,
                              ),
                            ),
                          if (_end.difference(_start).inDays > 31)
                            Text(
                              """($_months Month) ${dateFormat.format(_start)} - ${dateFormat.format(_end)} 
                          """,
                              style: TypoSty.mini.copyWith(
                                color: ColorSty.black60,
                                fontSize: 8.0.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 8.0,
                      child: SizedBox(
                        width: width * 0.37,
                        child: Text(
                          widget.voucher!.catatan ?? "Catatan...",
                          style: TypoSty.mini.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
