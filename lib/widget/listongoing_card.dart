
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/view/checkout_page.dart';
import 'package:provider/provider.dart';

class ListOrderOngoing extends StatefulWidget {
  final String type, title;

  const ListOrderOngoing({
    Key? key,
    required this.type,
    required this.title,
  }) : super(key: key);

  @override
  State<ListOrderOngoing> createState() => _ListOrderOngoingState();
}

class _ListOrderOngoingState extends State<ListOrderOngoing> {
  List<Map<String, dynamic>> get _orders  => Provider.of<OrderProvider>(context, listen: false).orderProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        if(_orders.where((element) => element["type"] == widget.type).isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                Icon(
                  widget.type.compareTo("makanan") == 0
                      ? Icons.coffee
                      : IconsCs.ep_coffee,
                  color: ColorSty.primary,
                  size: 26.0,
                ),
                const SizedBox(width: SpaceDims.sp4),
                Text(
                  widget.title,
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
              for (Map<String, dynamic> item in _orders)
                if (item["jenis"]?.compareTo(widget.type) == 0)
                  CardMenuChecout(data: item),
            ],
          ),
        ),
      ],
    );
  }
}
