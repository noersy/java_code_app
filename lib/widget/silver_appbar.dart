import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';

class SilverAppBar extends StatelessWidget {
  final Widget body;
  final Widget title;
  final bool pinned, floating;

  const SilverAppBar({
    Key? key,
    required this.title,
    required this.body,
    required this.pinned,
    required this.floating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        body: body,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 4,
              backgroundColor: ColorSty.white,
              iconTheme: const IconThemeData(color: ColorSty.primary),
              title: title,
              pinned: pinned,
              floating: floating,
              forceElevated: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}
