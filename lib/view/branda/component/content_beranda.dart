import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/listpromo.dart';
import 'package:java_code_app/models/listdiscount.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/component/search_screen.dart';
import 'package:java_code_app/widget/card_coupun.dart';
import 'package:java_code_app/widget/label_button.dart';
import 'package:java_code_app/widget/listmenu.dart';

class ContentBeranda extends StatefulWidget {
  final MenuList data;
  final List<Promo> listPromo;

  const ContentBeranda({
    Key? key,
    required this.data,
    required this.listPromo,
  }) : super(key: key);

  @override
  State<ContentBeranda> createState() => _ContentBerandaState();
}

class _ContentBerandaState extends State<ContentBeranda>
    with AutomaticKeepAliveClientMixin<ContentBeranda> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollPromo = ScrollController();
  final Duration _duration = const Duration(milliseconds: 500);
  int _sIndex = 0;

  @override
  bool get wantKeepAlive => true;

  _setAll() {
    setState(() => _sIndex = 0);
    final max = _scrollController.position.minScrollExtent;
    _scrollController.animateTo(max, duration: _duration, curve: Curves.ease);
    _pageController.animateToPage(0, duration: _duration, curve: Curves.ease);
  }

  _setMakanan() {
    setState(() => _sIndex = 1);
    _pageController.animateToPage(1, duration: _duration, curve: Curves.ease);
  }

  _setMenuman() {
    setState(() => _sIndex = 2);
    final max = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(max, duration: _duration, curve: Curves.ease);
    _pageController.animateToPage(2, duration: _duration, curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: SpaceDims.sp22),
          Padding(
            padding: const EdgeInsets.only(left: SpaceDims.sp24),
            child: Row(
              children: [
                const Icon(
                  IconsCs.coupon,
                  color: ColorSty.primary,
                  size: 22.0,
                ),
                const SizedBox(width: SpaceDims.sp22),
                Text(
                  "Promo yang Tersedia",
                  style: TypoSty.title,
                ),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp22),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                for (final item in widget.listPromo)
                  CardCoupon(
                    title: item.nama,
                    discount: item.diskon,
                    nominal: item.nominal,
                    police: item.syaratKetentuan,
                  ),
                if (widget.listPromo.isEmpty)
                  const Opacity(
                    opacity: 1,
                    child: CardCoupon(
                      disable: true,
                      color: ColorSty.grey,
                      title: "Belum ada",
                      police: "",
                      discount: 0,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: SpaceDims.sp12),
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: SpaceDims.sp12),
                LabelButton(
                  color: _sIndex == 0 ? ColorSty.black : ColorSty.primary,
                  onPressed: _setAll,
                  title: "Semua Menu",
                  icon: Icons.list,
                ),
                LabelButton(
                  color: _sIndex == 1 ? ColorSty.black : ColorSty.primary,
                  onPressed: _setMakanan,
                  title: "Makanan",
                  svgPicture: SvgPicture.asset(
                    "assert/image/icons/ep_food.svg",
                    color: ColorSty.white,
                    width: 24,
                  ),
                ),
                LabelButton(
                  color: _sIndex == 2 ? ColorSty.black : ColorSty.primary,
                  onPressed: _setMenuman,
                  title: "Minuman",
                  icon: IconsCs.coffee,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 130,
            child: PageView(
              controller: _pageController,
              onPageChanged: (value){
                if(mounted) setState(() => _sIndex = value);
              },
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ListMenu(
                        type: "makanan",
                        title: "Makanan",
                        data: widget.data,
                      ),
                      ListMenu(
                        type: "minuman",
                        title: "Minuman",
                        data: widget.data,
                      ),
                      const SizedBox(height: 30)
                    ],
                  ),
                ),
                Column(
                  children: [
                    ListMenu(
                      type: "makanan",
                      title: "Makanan",
                      data: widget.data,
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
                Column(
                  children: [
                    ListMenu(
                      type: "minuman",
                      title: "Minuman",
                      data: widget.data,
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ],
            ),
          ),
        ],
      );
  }
}
