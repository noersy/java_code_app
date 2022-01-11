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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return SingleChildScrollView(
        child: widget.result.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SpaceDims.sp22.h),
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
                          style:
                              TypoSty.title.copyWith(color: ColorSty.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SpaceDims.sp22),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 10.h),
                        const CardCoupon(),
                        const CardCoupon(),
                        const CardCoupon(),
                      ],
                    ),
                  ),
                  const SizedBox(height: SpaceDims.sp32),
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
                    height: MediaQuery.of(context).size.height - 200,
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
      );
    });
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
