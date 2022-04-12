import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/listhistory.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class OrderHistoryCard extends StatelessWidget {
  final History data;
  final VoidCallback onPressed;

  const OrderHistoryCard(
      {Key? key, required this.onPressed, required this.data})
      : super(key: key);

  void _pesanLagi(BuildContext context) async {
    final provider = Provider.of<OrderProviders>(context, listen: false);

    for (final item in data.menu) {
      provider.addOrder(
        data: {
          "id": "${item.idMenu}",
          "jenis": item.kategori,
          "image": item.foto,
          "harga": int.parse(item.harga),
          "amount": 1,
          "name": item.nama,
        },
        jumlahOrder: item.jumlah,
        catatan: "none",
      );
    }

    Navigate.toChekOut(context);
  }

  @override
  Widget build(BuildContext context) {
    String tanggal = dateFormat.format(data.tanggal);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpaceDims.sp8,
      ),
      child: SizedBox(
        height: 138,
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
                  data.menu.isNotEmpty
                      ? data.menu.first.foto ?? "http://"
                      : "http://",
                  loadingBuilder: imageOnLoad,
                  errorBuilder: imageError,
                ),
              ),
              AnimatedBuilder(
                  animation: LangProviders(),
                  builder: (context, snapshot) {
                    final lang = context.watch<LangProviders>().lang;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: SpaceDims.sp8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(data.noStruk),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: SpaceDims.sp18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        size: 18.0,
                                        color: data.status == 3
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                      const SizedBox(width: SpaceDims.sp4),
                                      Text(
                                        data.status == 3
                                            ? lang.pesanan.status3
                                            : lang.pesanan.status4,
                                        style: TypoSty.mini.copyWith(
                                          color: data.status == 3
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    tanggal,
                                    style: TypoSty.mini.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: SpaceDims.sp2),
                            SizedBox(
                              height: 42,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: RichText(
                                  text: TextSpan(
                                      style: TypoSty.title,
                                      children: [
                                        for (var i = 0;
                                            i < data.menu.length;
                                            i++)
                                          if (i != 0 || i < 1)
                                            TextSpan(
                                                text: '${data.menu[i].nama},')
                                      ]
                                      // children: [
                                      //   for (final i in List.generate(
                                      //       data.menu.length, (index) => index))
                                      //     if (i == 0)
                                      //       TextSpan(
                                      //           text: ", ${data.menu[i].nama}")
                                      // ]
                                      ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 42,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(right: 8.0),
                            //     child: RichText(
                            //       text: TextSpan(
                            //           style: TypoSty.title,
                            //           text: data.menu.isNotEmpty
                            //               ? data.menu.first.nama
                            //               : "",
                            //           children: [
                            //             for (final i in List.generate(
                            //                 data.menu.length, (index) => index))
                            //               if (i == 0)
                            //                 TextSpan(
                            //                     text: ", ${data.menu[i].nama}")
                            //           ]),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: SpaceDims.sp4),
                            Row(
                              children: [
                                Text(
                                  "Rp ${oCcy.format(data.totalBayar)}",
                                  style: TypoSty.mini.copyWith(
                                    fontSize: 12.0.sp,
                                    color: ColorSty.primary,
                                  ),
                                ),
                                const SizedBox(width: SpaceDims.sp8),
                                Text(
                                  "(${data.menu.length} Menu)",
                                  style: TypoSty.mini.copyWith(
                                    fontSize: 10.0.sp,
                                    color: ColorSty.grey,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (data.status == 3)
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.zero,
                                        primary: ColorSty.white,
                                        onPrimary: ColorSty.primary,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: SpaceDims.sp8,
                                          horizontal: SpaceDims.sp12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: ColorSty.primaryDark,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigate.toPenilaian(context);
                                      },
                                      child: Text(
                                        lang.pesanan.buttonPe,
                                        style: TypoSty.button
                                            .copyWith(fontSize: 10.0.sp),
                                      ),
                                    ),
                                  const SizedBox(width: SpaceDims.sp8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size.zero,
                                      primary: ColorSty.primary,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: SpaceDims.sp8,
                                        horizontal: SpaceDims.sp12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: ColorSty.primaryDark,
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    onPressed: () => _pesanLagi(context),
                                    child: Text(
                                      lang.pesanan.buttonLa,
                                      style: TypoSty.button
                                          .copyWith(fontSize: 10.0.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
