import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class OrderDoneDialog extends StatelessWidget {
  final int? idVoucher;
  final int? discount;
  final int? totalPotong;
  final int totalPay;
  final List<int>? listDiscount;
  final List<Map<String, dynamic>> menu;

  const OrderDoneDialog({
    Key? key,
    this.idVoucher,
    this.discount,
    this.totalPotong,
    this.listDiscount,
    required this.menu,
    required this.totalPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: SizedBox(
          height: 0.555.sh,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 42.h),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assert/image/icons/img-pesanan-disiapkan.svg",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: SizedBox(
                    width: 190.w,
                    child: Column(
                      children: [
                        Text(
                          "Pesanan Sedang Disiapkan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Kamu dapat melacak pesananmu di fitur ',
                            style: TypoSty.caption2.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Pesanan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                          ),
                          onPressed: null,//() => _submit(context, voucher: voucher),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Oke"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(context, {LVoucher? voucher}) async{
    // await Provider.of<OrderProviders>(context, listen: false).submitOrder(voucher);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
