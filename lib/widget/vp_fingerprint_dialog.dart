import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/orderdone_dialog.dart';
import 'package:java_code_app/widget/vp_pin_dialog.dart';
import 'package:local_auth/local_auth.dart';

class VFingerPrintDialog extends StatelessWidget {
  final BuildContext ctx;
  final LVoucher voucher;

  const VFingerPrintDialog({Key? key, required this.ctx, required this.voucher}) : super(key: key);

  static final localAuth = LocalAuthentication();

  void _chekFingerPrint(context) async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    // final availableBiometrics = await localAuth.getAvailableBiometrics();
    // print(availableBiometrics);

    if(canCheckBiometrics){
      bool didAuthenticate = await localAuth.authenticate(
        biometricOnly: true,
        localizedReason: 'Please authenticate to continue',
      );

      if(didAuthenticate) {
        await showDialog(
          context: context,
          builder: (_) => OrderDoneDialog(voucher: voucher),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
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
                  GestureDetector(
                    onTap: ()=> _chekFingerPrint(context),
                    child: Column(
                      children: [
                        SizedBox(height: 28.h),
                        SvgPicture.asset("assert/image/icons/Finger-print.svg"),
                        SizedBox(height: 20.w),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 42.w),
                    child: Row(
                      children: [
                        const Expanded(child: Divider(thickness: 3)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child:  Text("Atau", style: TypoSty.caption2),
                        ),
                        const Expanded(child: Divider(thickness: 3)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(context: context, builder: (_)=> VPinDialog(voucher: voucher));
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
    );
  }
}
