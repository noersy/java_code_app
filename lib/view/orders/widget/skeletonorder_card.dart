import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class SkeletonOrderCard extends StatelessWidget {
  const SkeletonOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0,
      ),
      child: SizedBox(
        height: 138,
        child: ElevatedButton(
          onPressed: (){},
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
                margin: const EdgeInsets.all(SpaceDims.sp8),
                decoration: BoxDecoration(
                  color: ColorSty.grey60,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Skeleton(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: SpaceDims.sp8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: SpaceDims.sp18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(
                              width: 40.0,
                              child: SkeletonText(height: 11),
                            ),
                            SizedBox(
                              width: 90.0,
                              child: SkeletonText(height: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp12),
                      const SkeletonText(height: 26.0),
                      const SizedBox(height: SpaceDims.sp8),
                      Expanded(
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 60.0,
                              child: SkeletonText(height: 14.0),
                            ),
                            SizedBox(width: SpaceDims.sp8),
                            SizedBox(
                              width: 30.0,
                              child: SkeletonText(height: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
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
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Beri Penilaian",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
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
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Pesan Lagi",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
                            ),
                          )
                        ],
                      ),
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
