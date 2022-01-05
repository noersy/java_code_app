import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

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
    return SilverAppBar(
      tabs: true,
      title: ScreenUtilInit(
        builder: () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            controller: _tabController,
            indicatorPadding: const EdgeInsets.symmetric(
              horizontal: 50.0,
              vertical: 8.0,
            ),
            labelPadding: const EdgeInsets.all(0),
            labelStyle: TypoSty.title.copyWith(fontSize: 18),
            indicatorColor: ColorSty.primary,
            unselectedLabelColor: ColorSty.black,
            labelColor: ColorSty.primary,
            tabs: const [
              Tab(child: Text("Sedang Berjalan")),
              Tab(child: Text("Riwayat")),
            ],
          ),
        ),
      ),
      floating: true,
      pinned: true,
      body: Container(),
    );
  }
}
