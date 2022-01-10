import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/card_coupun.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        back: true,
        dense: true,
        icon: Icon(IconsCs.coupon, color: ColorSty.primary),
        title: 'Promo',
      ),
      body: Column(
        children: [
          const SizedBox(height: SpaceDims.sp24),
          const CardCoupon(),
          const SizedBox(height: SpaceDims.sp24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: ColorSty.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -1),
                      color: ColorSty.grey.withOpacity(0.01),
                      spreadRadius: 1,
                    )
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: SpaceDims.sp24,
                        bottom: SpaceDims.sp12,
                        left: SpaceDims.sp24,
                        right: SpaceDims.sp24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nama Promo", style: TypoSty.title),
                          Text("Diskon 10%",
                              style: TypoSty.title
                                  .copyWith(color: ColorSty.primary))
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp24),
                      color: ColorSty.grey,
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    Row(
                      children: [
                        const SizedBox(width: SpaceDims.sp24),
                        const Icon(Icons.list,
                            color: ColorSty.primary, size: 32.0),
                        const SizedBox(width: SpaceDims.sp12),
                        Column(
                          children: const [
                            Text("Syarat dan Ketentuan",
                                style: TypoSty.subtitle),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: SpaceDims.sp16,
                        left: 72.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            """Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea vommodo consequat.
                            """,
                            textAlign: TextAlign.left,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: SpaceDims.sp12),
                            child: Column(
                              children: const [
                                Text(
                                  "1. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: SpaceDims.sp12),
                                Text(
                                  "2. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: SpaceDims.sp12),
                                Text(
                                  "3. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SpaceDims.sp12),
                          const Text(
                            """Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea vommodo consequat.
                            """,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
