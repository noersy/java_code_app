
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class ListOrderOngoing extends StatelessWidget {

  final String type, title;
  final List<dynamic> orders;
  const ListOrderOngoing({
    Key? key,
    required this.type,
    required this.title, required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(orders);
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        if(orders.where((element) => element["type"] == type).isEmpty)
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
              for (Map<String, dynamic> item in orders)
                if (item["jenis"]?.compareTo(type) == 0)
                  CardMenuOngoing(data: item),
            ],
          ),
        ),
      ],
    );
  }
}


class CardMenuOngoing extends StatefulWidget {
  final Map<String, dynamic> data;

  const CardMenuOngoing({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardMenuOngoing> createState() => _CardMenuOngoingState();
}

class _CardMenuOngoingState extends State<CardMenuOngoing> {
  int _jumlahOrder = 0;
  late final String nama, harga, url;
  late final int amount;

  @override
  void initState() {
    _jumlahOrder = widget.data["countOrder"] ?? 0;
    nama = widget.data["name"] ?? "";
    url = widget.data["image"] ?? "";
    harga = "${widget.data["harga"]}";
    amount = widget.data["amount"] ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp18, vertical: SpaceDims.sp2),
      child: ElevatedButton(
        onPressed: (){
          //
          // Navigate.toEditOrderMenu(
          //     context,
          //     data: widget.data,
          //     countOrder: _jumlahOrder
          // );

        },
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
                    child: url.isNotEmpty
                        ? Image.network(url)
                        : const Icon(Icons.image_not_supported, color: ColorSty.grey),
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
              ],
            ),
            if (amount != 0)
              Positioned.fill(
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_jumlahOrder != 0)
                      TextButton(
                        onPressed: () {
                          // setState(() => _jumlahOrder--)
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(25, 25),
                          side: const BorderSide(
                            color: ColorSty.primary, width: 2,
                          ),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    if (_jumlahOrder != 0)
                      Text("$_jumlahOrder", style: TypoSty.subtitle),
                    TextButton(
                      onPressed: (){
                         // setState(() => _jumlahOrder++);
                      },
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
          ],
        ),
      ),
    );
  }
}