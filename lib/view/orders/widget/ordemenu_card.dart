import 'package:flutter/material.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/listorder.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class OrderMenuCard extends StatelessWidget {
  final List<Menu> order;
  final int status;
  final VoidCallback onPressed;

  OrderMenuCard({
    Key? key,
    required this.onPressed,
    required this.order, required this.status,
  }) : super(key: key);

  final  List<String> _status = [
    "Dalam antrian",
    "Sedang disiapkan",
    "Bisa diambil",
    "",
    "",
    "",
  ];

  final  List<Color> _colors = [
    Colors.blueAccent,
    Colors.orange,
    Colors.green,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: ColorSty.white80,
          onPrimary: ColorSty.primary,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          children: [
            Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(SpaceDims.sp14),
                margin: const EdgeInsets.all(SpaceDims.sp8),
                decoration: BoxDecoration(
                  color: ColorSty.grey60,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.network(
                  order.first.foto!,
                  loadingBuilder: imageOnLoad,
                  errorBuilder: imageError,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: SpaceDims.sp18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: _colors[status],
                              ),
                              const SizedBox(width: SpaceDims.sp4),
                              Text(
                                _status[status],
                                style:
                                TypoSty.mini.copyWith(color: _colors[status]),
                              ),
                            ],
                          ),
                          Text(
                            "20 Des 2021",
                            style: TypoSty.mini.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: order.first.nama,
                          style: TypoSty.title,
                          children: [
                            for (final i
                            in List.generate(order.length, (i) => i))
                              if (i != 0) TextSpan(text: ", ${order[i].nama}")
                          ]),
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    Row(
                      children: [
                        Text(
                          "Rp 20.000",
                          style: TypoSty.mini.copyWith(
                              fontSize: 14.0, color: ColorSty.primary),
                        ),
                        const SizedBox(width: SpaceDims.sp8),
                        Text(
                          "(${order.length} Menu)",
                          style: TypoSty.mini.copyWith(
                            fontSize: 12.0,
                            color: ColorSty.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
