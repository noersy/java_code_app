import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/providers/profile_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/history_screen.dart';
import 'package:java_code_app/view/orders/ongoing_screen.dart';
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
                bottomLeft: Radius.circular(30.0))),
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
          tabs: [
            AnimatedBuilder(
              animation: ProfileProviders(),
              builder: (context, snapshot) {
                final role = Provider.of<ProfileProviders>(context).isKasir;
                return Tab(
                  child: Text(
                    role ? "Pesanan" : "Sedang Berjalan",
                  ),
                );
              },
            ),
            const Tab(child: Text("Riwayat")),
          ],
        ),
      ),
      body: AnimatedBuilder(
          animation: ProfileProviders(),
          builder: (context, snapshot) {
            final role = Provider.of<ProfileProviders>(context).isKasir;
            return TabBarView(
              controller: _tabController,
              children: role
                  ? [const OrdersScreen(), const OrderHistoryScreen()]
                  : [const OngoingScreen(), const HistoryScreen()],
            );
          }),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: SpaceDims.sp18,
        left: SpaceDims.sp18,
        top: SpaceDims.sp12,
      ),
      child: AnimatedBuilder(
        animation: OrderProviders(),
        builder: (BuildContext context, Widget? child) {
          final List<Map<String, dynamic>> _queue = [
            {
              "id": "1",
              "orders": [
                {
                  "jenis": "makanan",
                  "image": "assert/image/menu/1637916792.png",
                  "harga": "Rp 10.000",
                  "name": "Chicken Katsu",
                  "countOrder": 1,
                  "amount": 99
                }
              ],
              "voucher": {},
            }
          ];

          return SizedBox(
            height: MediaQuery.of(context).size.height - 120,
            child: _queue.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpaceDims.sp12),
                        child: SwitchButton(
                          left: "Antrian",
                          right: "Disiapkan",
                          onChanged: (bool value) {
                            if (value) {
                              _pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                              );
                            } else {
                              _pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp12),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 200,
                        child: PageView(
                          controller: _pageController,
                          children: [
                            SingleChildScrollView(
                              primary: true,
                              child: Column(
                                children: [
                                  for (Map<String, dynamic> item in _queue)
                                    OrdersCard(
                                      onPressed: () => Navigate.toViewOrderKasir(context, dataOrders: item),
                                    ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              primary: true,
                              child: Column(
                                children: [
                                  for (Map<String, dynamic> item in _queue)
                                    OrdersCard(
                                      isActive: true,
                                      onPressed: () => Navigate.toViewOrderKasir(context, dataOrders: item, preparing: true),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assert/image/bg_findlocation.png"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            IconsCs.order_icon,
                            size: 120,
                            color: ColorSty.primary,
                          ),
                          const SizedBox(height: SpaceDims.sp22),
                          Text(
                            "Sudah Pesan?\nLacak pesananmu\ndi sini.",
                            textAlign: TextAlign.center,
                            style: TypoSty.title2,
                          ),
                        ],
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  final String left, right;
  final ValueChanged<bool> onChanged;

  const SwitchButton(
      {Key? key,
      required this.left,
      required this.right,
      required this.onChanged})
      : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: _isActive ? ColorSty.primary : ColorSty.white,
                onPrimary: _isActive ? ColorSty.white : ColorSty.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            onPressed: () {
              setState(() => _isActive = true);
              widget.onChanged(true);
            },
            child: Text(widget.left, style: TypoSty.button),
          ),
        ),
        const SizedBox(width: SpaceDims.sp12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: !_isActive ? ColorSty.primary : ColorSty.white,
                onPrimary: !_isActive ? ColorSty.white : ColorSty.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
            onPressed: () {
              setState(() => _isActive = false);
              widget.onChanged(false);
            },
            child: Text(widget.right, style: TypoSty.button),
          ),
        ),
      ],
    );
  }
}

class OrdersCard extends StatelessWidget {
  final VoidCallback onPressed;
  final bool? isActive;
  const OrdersCard({Key? key, required this.onPressed, this.isActive = false}) : super(key: key);

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
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: isActive! ? Colors.yellow : Colors.blue,
                                ),
                                const SizedBox(width: SpaceDims.sp4),
                                Text(
                                  isActive! ? "Disipakan" : "Dalam Antrean",
                                  style:
                                      TypoSty.mini.copyWith(color:  isActive! ? Colors.yellow : Colors.blue),
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
                      const SizedBox(height: SpaceDims.sp4),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.all(SpaceDims.sp2),
                            child: const Icon(Icons.person, color: Colors.grey),
                            decoration: const BoxDecoration(
                              color: ColorSty.grey60,
                              borderRadius: BorderRadius.all(Radius.circular(30.0))
                            ),
                          ),
                          const SizedBox(width: SpaceDims.sp12),
                          const Text("Fajar")
                        ],
                      ),
                      const SizedBox(height: SpaceDims.sp4),
                      SizedBox(
                        width: 160,
                        child: Text(
                          "Fried Rice, Chicken Katsu, Es Jeruk",
                          style: TypoSty.caption.copyWith(
                              fontSize: 12.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp8),
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

class HistoryOrderCard extends StatelessWidget {
  final VoidCallback onPressed;
  const HistoryOrderCard({Key? key, required this.onPressed}) : super(key: key);

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
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: SpaceDims.sp4),
                                Text(
                                  "Dalam Antrean",
                                  style:
                                  TypoSty.mini.copyWith(color: Colors.blue),
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
                      const SizedBox(height: SpaceDims.sp4),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.all(SpaceDims.sp2),
                            child: const Icon(Icons.person, color: Colors.grey),
                            decoration: const BoxDecoration(
                                color: ColorSty.grey60,
                                borderRadius: BorderRadius.all(Radius.circular(30.0))
                            ),
                          ),
                          const SizedBox(width: SpaceDims.sp12),
                          const Text("Fajar")
                        ],
                      ),
                      const SizedBox(height: SpaceDims.sp4),
                      SizedBox(
                        width: 160,
                        child: Text(
                          "Fried Rice, Chicken Katsu, Es Jeruk",
                          style: TypoSty.caption.copyWith(
                              fontSize: 12.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp8),
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

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assert/image/bg_findlocation.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(IconsCs.order_icon, size: 120, color: ColorSty.primary),
              const SizedBox(height: SpaceDims.sp22),
              Text("Pesanan selesai\nmuncul di sini.",
                  textAlign: TextAlign.center, style: TypoSty.title2),
              const SizedBox(height: SpaceDims.sp12),
            ],
          )
        ],
      ),
    );
  }
}

