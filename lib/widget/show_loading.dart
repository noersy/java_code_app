import 'package:flutter/material.dart';
import 'package:java_code_app/theme/colors.dart';

Future<void> showLoading(BuildContext context) async {
  showDialog<dynamic>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      dialogContext = context;
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: circleLoading(context),
          ),
        ),
      );
    },
  );
}

Future<void> hideLoading(BuildContext context) async {
  Navigator.pop(context);
}

circleLoading(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  return Center(
    child: SizedBox(
      height: width * 0.1,
      width: width * 0.1,
      child: CircularProgressIndicator(
        strokeWidth: width * 0.005,
        valueColor: const AlwaysStoppedAnimation<Color>(
          ColorSty.primary,
        ),
      ),
    ),
  );
}
