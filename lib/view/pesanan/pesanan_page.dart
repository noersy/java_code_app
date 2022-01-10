
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
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
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0)
          )
        ),
        backgroundColor: ColorSty.white,
        title: TabBar(
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
    return SingleChildScrollView(
      primary: true,
      child: Padding(
        padding: const EdgeInsets.only(
          right: SpaceDims.sp18,
          left: SpaceDims.sp18,
          top: SpaceDims.sp12,
        ),
        child: AnimatedBuilder(
          animation: OrderProviders(),
          builder: (BuildContext context, Widget? child) {
            final _orderOngoing = Provider.of<OrderProviders>(context).orderProgress;

            return SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: _orderOngoing.isNotEmpty ? Column(
                children: [
                  for(Map<String, dynamic> item in _orderOngoing)
                  OrderMenuCard(
                    onPressed: () => Navigate.toViewOrder(
                      context,
                      dataOrders: item,
                    ),
                    date: "date",
                    harga: item["orders"][0]["harga"],
                    title: item["orders"][0]["image"],
                    urlImage: item["orders"][0]["harga"],
                  ),
                ],
              ) : Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset("assert/image/bg_findlocation.png"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(IconsCs.order_icon, size: 120, color: ColorSty.primary),
                      SizedBox(height: SpaceDims.sp22),
                      Text("Sudah Pesan?\nLacak pesananmu\ndi sini.", textAlign: TextAlign.center, style: TypoSty.title2),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderMenuCard extends StatelessWidget {
  final String urlImage, title, date, harga;
  final VoidCallback onPressed;

  const OrderMenuCard({
    Key? key,
    required this.urlImage,
    required this.title,
    required this.date,
    required this.harga,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(urlImage);

    return Card(
      elevation: 4,
      color: ColorSty.white80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
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
      ),
    );
  }
}

class HistoryScreen extends StatefulWidget {

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _dropdownValue = 'Semua Status';
  final List<String> _item = ["Semua Status", "Selesai", "Dibatalkan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceDims.sp18,
            vertical: SpaceDims.sp14,
          ),
          child: true ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      right: SpaceDims.sp8,
                      left: SpaceDims.sp12,
                      bottom: SpaceDims.sp4,
                      top: SpaceDims.sp4,
                    ),
                    width: 160.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorSty.grey60,
                        border: Border.all(color: ColorSty.primary),
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: DropdownButton<String>(
                      isDense: true,
                      value: _dropdownValue,
                      alignment: Alignment.topCenter,
                      borderRadius: BorderRadius.circular(30.0),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: TypoSty.caption2.copyWith(fontSize: 14.0, fontWeight: FontWeight.w600, color: ColorSty.black),
                      onChanged: (String? newValue) {
                        setState(() => _dropdownValue = newValue!);
                      },
                      items: [
                        for(String item in _item)
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorSty.grey60,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: ColorSty.primary),
                        borderRadius: BorderRadius.circular(30.0)
                      )
                    ),
                    onPressed: null,
                    child: SizedBox(
                      width: 160.0,
                      child: Row(
                        children:  [
                          const SizedBox(width: SpaceDims.sp12),
                          Text("25/12/21 - 30/12/21", style: TypoSty.caption2.copyWith(fontSize: 13.0, fontWeight: FontWeight.w600)),
                          const SizedBox(width: SpaceDims.sp8),
                          const Icon(IconsCs.uiw_date, size: 18.0, color: ColorSty.primary),
                          const SizedBox(width: SpaceDims.sp8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              OrderHistoryCard(onPressed: () {}),
            ],
          ) : SizedBox(
            height: MediaQuery.of(context).size.height - 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assert/image/bg_findlocation.png"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(IconsCs.order_icon, size: 120, color: ColorSty.primary),
                    SizedBox(height: SpaceDims.sp22),
                    Text("Mulai buat pesanan.", textAlign: TextAlign.center, style: TypoSty.title2),
                    SizedBox(height: SpaceDims.sp12),
                    Text("Makanan yang kamu pesan\nakan muncul di sini agar\nkamu bisa menemukan\nmenu favoritmu lagi!.", textAlign: TextAlign.center, style: TypoSty.title2),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal : SpaceDims.sp22, vertical: SpaceDims.sp14),
        decoration: const BoxDecoration(
          color: ColorSty.grey60,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Pesanan", style: TypoSty.title),
            const Text("Rp. 40.000", style: TypoSty.titlePrimary),
          ],
        ),
      ),
    );
  }
}

class OrderHistoryCard extends StatelessWidget {
  final VoidCallback onPressed;

  const OrderHistoryCard({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: ColorSty.white80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 138,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
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
                  padding: const EdgeInsets.only(top: SpaceDims.sp8),
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
                                  Icons.check,
                                  size: 18.0,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: SpaceDims.sp4),
                                Text(
                                  "Selesai",
                                  style:
                                      TypoSty.mini.copyWith(color: Colors.green),
                                ),
                              ],
                            ),
                            Text(
                              "20 Des 2021",
                              style: TypoSty.mini
                                  .copyWith(color: Colors.grey, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp2),
                      Text("Fried Rice, Chicken Katsu", style: TypoSty.title),
                      const SizedBox(height: SpaceDims.sp4),
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
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              primary: ColorSty.white,
                              onPrimary: ColorSty.primary,
                              padding: const EdgeInsets.symmetric(
                                vertical: SpaceDims.sp8,
                                horizontal: SpaceDims.sp12,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: ColorSty.primaryDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Beri Penilaian",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
                            ),
                          ),
                          const SizedBox(width: SpaceDims.sp8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              primary: ColorSty.primary,
                              padding: const EdgeInsets.symmetric(
                                vertical: SpaceDims.sp8,
                                horizontal: SpaceDims.sp12,
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: ColorSty.primaryDark,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Pesan Lagi",
                              style: TypoSty.button.copyWith(fontSize: 11.0),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

