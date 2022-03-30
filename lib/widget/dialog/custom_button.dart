import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/widget/dialog/custom_text.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  String? label;
  Function? onTap;
  double? width, height;
  Color? backgroundColor;
  Color? fontColor;

  CustomButton({
    Key? key,
    this.label,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor = ColorSty.primary,
    this.fontColor,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onTap!();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.width ?? 100,
        ),
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            color: widget.backgroundColor ?? ColorSty.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
            border: Border.all(
              width: 1,
              color: ColorSty.primary,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: widget.label,
                isBold: true,
                color: widget.fontColor ?? Colors.white,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
