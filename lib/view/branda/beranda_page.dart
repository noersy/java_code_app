import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/component/beranda_skeleton.dart';
import 'package:java_code_app/view/branda/component/content_beranda.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  static List result = [];

  final TextEditingController _editingController = TextEditingController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool _loading = false;

  Future<void> _onRefresh() async {
    if(mounted) setState(() => _loading = true);
    var _duration = const Duration(seconds: 0);

    await Provider.of<OrderProviders>(context, listen: false).getMenuList();
    await Provider.of<OrderProviders>(context, listen: false).getListPromo();

    Provider.of<OrderProviders>(context, listen: false).getListDisCount();

    if (mounted) {
      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MainSilverAppBar(
        title: SizedBox(
          height: 42.0,
          child: TextFormField(
            controller: _editingController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: "Pencarian",
              hintStyle: TypoSty.captionSemiBold.copyWith(color: ColorSty.grey),
              prefixIcon: const Icon(
                IconsCs.search,
                color: ColorSty.primary,
              ),
              contentPadding: const EdgeInsets.only(
                left: 53,
                right: SpaceDims.sp12,
                top: SpaceDims.sp12,
                bottom: SpaceDims.sp8,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        floating: true,
        pinned: true,
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: AnimatedBuilder(
              animation: OrderProviders(),
              builder: (_, snapshot) {
                final provider = Provider.of<OrderProviders>(context);
                final menuList = provider.listMenu;
                final listPromo = provider.listPromo;

                if (menuList != null && !_loading) {
                  return SingleChildScrollView(
                    child: ContentBeranda(
                      result: result,
                      data: menuList,
                      listPromo: listPromo,
                    ),
                  );
                }

                return const SingleChildScrollView(child: BerandaSkeleton());
              }),
        ),
      ),
    );
  }
}



