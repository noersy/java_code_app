import 'package:flutter/material.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';

class InfoDiscountDialog extends StatelessWidget {
  const InfoDiscountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 195.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp32),
          child: Column(
            children: [
              const SizedBox(height: SpaceDims.sp24),
              const Text("Info Discount", style: TypoSty.titlePrimary),
              Column(
                children: [
                  const SizedBox(height: SpaceDims.sp24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Info Discount", style: TypoSty.caption),
                      Text("10%", style: TypoSty.captionBold),
                    ],
                  ),
                  const SizedBox(height: SpaceDims.sp4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Info Discount", style: TypoSty.caption),
                      Text("10%", style: TypoSty.captionBold),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: SpaceDims.sp22),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 90.0,
                  child: Align(alignment: Alignment.center, child: Text("Oke")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
