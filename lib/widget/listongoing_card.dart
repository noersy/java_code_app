
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class ListOrderOngoing extends StatelessWidget {

  final String type, title;
  final List<Map<String, dynamic>> orders;
  const ListOrderOngoing({
    Key? key,
    required this.type,
    required this.title, required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        if(orders.where((element) => element["type"] == type).isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                Icon(
                  type.compareTo("makanan") == 0
                      ? Icons.coffee
                      : IconsCs.ep_coffee,
                  color: ColorSty.primary,
                  size: 26.0,
                ),
                const SizedBox(width: SpaceDims.sp4),
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
    harga = widget.data["harga"] ?? "";
    amount = widget.data["amount"] ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12, vertical: SpaceDims.sp2),
      child: Card(
        elevation: 4,
        color: ColorSty.white80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: (){
            //
            // Navigate.toEditOrderMenu(
            //     context,
            //     data: widget.data,
            //     countOrder: _jumlahOrder
            // );

          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 74,
                width: 74,
                child: Padding(
                  padding: const EdgeInsets.all(SpaceDims.sp4),
                  child: Image.asset(url),
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
              if (amount != 0)
                Expanded(
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
              else
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 70,
                    padding:
                    const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                    child: Text("Stok Habis",
                      style: TypoSty.caption.copyWith(color: ColorSty.grey,),),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}