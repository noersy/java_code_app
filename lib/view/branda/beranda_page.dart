import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/card_coupun.dart';
import 'package:java_code_app/widget/label_button.dart';
import 'package:java_code_app/widget/listmenu.dart';
import 'package:java_code_app/widget/menuberanda_card.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({Key? key}) : super(key: key);

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final TextEditingController _controller = TextEditingController();
  List result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MainSilverAppBar(
        title: SizedBox(
          height: 42.0,
          child: TextFormField(
            controller: _controller,
            onChanged: (value) {
              result = (datafakeMakanan + datafakeMinuman)
                  .where((element) =>
                      element["name"].contains(value) && value.isNotEmpty)
                  .toList();

              setState(() {});
            },
            decoration: InputDecoration(
              isDense: true,
              hintText: "Pencarian",
              hintStyle: TypoSty.captionSemiBold.copyWith(color: ColorSty.grey),
              prefixIcon: const Icon(
                IconsCs.search,
                color: ColorSty.primary,
              ),
              contentPadding: const EdgeInsets.only(
                left: 53,
                right: SpaceDims.sp12,
                top: SpaceDims.sp12,
                bottom: SpaceDims.sp8,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ColorSty.primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ),
        floating: true,
        pinned: true,
        body: ContentBeranda(result: result),
      ),
    );
  }
}

class ContentBeranda extends StatefulWidget {
  final List result;

  const ContentBeranda({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  State<ContentBeranda> createState() => _ContentBerandaState();
}

class _ContentBerandaState extends State<ContentBeranda> {
  int _selectedIndex = 0;
  final ScrollController _controller = ScrollController();
  final PageController _pageController = PageController();
  final Duration _duration = const Duration(milliseconds: 500);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool _loading = false;

  Future<void> _onRefresh() async {
    var _duration = const Duration(seconds: 3);

    if (mounted) {
      setState(() => _loading = true);
      Timer(_duration, () {
        setState(() => _loading = false);
        _refreshController.refreshCompleted();
      });
    }
  }

  @override
  void initState() {
    // Timer(const Duration(seconds: 1), () {
    //   setState(() => _loading = false);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: widget.result.isEmpty
            ? _loading
                ? const BerandaSkeleton()
                : Column(
                    mainAxisSize: MainAxisSize.min,
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
                          children: const [
                            SizedBox(width: 10),
                            CardCoupon(),
                            CardCoupon(),
                            CardCoupon(),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp12),
                      SingleChildScrollView(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: SpaceDims.sp12),
                            LabelButton(
                              color: _selectedIndex == 0
                                  ? ColorSty.black
                                  : ColorSty.primary,
                              onPressed: () {
                                setState(() => _selectedIndex = 0);
                                final max =
                                    _controller.position.minScrollExtent;
                                _controller.animateTo(max,
                                    duration: _duration, curve: Curves.ease);
                                _pageController.animateToPage(0,
                                    duration: _duration, curve: Curves.ease);
                              },
                              title: "Semua Menu",
                              icon: Icons.list,
                            ),
                            LabelButton(
                              color: _selectedIndex == 1
                                  ? ColorSty.black
                                  : ColorSty.primary,
                              onPressed: () {
                                setState(() => _selectedIndex = 1);
                                _pageController.animateToPage(1,
                                    duration: _duration, curve: Curves.ease);
                              },
                              title: "Makanan",
                              svgPicture: SvgPicture.asset(
                                "assert/image/icons/ep_food.svg",
                                color: ColorSty.white,
                                width: 24,
                              ),
                            ),
                            LabelButton(
                              color: _selectedIndex == 2
                                  ? ColorSty.black
                                  : ColorSty.primary,
                              onPressed: () {
                                setState(() => _selectedIndex = 2);
                                final max =
                                    _controller.position.maxScrollExtent;
                                _controller.animateTo(max,
                                    duration: _duration, curve: Curves.ease);
                                _pageController.animateToPage(2,
                                    duration: _duration, curve: Curves.ease);
                              },
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
                          children: [
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: const [
                                  ListMenu(type: "makanan", title: "Makanan"),
                                  ListMenu(type: "minuman", title: "Minuman"),
                                ],
                              ),
                            ),
                            const ListMenu(type: "makanan", title: "Makanan"),
                            const ListMenu(type: "minuman", title: "Minuman"),
                          ],
                        ),
                      ),
                    ],
                  )
            : SearchScreen(result: widget.result),
      ),
    );
  }
}

class BerandaSkeleton extends StatelessWidget {
  const BerandaSkeleton({Key? key}) : super(key: key);

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
              Container(
                height: 158.0,
                width: 282.0,
                padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SkeletonText(height: 26.0)),
                          const SizedBox(width: SpaceDims.sp12),
                          Text(
                            "%",
                            style: TypoSty.heading.copyWith(
                              fontSize: 36.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 1
                                ..color = ColorSty.white,
                            ),
                          ),
                        ],
                      ),
                      const SkeletonText(height: 22.0)
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorSty.primary,
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      ColorSty.primary.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('assert/image/bg_coupon_card.png'),
                  ),
                ),
              ),
              Container(
                height: 158.0,
                width: 260.0,
                padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
                  child: Skeleton(
                      height: 120, borderRadius: BorderRadius.circular(7.0)),
                ),
                decoration: BoxDecoration(
                  color: ColorSty.primary,
                  borderRadius: BorderRadius.circular(7.0),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      ColorSty.primary.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('assert/image/bg_coupon_card.png'),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: SpaceDims.sp12),
              LabelButton(
                color: ColorSty.black,
                onPressed: () {},
                title: "Semua Menu",
                icon: Icons.list,
              ),
              LabelButton(
                color: ColorSty.primary,
                onPressed: () {},
                title: "Makanan",
                svgPicture: SvgPicture.asset(
                  "assert/image/icons/ep_food.svg",
                  color: ColorSty.white,
                  width: 24,
                ),
              ),
              LabelButton(
                color: ColorSty.primary,
                onPressed: () {},
                title: "Minuman",
                icon: IconsCs.coffee,
              ),
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: SpaceDims.sp22),
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assert/image/icons/ep_food.svg",
                    height: 22,
                  ),
                  const SizedBox(width: SpaceDims.sp4),
                  Text(
                    "Makanan",
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDims.sp12),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpaceDims.sp12,
                            vertical: SpaceDims.sp2),
                        child: Card(
                          elevation: 4,
                          color: ColorSty.white80,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 74,
                                  width: 74,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(SpaceDims.sp4),
                                    child: Skeleton(
                                        height: 100,
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorSty.grey60,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                const SizedBox(width: SpaceDims.sp8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SkeletonText(height: 12.0),
                                    const SkeletonText(height: 12.0),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.playlist_add_check,
                                          color: ColorSty.primary,
                                        ),
                                        SizedBox(width: SpaceDims.sp4),
                                        SkeletonText(height: 12.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpaceDims.sp12,
                            vertical: SpaceDims.sp2),
                        child: Card(
                          elevation: 4,
                          color: ColorSty.white80,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 74,
                                  width: 74,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(SpaceDims.sp4),
                                    child: Skeleton(
                                        height: 100,
                                        borderRadius:
                                            BorderRadius.circular(7.0)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorSty.grey60,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                const SizedBox(width: SpaceDims.sp8),
                                Expanded(
                                    child: Skeleton(
                                        height: 60.0,
                                        borderRadius:
                                            BorderRadius.circular(7.0))),
                                const SizedBox(width: SpaceDims.sp8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: SpaceDims.sp22),
            Padding(
              padding: const EdgeInsets.only(left: SpaceDims.sp24),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assert/image/icons/ep_coffee.svg",
                    height: 26,
                  ),
                  const SizedBox(width: SpaceDims.sp4),
                  Text(
                    "Minuman",
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDims.sp12),
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SpaceDims.sp12, vertical: SpaceDims.sp2,
                    ),
                    child: Card(
                      elevation: 4,
                      color: ColorSty.white80,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 74,
                              width: 74,
                              child: Padding(
                                padding: const EdgeInsets.all(SpaceDims.sp4),
                                child: Skeleton(height: 100),
                              ),
                              decoration: BoxDecoration(
                                color: ColorSty.grey60,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            const SizedBox(width: SpaceDims.sp8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SkeletonText(height: 12.0),
                                const SkeletonText(height: 12.0),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.playlist_add_check,
                                      color: ColorSty.primary,
                                    ),
                                    SizedBox(width: SpaceDims.sp4),
                                    SkeletonText(height: 12.0),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchScreen extends StatefulWidget {
  final List result;

  const SearchScreen({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                for (Map<String, dynamic> item in widget.result)
                  CardMenu(data: item),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
