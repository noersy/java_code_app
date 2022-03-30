import 'package:flutter/material.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class DetailVoucherPage extends StatefulWidget {
  final LVoucher voucher;

  const DetailVoucherPage({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  @override
  _DetailVoucherPageState createState() => _DetailVoucherPageState();
}

class _DetailVoucherPageState extends State<DetailVoucherPage> {
  late final DateTime _start, _end;
  bool? isUsed = false;

  @override
  void initState() {
    _start = DateTime.fromMicrosecondsSinceEpoch(widget.voucher.periodeMulai);
    _end = DateTime.fromMicrosecondsSinceEpoch(widget.voucher.periodeSelesai);
    isUsed = widget.voucher.idVoucher ==
        Provider.of<OrderProviders>(context, listen: false)
            .selectedVoucher
            ?.idVoucher;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderProviders? orderProviders = Provider.of<OrderProviders>(context);

    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        title: "Detail Voucher",
        back: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: SpaceDims.sp12),
          CardDetailVoucher(
              urlImage: widget.voucher.infoVoucher,
              title: widget.voucher.nama,
              nominal: widget.voucher.nominal.toString()),
          const SizedBox(height: SpaceDims.sp12),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.05),
                      spreadRadius: 10,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.05),
                      spreadRadius: 8,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 7,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 3,
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.9),
                      color: ColorSty.grey80.withOpacity(0.1),
                      spreadRadius: 2,
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: SpaceDims.sp42,
                  left: SpaceDims.sp24,
                  right: SpaceDims.sp24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 230,
                      child: Text(
                        widget.voucher.nama,
                        style: TypoSty.titlePrimary,
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp8),
                    const SizedBox(
                      width: 290,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp42),
                    const Divider(thickness: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SpaceDims.sp12,
                        vertical: SpaceDims.sp2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(IconsCs.date, color: ColorSty.primary),
                              const SizedBox(width: SpaceDims.sp12),
                              Text("Valid Date", style: TypoSty.button),
                            ],
                          ),
                          Text(
                            """(${_end.difference(_end).inDays} Month) ${dateFormat.format(_start)} - ${dateFormat.format(_end)}""",
                            // style: TypoSty.mini.copyWith(
                            //     color: ColorSty.black60, fontSize: 12.0),
                          ),
                          // Text(
                          //     "${DateTime.fromMicrosecondsSinceEpoch(widget.voucher.periodeMulai)} - ${DateTime.fromMicrosecondsSinceEpoch(widget.voucher.periodeSelesai)}"),
                        ],
                      ),
                    ),
                    const Divider(thickness: 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -0.9),
                color: ColorSty.grey80.withOpacity(0.05),
                spreadRadius: 10,
              ),
              BoxShadow(
                offset: const Offset(0, -0.9),
                color: ColorSty.grey80.withOpacity(0.05),
                spreadRadius: 8,
              ),
              BoxShadow(
                offset: const Offset(0, -0.9),
                color: ColorSty.grey80.withOpacity(0.1),
                spreadRadius: 7,
              ),
              BoxShadow(
                offset: const Offset(0, -0.9),
                color: ColorSty.grey80.withOpacity(0.1),
                spreadRadius: 3,
              ),
              BoxShadow(
                offset: const Offset(0, -0.9),
                color: ColorSty.grey80.withOpacity(0.1),
                spreadRadius: 2,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: SpaceDims.sp12, vertical: SpaceDims.sp8),
          child: ElevatedButton(
            onPressed: () async {
              if (isUsed!) {
                await orderProviders.setVoucherEmpty();
              } else {
                await orderProviders.setVoucher(widget.voucher);
                await orderProviders.setVoucherUsed(true);
              }

              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
            child: Text(
              isUsed! ? "Gunakan Nanti" : "Pakai Voucher",
              style: TypoSty.button,
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetailVoucher extends StatelessWidget {
  final String urlImage, title, nominal;

  const CardDetailVoucher(
      {Key? key,
      required this.urlImage,
      required this.title,
      required this.nominal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: SpaceDims.sp8, horizontal: SpaceDims.sp12),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          primary: ColorSty.bg2,
          onPrimary: ColorSty.grey80,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Image.network(
                urlImage,
                loadingBuilder: (_, child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress != null) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Skeleton(height: 160, width: double.infinity),
                        Text(
                          loadingProgress.toStringShort(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  } else {
                    return child;
                  }
                },
              ),
              Positioned(
                right: 0.0,
                bottom: 70.0,
                child: Text(
                  "   ${nominal.toString()} ",
                  style: const TextStyle(
                    backgroundColor: Colors.white,
                    color: Color.fromRGBO(0, 154, 173, 1),
                    fontSize: 35.0,
                    decorationThickness: 2.85,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
