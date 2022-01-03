import 'package:flutter/material.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/view/brenda_page.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconsCs.beranda, size: 28.0),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsCs.pesanan, size: 32.0),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsCs.profil, size: 28.0),
            label: 'Profil',
          ),
        ],
        currentIndex: _bottomNavBarSelectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:   const [
          BerandaPage(),
          Text("2"),
          Text("3"),
        ],
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

      // if (index == 2) {
      //   showModalBottomSheet(
      //     context: context,
      //     builder: (BuildContext context) => UserBottomSheetDialog(
      //       ctx: context,
      //     ),
      //   );
      // }
    }
  }
}



