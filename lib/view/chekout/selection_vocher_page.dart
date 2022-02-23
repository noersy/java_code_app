import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
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
  LVoucher? _selectedVoucher;
  static List<LVoucher> _listVoucher = [];
  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;

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

  @override
  void initState() {
    Provider.of<OrderProviders>(context, listen: false).getListVoucher();
    _selectedVoucher = widget.initialData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.white,
      appBar: const CostumeAppBar(
        back: true,
        title: "Pilih Voucher",
        icon: Icon(IconsCs.voucher, color: ColorSty.primary),
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
                  return Column(
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
                      if (_selectedVoucher == null && !_loading)
                        for (LVoucher item in _listVoucher)
                          VoucherCard(
                            isChecked: false,
                            voucher: item,
                            onChanged: (String value) {
                              setState(() => _selectedVoucher = item);
                            },
                            onPressed: (String value) {
                              setState(() => _selectedVoucher = item);
                            },
                          ),
                      if (_selectedVoucher != null && !_loading)
                        VoucherCard(
                          voucher: _selectedVoucher!,
                          isChecked: true,
                          onPressed: (String value) {
                            setState(() => _selectedVoucher = null);
                          },
                        ),
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
                onPressed: () => Navigator.of(context).pop(_selectedVoucher),
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

  @override
  void initState() {
    _isSelected = widget.isChecked;
    _start = DateTime.fromMicrosecondsSinceEpoch(
        widget.voucher?.periodeMulai ?? 0 * 1000);
    _end = DateTime.fromMicrosecondsSinceEpoch(
        widget.voucher?.periodeSelesai ?? 0 * 1000);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      setState(() => _isSelected = !_isSelected);
                      widget.onPressed("${widget.voucher?.nama}");
                    },
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
                      right: 0.0,
                      bottom: 60.0,
                      child: Text(
                        " ${widget.voucher?.nominal.toString()} ",
                        style: const TextStyle(
                          backgroundColor: Colors.white,
                          color: Color.fromRGBO(0, 154, 173, 1),
                          fontSize: 35.0,
                          decorationThickness: 2.85,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Valid Date:",
                            style: TextStyle(
                                color: ColorSty.black, fontSize: 12.0),
                          ),
                          Text(
                            """(${_end.difference(_end).inDays} Month) ${dateFormat.format(_start)} - ${dateFormat.format(_end)} 
                          """,
                            style: TypoSty.mini.copyWith(
                                color: ColorSty.black60, fontSize: 9.0),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      left: 8.0,
                      child: Text("Catatan...", style: TypoSty.mini),
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
