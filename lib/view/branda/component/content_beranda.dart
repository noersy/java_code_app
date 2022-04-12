import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/listpromo.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/card/card_coupun.dart';
import 'package:java_code_app/widget/button/label_button.dart';
import 'package:java_code_app/widget/list/listmenu.dart';
import 'package:provider/provider.dart';

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
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollManu = ScrollController();
  final ScrollController _scrollPromo = ScrollController();
  final Duration _duration = const Duration(milliseconds: 500);
  int _sIndex = 0;

  @override
  bool get wantKeepAlive => true;

  _setAll() {
    setState(() => _sIndex = 0);
    final min = _scrollController.position.minScrollExtent;
    final minMenu = _scrollManu.position.minScrollExtent;
    _scrollController.animateTo(min, duration: _duration, curve: Curves.ease);
    _scrollManu.animateTo(minMenu, duration: _duration, curve: Curves.ease);
    // _pageController.animateToPage(0, duration: _duration, curve: Curves.ease);
  }

  _setMakanan() {
    setState(() => _sIndex = 1);
    final possition = _scrollManu.position.maxScrollExtent / 2;
    _scrollManu.animateTo(possition, duration: _duration, curve: Curves.ease);
    // _pageController.animateToPage(1, duration: _duration, curve: Curves.ease);
  }

  _setMenuman() {
    setState(() => _sIndex = 2);
    final max = _scrollController.position.maxScrollExtent;
    final maxMenu = _scrollManu.position.maxScrollExtent;
    _scrollController.animateTo(max, duration: _duration, curve: Curves.ease);
    _scrollManu.animateTo(maxMenu, duration: _duration, curve: Curves.ease);
    // _pageController.animateToPage(2, duration: _duration, curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);

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
                Provider.of<LangProviders>(context).lang.beranda!.promoTersedia,
                style: TypoSty.title,
              ),
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp22),
        SingleChildScrollView(
          controller: _scrollPromo,
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
          primary: false,
          child: Row(
            children: [
              const SizedBox(width: SpaceDims.sp12),
              LabelButton(
                color: _sIndex == 0 ? ColorSty.black : ColorSty.primary,
                onPressed: _setAll,
                title:
                    Provider.of<LangProviders>(context).lang.beranda!.semuaMenu,
                icon: Icons.list,
              ),
              LabelButton(
                color: _sIndex == 1 ? ColorSty.black : ColorSty.primary,
                onPressed: _setMakanan,
                title: Provider.of<LangProviders>(context)
                    .lang
                    .beranda!
                    .semuaMakanan,
                svgPicture: SvgPicture.asset(
                  "assert/image/icons/ep_food.svg",
                  color: ColorSty.white,
                  width: 24,
                ),
              ),
              LabelButton(
                color: _sIndex == 2 ? ColorSty.black : ColorSty.primary,
                onPressed: _setMenuman,
                title: Provider.of<LangProviders>(context)
                    .lang
                    .beranda!
                    .semuaMinuman,
                icon: IconsCs.coffee,
              ),
            ],
          ),
        ),
        GestureDetector(
          onHorizontalDragEnd: (DragEndDetails detail) {
            if (detail.velocity.pixelsPerSecond.dx < 0) {
              if (_sIndex == 1) _setMenuman();
              if (_sIndex == 0) _setMakanan();
            } else {
              if (_sIndex == 1) _setAll();
              if (_sIndex == 2) _setMakanan();
            }
          },
          child: SingleChildScrollView(
            controller: _scrollManu,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ListMenu(
                      type: "makanan",
                      title: Provider.of<LangProviders>(context)
                          .lang
                          .beranda!
                          .semuaMakanan,
                      data: widget.data,
                    ),
                    ListMenu(
                      type: "minuman",
                      title: Provider.of<LangProviders>(context)
                          .lang
                          .beranda!
                          .semuaMinuman,
                      data: widget.data,
                    ),
                    const SizedBox(
                      height: 74,
                    )
                  ],
                ),
                Column(
                  children: [
                    ListMenu(
                      key: const Key("menu-2"),
                      type: "makanan",
                      title: Provider.of<LangProviders>(context)
                          .lang
                          .beranda!
                          .semuaMakanan,
                      data: widget.data,
                    ),
                    const SizedBox(height: 74)
                  ],
                ),
                Column(
                  children: [
                    ListMenu(
                      key: const Key("menu-3"),
                      type: "minuman",
                      title: Provider.of<LangProviders>(context)
                          .lang
                          .beranda!
                          .semuaMinuman,
                      data: widget.data,
                    ),
                    const SizedBox(height: 74)
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 70)
      ],
    );
  }
}
