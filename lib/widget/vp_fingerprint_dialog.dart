import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/vp_pin_dialog.dart';

class VFingerPrintDialog extends StatelessWidget {
  final BuildContext ctx;
  const VFingerPrintDialog({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.h)),
      child: SizedBox(
        height: 0.45.sh,
        child: Padding(
          padding: EdgeInsets.only(top: 24.w),
          child: Column(
            children: [
              Text(
                "Verifikasi Pesanan",
                style: TypoSty.title.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Finger Print",
                style: TypoSty.caption2.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 28.h),
              SvgPicture.asset("assert/image/icons/Finger-print.svg"),
              SizedBox(height: 20.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 42.w),
                child: Row(
                  children: [
                    const Expanded(child: Divider(thickness: 3)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: const Text("Atau", style: TypoSty.caption2),
                    ),
                    const Expanded(child: Divider(thickness: 3)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(context: context, builder: (_)=> const VPinDialog());
                },
                child: Text(
                  "Verifikasi Menggunakan PIN",
                  style: TypoSty.subtitle.copyWith(color: ColorSty.primary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
