import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/button/label_button.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class BerandaSkeleton extends StatelessWidget {
  const BerandaSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: SpaceDims.sp22),
        Padding(
          padding: const EdgeInsets.only(left: SpaceDims.sp24),
          child: Row(
            children: [
              const Icon(
                IconsCs.coupon,
                color: ColorSty.primary,
                size: 22.0,
              ),
              const SizedBox(width: SpaceDims.sp22),
              Text(
                Provider.of<LangProviders>(context).lang.beranda!.promoTersedia,
                style: TypoSty.title,
              ),
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp22),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                height: 158.0,
                width: 290.0,
                padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SkeletonText(height: 26.0)),
                          const SizedBox(width: SpaceDims.sp12),
                          Text(
                            "%",
                            style: TypoSty.heading.copyWith(
                              fontSize: 36.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = ColorSty.white,
                            ),
                          ),
                        ],
                      ),
                      const SkeletonText(height: 22.0)
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorSty.primary,
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      ColorSty.primary.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('assert/image/bg_coupon_card.png'),
                  ),
                ),
              ),
              Container(
                height: 158.0,
                width: 260.0,
                padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                  child: Skeleton(
                      height: 120, borderRadius: BorderRadius.circular(7.0)),
                ),
                decoration: BoxDecoration(
                  color: ColorSty.primary,
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      ColorSty.primary.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('assert/image/bg_coupon_card.png'),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: SpaceDims.sp12),
              LabelButton(
                color: ColorSty.black,
                onPressed: () {},
                title:
                    Provider.of<LangProviders>(context).lang.beranda!.semuaMenu,
                icon: Icons.list,
              ),
              LabelButton(
                color: ColorSty.primary,
                onPressed: () {},
                title: Provider.of<LangProviders>(context)
                    .lang
                    .beranda!
                    .semuaMakanan,
                svgPicture: SvgPicture.asset(
                  "assert/image/icons/ep_food.svg",
                  color: ColorSty.white,
                  width: 24,
                ),
              ),
              LabelButton(
                color: ColorSty.primary,
                onPressed: () {},
                title: Provider.of<LangProviders>(context)
                    .lang
                    .beranda!
                    .semuaMinuman,
                icon: IconsCs.coffee,
              ),
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: SpaceDims.sp22),
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assert/image/icons/ep_food.svg",
                    height: 22,
                  ),
                  const SizedBox(width: SpaceDims.sp4),
                  Text(
                    Provider.of<LangProviders>(context)
                        .lang
                        .beranda!
                        .semuaMakanan,
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDims.sp12),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp22,
                          vertical: SpaceDims.sp8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            primary: ColorSty.white80,
                            onPrimary: ColorSty.primary,
                            padding: const EdgeInsets.all(
                              SpaceDims.sp8,
                            ),
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
                                  child: Skeleton(
                                      height: 100,
                                      borderRadius: BorderRadius.circular(7.0)),
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
                                  const SkeletonText(height: 12.0),
                                  const SkeletonText(height: 12.0),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.playlist_add_check,
                                        color: ColorSty.primary,
                                      ),
                                      SizedBox(width: SpaceDims.sp4),
                                      SkeletonText(height: 12.0),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp22,
                          vertical: SpaceDims.sp8,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            primary: ColorSty.white80,
                            onPrimary: ColorSty.primary,
                            padding: const EdgeInsets.all(
                              SpaceDims.sp8,
                            ),
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
                                  child: Skeleton(
                                      height: 100,
                                      borderRadius: BorderRadius.circular(7.0)),
                                ),
                                decoration: BoxDecoration(
                                  color: ColorSty.grey60,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              const SizedBox(width: SpaceDims.sp8),
                              Expanded(
                                  child: Skeleton(
                                      height: 60.0,
                                      borderRadius:
                                          BorderRadius.circular(7.0))),
                              const SizedBox(width: SpaceDims.sp8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: SpaceDims.sp22),
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assert/image/icons/ep_coffee.svg",
                    height: 26,
                  ),
                  const SizedBox(width: SpaceDims.sp4),
                  Text(
                    Provider.of<LangProviders>(context)
                        .lang
                        .beranda!
                        .semuaMinuman,
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDims.sp12),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpaceDims.sp12,
                      vertical: SpaceDims.sp2,
                    ),
                    child: Card(
                      elevation: 4,
                      color: ColorSty.white80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
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
                                child: Skeleton(height: 100),
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
                                const SkeletonText(height: 12.0),
                                const SkeletonText(height: 12.0),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.playlist_add_check,
                                      color: ColorSty.primary,
                                    ),
                                    SizedBox(width: SpaceDims.sp4),
                                    SkeletonText(height: 12.0),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
