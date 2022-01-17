import 'package:flutter/material.dart';
import 'package:java_code_app/models/list_voucher.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'package:intl/intl.dart';


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
  final DateFormat _format = DateFormat('dd/MM/yy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        title: "Detail Voucher",
        back: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: SpaceDims.sp12),
          CardDetailVoucher(urlImage: widget.voucher.infoVoucher, title: widget.voucher.nama),
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
                          Text("${_format.format(widget.voucher.periodeMulai)} - ${_format.format(widget.voucher.periodeSelesai)}"),
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
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
            child: Text("Pakai Voucher", style: TypoSty.button),
          ),
        ),
      ),
    );
  }
}

class CardDetailVoucher extends StatelessWidget {
  final String urlImage, title;

  const CardDetailVoucher({
    Key? key,
    required this.urlImage,
    required this.title,
  }) : super(key: key);

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
          child: Image.network(
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
                    )
                  ],
                );
              } else {
                return child;
              }
            },
          ),
        ),
      ),
    );
  }
}
