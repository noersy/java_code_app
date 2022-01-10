import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Padding(
        padding: const EdgeInsets.only(
          right: SpaceDims.sp18,
          left: SpaceDims.sp18,
          top: SpaceDims.sp12,
        ),
        child: AnimatedBuilder(
          animation: OrderProviders(),
          builder: (BuildContext context, Widget? child) {
            final _orderOngoing = Provider.of<OrderProviders>(context).orderProgress;

            return SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: _orderOngoing.isNotEmpty ? Column(
                children: [
                  for(Map<String, dynamic> item in _orderOngoing)
                    OrderMenuCard(
                      onPressed: () => Navigate.toViewOrder(
                        context,
                        dataOrders: item,
                      ),
                      date: "date",
                      harga: item["orders"][0]["harga"],
                      title: item["orders"][0]["image"],
                      urlImage: item["orders"][0]["harga"],
                    ),
                ],
              ) : Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assert/image/bg_findlocation.png"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(IconsCs.order_icon, size: 120, color: ColorSty.primary),
                      SizedBox(height: SpaceDims.sp22),
                      Text("Sudah Pesan?\nLacak pesananmu\ndi sini.", textAlign: TextAlign.center, style: TypoSty.title2),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderMenuCard extends StatelessWidget {
  final String urlImage, title, date, harga;
  final VoidCallback onPressed;

  const OrderMenuCard({
    Key? key,
    required this.urlImage,
    required this.title,
    required this.date,
    required this.harga,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(urlImage);

    return Card(
      elevation: 4,
      color: ColorSty.white80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
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
                child: Image.asset("assert/image/menu/1637916792.png"),
              ),
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
                                const Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: SpaceDims.sp4),
                                Text(
                                  "Sedang disiapkan",
                                  style:
                                  TypoSty.mini.copyWith(color: Colors.orange),
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
                      Text("Fried Rice, Chicken Katsu", style: TypoSty.title),
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
                            "(3 Menu)",
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
      ),
    );
  }
}
