import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/selection_vocher_page.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/card_coupun.dart';

class PromoPage extends StatelessWidget {
  final int? discount, nominal;
  final String title, police;

  const PromoPage({Key? key, this.discount, this.nominal, required this.title, required this.police}) : super(key: key);

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
      body: ScreenUtilInit(builder: () {
        return Column(
          children: [
            SizedBox(height: SpaceDims.sp24.h),
            CardCoupon(police: police, title: title, discount: discount, nominal: nominal),
            SizedBox(height: SpaceDims.sp24.h),
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
                        padding: EdgeInsets.only(
                          top: SpaceDims.sp24.h,
                          bottom: SpaceDims.sp12.h,
                          left: SpaceDims.sp24.w,
                          right: SpaceDims.sp24.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Nama Promo", style: TypoSty.title),
                            Text(
                              nominal == null ? "Diskon $discount%" : "Rp $nominal Voucher ",
                              style: TypoSty.title.copyWith(
                                color: ColorSty.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp24.h,
                        ),
                        color: ColorSty.grey,
                      ),
                      const SizedBox(height: SpaceDims.sp12),
                      Row(
                        children: [
                          SizedBox(width: SpaceDims.sp24.w),
                          const Icon(
                            Icons.list,
                            color: ColorSty.primary,
                            size: 32.0,
                          ),
                          SizedBox(width: SpaceDims.sp12.w),
                          Column(
                            children: [
                              Text(
                                "Syarat dan Ketentuan",
                                style: TypoSty.subtitle,
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: SpaceDims.sp16.w,
                          left: 72.0.w,
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
                              padding: EdgeInsets.only(left: SpaceDims.sp12.w),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("1. "),
                                      Expanded(
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SpaceDims.sp12.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("2. "),
                                      Expanded(
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: SpaceDims.sp12.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("3. "),
                                      Expanded(
                                        child: Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SpaceDims.sp12.h),
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
        );
      }),
    );
  }
}
