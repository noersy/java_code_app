import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/models/listvoucher.dart';
import 'package:java_code_app/singletons/user_instance.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VPinDialog extends StatefulWidget {
  final LVoucher? voucher;
  final String? title;
  final bool? giveString;
  final ValueChanged<Object>? onComplete;

  const VPinDialog({
    Key? key,
    this.voucher,
    this.title = "Verifikasi Pesanan",
    this.onComplete, this.giveString = false,
  }) : super(key: key);

  @override
  State<VPinDialog> createState() => _VPinDialogState();
}

class _VPinDialogState extends State<VPinDialog> {
  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();
  bool _isHide = true;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: ColorSty.primary),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.h)),
      child: SizedBox(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text(
                widget.voucher != null
                    ? "Verifikasi Pesanan"
                    : widget.title ?? "",
                style: TypoSty.title.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Masukan kode Pin",
                style: TypoSty.caption2.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 18,
                  right: 18,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PinPut(
                        fieldsCount: 6,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        obscureText: _isHide ? "*" : null,
                        textStyle: TypoSty.button,
                        eachFieldConstraints: const BoxConstraints(
                          minHeight: 30.0,
                          minWidth: 30.0,
                        ),
                        onSubmit: (_) {
                          final user = UserInstance.getInstance().user;
                          if (user == null) return;
                          final correct = user.data.pin == _pinPutController.text;
                          Navigator.pop(context, correct);

                          if (widget.onComplete != null && !widget.giveString!) {
                            widget.onComplete!(correct);

                            if(!correct){
                              showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: const SizedBox(
                                    height: 90.0,
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Pin Salah"),
                                    ),
                                  ),
                                ),
                              );
                            }

                          }else if(widget.giveString!){
                            widget.onComplete!(_pinPutController.text);
                          }
                          Navigator.pop(context);
                        },
                        separator: Padding(
                          padding: const EdgeInsets.all(SpaceDims.sp4),
                          child: SizedBox(
                            width: 8.w,
                            height: 2,
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                color: ColorSty.grey,
                              ),
                            ),
                          ),
                        ),
                        separatorPositions: const [2, 4],
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: ColorSty.primary.withOpacity(.5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: SpaceDims.sp12),
                      child: GestureDetector(
                        onTap: () => setState(() => _isHide = !_isHide),
                        child: const Icon(Icons.visibility_off,
                            color: ColorSty.grey),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
