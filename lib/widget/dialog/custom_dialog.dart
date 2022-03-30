import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/widget/dialog/custom_button.dart';

import 'custom_text.dart';

showError(
  BuildContext context,
  String body, {
  Function? onClose,
  String? title,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.7),
                offset: const Offset(0, 0),
                blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: CustomText(
                text: body,
                useMaxline: false,
                align: TextAlign.center,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Material(
              child: CustomButton(
                label: 'Oke',
                onTap: () {
                  Navigator.pop(context);
                  if (onClose != null) {
                    onClose();
                  }
                },
                width: 100,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

showValidation(
  BuildContext context, {
  String? bodyText,
  Function? onClose,
  Function? onYes,
  String? titleText,
  String? labelYes,
  String? labelClose,
  Widget? body,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleText != null) const SizedBox(height: 10),
            if (titleText != null)
              CustomText(
                text: titleText,
                useMaxline: false,
                maxLines: 5,
                align: TextAlign.center,
                isOverflow: false,
                fontSize: 18,
                isBold: true,
              ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: body ??
                      CustomText(
                        text: bodyText ?? 'Lorem Ipsum',
                        useMaxline: false,
                        maxLines: 5,
                        align: TextAlign.center,
                        isOverflow: false,
                        fontSize: 18,
                      ),
                ),
                // const Icon(
                //   Icons.warning_amber_outlined,
                //   size: 50,
                //   color: ColorSty.primary,
                // ),
                // const SizedBox(width: 10),
                // Expanded(
                //   child: CustomText(
                //     text: 'Apakah Anda yakin ingin membatalkan pesanan ini?',
                //     useMaxline: false,
                //     maxLines: 5,
                //     align: TextAlign.start,
                //     isOverflow: false,
                //     fontSize: 16,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  child: CustomButton(
                    label: labelClose ?? 'Tutup',
                    onTap: () => onClose!(),
                    backgroundColor: Colors.white,
                    fontColor: ColorSty.primary,
                  ),
                ),
                Material(
                  child: CustomButton(
                    label: labelYes ?? 'Iya',
                    onTap: () => onYes!(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
