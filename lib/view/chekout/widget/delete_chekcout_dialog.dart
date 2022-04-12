import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class DeleteMenuInCheckoutDialog extends StatelessWidget {
  final String id;

  const DeleteMenuInCheckoutDialog({Key? key, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: SizedBox(
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 42),
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assert/image/icons/img-pesanan-disiapkan.svg",
                    ),
                    Positioned(
                      top: 5,
                      left: 2,
                      child: Stack(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: ColorSty.white,
                                borderRadius: BorderRadius.circular(100.0)),
                          ),
                          const Icon(Icons.cancel,
                              size: 42.0, color: Colors.redAccent)
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Text(
                          "Hapus Item?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18.sp,
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp8),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Kamu akan mengeluarkan menu ini dari ',
                            style: TypoSty.caption2.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0.sp,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Pesanan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorSty.white,
                                  onPrimary: ColorSty.primary,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SpaceDims.sp8),
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: ColorSty.primary),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<OrderProviders>(context,
                                          listen: false)
                                      .deleteOrder(id: id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Oke"),
                              ),
                            ),
                            const SizedBox(width: SpaceDims.sp12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: SpaceDims.sp8,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Kembali"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
