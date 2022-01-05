import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/shadows.dart';
import 'package:java_code_app/thame/spacing.dart';
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
      body: TabBarView(
        controller: _tabController,
        children: const [OngoingScreen(), HistoryScreen()],
      ),
    );
  }
}

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: SpaceDims.sp24,
        left: SpaceDims.sp24,
        top: SpaceDims.sp12,
      ),
      child: Column(
        children: [
          PesananCard(
            onPressed: () => Navigate.toViewOrder(
              context,
              harga: "harga",
              urlImage: "urlImage",
              name: "name",
              amount: 1,
            ),
            urlImage: "urlImage",
            title: " title",
            date: " date",
            harga: "harga",
          ),
          PesananCard(
            onPressed: () {},
            urlImage: "urlImage",
            title: " title",
            date: " date",
            harga: "harga",
          ),
        ],
      ),
    );
  }
}

class PesananCard extends StatelessWidget {
  final String urlImage, title, date, harga;
  final VoidCallback onPressed;

  const PesananCard({
    Key? key,
    required this.urlImage,
    required this.title,
    required this.date,
    required this.harga,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
      decoration: BoxDecoration(
        color: ColorSty.grey90,
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
        boxShadow: ShadowsB.boxShadow2,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(SpaceDims.sp14),
              margin: const EdgeInsets.all(SpaceDims.sp8),
              decoration: BoxDecoration(
                color: ColorSty.grey60,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset("assert/image/menu/1637916792.png"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: SpaceDims.sp18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: SpaceDims.sp4),
                              Text(
                                "Sedang disiapkan",
                                style:
                                    TypoSty.mini.copyWith(color: Colors.orange),
                              ),
                            ],
                          ),
                          Text(
                            "20 Des 2021",
                            style: TypoSty.mini.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpaceDims.sp12),
                    Text("Fried Rice, Chicken Katsu", style: TypoSty.title),
                    const SizedBox(height: SpaceDims.sp12),
                    Row(
                      children: [
                        Text(
                          "Rp 20.000",
                          style: TypoSty.mini.copyWith(
                              fontSize: 14.0, color: ColorSty.primary),
                        ),
                        const SizedBox(width: SpaceDims.sp8),
                        Text(
                          "(3 Menu)",
                          style: TypoSty.mini.copyWith(
                            fontSize: 12.0,
                            color: ColorSty.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
