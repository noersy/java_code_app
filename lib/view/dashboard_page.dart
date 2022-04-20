import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:java_code_app/constans/try_api.dart';
import 'package:java_code_app/models/lang.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/beranda_page.dart';
import 'package:java_code_app/view/orders/pesanan_page.dart';
import 'package:java_code_app/view/profile/profile_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  final int indexPage;
  const DashboardPage({
    Key? key,
    this.indexPage = 0,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _bottomNavBarSelectedIndex = 0, _order = 0;
  final PageController _pageController = PageController();

  _onItemTapped(index) {
    if (index != _bottomNavBarSelectedIndex) {
      if (index != 3) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        setState(() {
          _bottomNavBarSelectedIndex = index;
        });
      }
    }
  }

  getData() async {
    await checkConnection().then((value) async {
      if (value) {
        OrderProviders orderProviders =
            Provider.of<OrderProviders>(context, listen: false);

        await orderProviders.getMenuList(context);
        await orderProviders.getListPromo(context);
        await orderProviders.getListDisCount(context);
        if (_bottomNavBarSelectedIndex != 1) {
          await orderProviders.getListOrder(context);
        }

        _pageController.animateToPage(
          widget.indexPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        Provider.of<OrderProviders>(context, listen: false).setNetworkError(
          true,
          context: context,
          title: 'Koneksi anda terputus',
          then: () => getData(),
        );
      }
    });
  }

  @override
  void initState() {
    _bottomNavBarSelectedIndex = widget.indexPage;
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorSty.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          BerandaPage(),
          PesananPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: AnimatedBuilder(
            animation: LangProviders(),
            builder: (context, snapshot) {
              Lang _lang = Provider.of<LangProviders>(context).lang;
              return BottomNavigationBar(
                elevation: 10,
                backgroundColor: ColorSty.black60,
                unselectedItemColor: ColorSty.white.withOpacity(0.8),
                selectedItemColor: ColorSty.white,
                selectedLabelStyle: TypoSty.button2,
                unselectedLabelStyle:
                    TypoSty.button2.copyWith(fontWeight: FontWeight.normal),
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(IconsCs.beranda, size: 28.0),
                    label: _lang.bottomNav.nav1,
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(children: [
                      const Padding(
                        padding: EdgeInsets.only(right: SpaceDims.sp4),
                        child: Icon(IconsCs.pesanan, size: 32.0),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: AnimatedBuilder(
                          animation: OrderProviders(),
                          builder: (BuildContext context, Widget? child) {
                            int _orderOngoing =
                                Provider.of<OrderProviders>(context)
                                    .listOrders
                                    .length;
                            // print(Provider.of<OrderProvider>(context).orderProgress.first);
                            if (_orderOngoing > 0) {
                              return Container(
                                height: 20,
                                width: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorSty.primary,
                                  borderRadius: BorderRadius.circular(100.0),
                                  border: Border.all(color: ColorSty.white),
                                ),
                                padding: const EdgeInsets.all(3),
                                child: AutoSizeText(
                                  "$_orderOngoing",
                                  style: TypoSty.button.copyWith(
                                    color: ColorSty.white,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  minFontSize: 0,
                                  stepGranularity: 0.1,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      )
                    ]),
                    label: _lang.bottomNav.nav2,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(IconsCs.profil, size: 28.0),
                    label: _lang.bottomNav.nav3,
                  ),
                ],
                currentIndex: _bottomNavBarSelectedIndex,
                onTap: _onItemTapped,
              );
            }),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: OrderProviders(),
        builder: (BuildContext context, Widget? child) {
          _order = Provider.of<OrderProviders>(context).checkOrder.length;
          if (_order > 0) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: _bottomNavBarSelectedIndex == 1 ? 40 : 0),
              child: FloatingActionButton(
                backgroundColor: ColorSty.primary,
                onPressed: () {
                  Navigate.toChekOut(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 3.0),
                  child: Icon(IconsCs.shopingbag),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
