import 'dart:async';

import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/view/branda/component/beranda_skeleton.dart';
import 'package:java_code_app/view/branda/component/content_beranda.dart';
import 'package:java_code_app/view/branda/component/search_screen.dart';
import 'package:java_code_app/view/branda/widget/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  static String result = "";
  final TextEditingController editingController = TextEditingController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 0);
    OrderProviders orderProvider =
        Provider.of<OrderProviders>(context, listen: false);

    await orderProvider.getMenuList(context);
    await orderProvider.getListPromo(context);
    await orderProvider.getListDisCount(context);

    if (mounted) {
      Timer(_duration, () {
        _refreshController.refreshCompleted();
      });
    }
  }

  Future<void> _onSearchMenu() async {
    if (mounted) setState(() => _loading = true);
    var _duration = const Duration(seconds: 0);

    await Provider.of<OrderProviders>(context, listen: false)
        .getMenuList(context);

    if (mounted) {
      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          //  Scaffold(
          //   backgroundColor: Colors.white,
          //   appBar: null,
          // appBar: isOnSearch
          //     ? CostumeAppBar(
          //         costumeTitle: SearchBar(
          //           editingController: editingController,
          //           onTap: () {
          //             toggleOnSearch(status: true);
          //           },
          //           onSearch: (value) {
          //             setState(() {
          //               result = value;
          //             });
          //             if (result.isNotEmpty) toggleOnSearch(status: false);
          //             _onSearchMenu();
          //           },
          //         ),
          //         title: '',
          //       )
          //     : null,
          // body:
          SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: AnimatedBuilder(
          animation: OrderProviders(),
          builder: (_, snapshot) {
            final provider = Provider.of<OrderProviders>(context);
            final menuList = provider.listMenu;
            final listPromo = provider.listPromo;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(0, 2.0),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: SearchBar(
                      editingController: editingController,
                      onSearch: (value) {
                        result = value;
                        setState(() {
                          _onSearchMenu();
                        });
                      },
                    ),
                  ),
                  menuList != null && !_loading
                      ? result.isEmpty
                          ? ContentBeranda(
                              data: menuList,
                              listPromo: listPromo,
                            )
                          : SearchScreen(
                              result: result,
                              data: menuList,
                            )
                      : const BerandaSkeleton(),
                ],
              ),
            );
          },
        ),
      ),
      // ),
    );
  }
}
