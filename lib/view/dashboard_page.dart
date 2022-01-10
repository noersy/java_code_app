import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/beranda_page.dart';
import 'package:java_code_app/view/pesanan/pesanan_page.dart';
import 'package:java_code_app/view/profile/profile_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _bottomNavBarSelectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorSty.white,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          elevation: 10,
          backgroundColor: ColorSty.black60,
          unselectedItemColor: ColorSty.white.withOpacity(0.8),
          selectedItemColor: ColorSty.white,
          selectedLabelStyle: TypoSty.button2,
          unselectedLabelStyle: TypoSty.button2.copyWith(fontWeight: FontWeight.normal),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(IconsCs.beranda, size: 28.0),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Stack(children: [
                const Icon(IconsCs.pesanan, size: 32.0),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: AnimatedBuilder(
                    animation: OrderProviders(),
                    builder: (BuildContext context, Widget? child) {
                       int _orderOngoing = Provider.of<OrderProviders>(context).orderProgress.length;
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
                          child: Text(
                            "$_orderOngoing",
                            style: TypoSty.button.copyWith(
                              color: ColorSty.white,
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ]),
              label: 'Pesanan',
            ),
            const BottomNavigationBarItem(
              icon: Icon(IconsCs.profil, size: 28.0),
              label: 'Profil',
            ),
          ],
          currentIndex: _bottomNavBarSelectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          BerandaPage(),
          PesananPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: OrderProviders(),
        builder: (BuildContext context, Widget? child) {
          final _order = Provider.of<OrderProviders>(context).checkOrder.length;
          if (_order > 0) {
            return FloatingActionButton(
              backgroundColor: ColorSty.primary,
              onPressed: () {
                Navigate.toChekOut(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 3.0),
                child: Icon(IconsCs.shopingbag_icon),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

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
}
