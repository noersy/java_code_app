import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class CardMenu extends StatefulWidget {
  final String nama, harga, url;
  final int amount;

  const CardMenu({
    Key? key,
    required this.nama,
    required this.harga,
    required this.url,
    required this.amount,
  }) : super(key: key);

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  int jumlahOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      child: Card(
        color: ColorSty.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Container(
              height: 74,
              width: 74,
              margin: const EdgeInsets.all(SpaceDims.sp8),
              child: Padding(
                padding: const EdgeInsets.all(SpaceDims.sp4),
                child: Image.asset(widget.url),
              ),
              decoration: BoxDecoration(
                color: ColorSty.white60.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.nama,
                  style: TypoSty.title.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.harga,
                  style: TypoSty.title.copyWith(color: ColorSty.primary),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.playlist_add_check,
                      color: ColorSty.primary,
                    ),
                    const SizedBox(width: SpaceDims.sp4),
                    Text(
                      "Tambahkan Catatan",
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
            if (widget.amount != 0)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (jumlahOrder != 0)
                      TextButton(
                        onPressed: () => setState(() => jumlahOrder--),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(25, 25),
                          side: const BorderSide(
                              color: ColorSty.primary, width: 2),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    if (jumlahOrder != 0)
                      Text("$jumlahOrder", style: TypoSty.subtitle),
                    TextButton(
                      onPressed: () => setState(() => jumlahOrder++),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(25, 25),
                        primary: ColorSty.white,
                        backgroundColor: ColorSty.primary,
                      ),
                      child: const Icon(Icons.add, color: ColorSty.white),
                    )
                  ],
                ),
              )
            else
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  height: 70,
                  padding:
                  const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                  child: Text("Stok Habis",
                      style: TypoSty.caption.copyWith(color: ColorSty.grey)),
                ),
              )
          ],
        ),
      ),
    );
  }
}