
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/orderdetail.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class ListOrderOngoing extends StatelessWidget {

  final String type, title;
  final List<Detail> detail;
  const ListOrderOngoing({
    Key? key,
    required this.type,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        if(detail.where((element) => element.kategori == type).isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                type.compareTo("makanan") == 0
                    ? SvgPicture.asset("assert/image/icons/ep_food.svg", height: 22)
                    : SvgPicture.asset("assert/image/icons/ep_coffee.svg", height: 26),                const SizedBox(width: SpaceDims.sp4),
                Text(
                  title,
                  style: TypoSty.title.copyWith(
                    color: ColorSty.primary,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              for (Detail item in detail)
                if (item.kategori.compareTo(type) == 0)
                  CardMenuOngoing(data: item),
            ],
          ),
        ),
      ],
    );
  }
}


class CardMenuOngoing extends StatefulWidget {
  final Detail data;

  const CardMenuOngoing({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardMenuOngoing> createState() => _CardMenuOngoingState();
}

class _CardMenuOngoingState extends State<CardMenuOngoing> {
  int _jumlahOrder = 0;
  late final String nama, harga, url, catatan;

  @override
  void initState() {
    _jumlahOrder = widget.data.jumlah;
    nama = widget.data.nama;
    url = widget.data.foto ?? "";
    harga = widget.data.harga;
    catatan = widget.data.catatan ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp18, vertical: SpaceDims.sp2),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          primary: ColorSty.white,
          onPrimary: ColorSty.primary,
          padding: const EdgeInsets.all(
            SpaceDims.sp8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 74,
                  width: 74,
                  child: Padding(
                    padding: const EdgeInsets.all(SpaceDims.sp4),
                    child: Image.network(
                        url,
                      errorBuilder: imageError,
                      loadingBuilder: imageOnLoad,
                    )
                  ),
                  decoration: BoxDecoration(
                    color: ColorSty.grey60,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(width: SpaceDims.sp8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: TypoSty.title.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      harga,
                      style: TypoSty.title.copyWith(color: ColorSty.primary),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assert/image/icons/note-icon.svg"),
                        const SizedBox(width: SpaceDims.sp4),
                        Text(
                          catatan,
                          style: TypoSty.caption2.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            color: ColorSty.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}