import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class VoucherSkeleton extends StatelessWidget {
  const VoucherSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeleton(
          height: 180,
          width: double.infinity,
          borderRadius: BorderRadius.circular(7.0),
        ),
        const SizedBox(height: 24),
        Skeleton(
          height: 180,
          width: double.infinity,
          borderRadius: BorderRadius.circular(7.0),
        ),
      ],
    );
  }
}
