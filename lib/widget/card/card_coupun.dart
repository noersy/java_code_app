import 'package:flutter/material.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class CardCoupon extends StatelessWidget {
  final int? discount, nominal;
  final String title, police;
  final bool disable;
  final Color? color;
  const CardCoupon({
    Key? key,
    this.discount,
    required this.title,
    this.nominal,
    required this.police,
    this.disable = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158.0,
      width: 290.0,
      padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      child: TextButton(
        onPressed: disable
            ? null
            : () => Navigate.toPromoPage(
                  context,
                  title: title,
                  police: police,
                  discount: discount,
                  nominal: nominal,
                ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    discount != null ? "Diskon  " : "Voucher  ",
                    style: TypoSty.heading
                        .copyWith(color: ColorSty.white, fontSize: 25),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    discount != null
                        ? discount != 0
                            ? "$discount %"
                            : "-"
                        : "Rp $nominal",
                    style: TypoSty.heading.copyWith(
                      fontSize: discount != null ? 36.0 : 22.0,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = ColorSty.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TypoSty.caption.copyWith(color: ColorSty.white),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: color ?? ColorSty.primary,
        borderRadius: BorderRadius.circular(7.0),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            ColorSty.primary.withOpacity(0.1),
            BlendMode.dstATop,
          ),
          image: const AssetImage('assert/image/bg_coupon_card.png'),
        ),
      ),
    );
  }
}
