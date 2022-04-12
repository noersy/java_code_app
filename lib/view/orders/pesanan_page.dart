import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/component/history_screen.dart';
import 'package:java_code_app/view/orders/component/ongoings_screen.dart';
import 'package:provider/provider.dart';

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
        ),
        backgroundColor: ColorSty.white,
        title: AnimatedBuilder(
            animation: LangProviders(),
            builder: (context, snapshot) {
              final lang = context.watch<LangProviders>().lang;
              return TabBar(
                controller: _tabController,
                indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 8.0,
                ),
                labelPadding: const EdgeInsets.all(0),
                labelStyle: TypoSty.title.copyWith(fontSize: 16.sp),
                indicatorColor: ColorSty.primary,
                unselectedLabelColor: ColorSty.black,
                labelColor: ColorSty.primary,
                tabs: [
                  Tab(child: Text(lang.pesanan.tap)),
                  Tab(child: Text(lang.pesanan.tap2)),
                ],
              );
            }),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [OngoingScreen(), HistoryScreen()],
      ),
    );
  }
}
