import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class SkeletonOrderMenuCard extends StatelessWidget {
  const SkeletonOrderMenuCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp16),
          child: ElevatedButton(
            onPressed: () {},
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
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(SpaceDims.sp8),
                  decoration: BoxDecoration(
                    color: ColorSty.grey60,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Skeleton(),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: SpaceDims.sp18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  SizedBox(
                                    width: 14.0,
                                    child: SkeletonText(height: 14.0),
                                  ),
                                  SizedBox(width: SpaceDims.sp4),
                                  SizedBox(
                                    width: 90.0,
                                    child: SkeletonText(height: 11.0),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 56.0,
                                child: SkeletonText(height: 11.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: SpaceDims.sp14),
                        const SkeletonText(height: 26.0),
                        const SizedBox(height: SpaceDims.sp24),
                        Row(
                          children: const [
                            SizedBox(
                              width: 60.0,
                              child: SkeletonText(height: 14.0),
                            ),
                            SizedBox(width: SpaceDims.sp8),
                            SizedBox(
                              width: 40.0,
                              child: Align(
                                alignment: Alignment.center,
                                child: SkeletonText(height: 12.0),
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
      ],
    );
  }
}
