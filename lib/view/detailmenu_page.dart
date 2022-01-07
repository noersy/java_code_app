import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/tools/random_string.dart';
import 'package:java_code_app/widget/addorder_button.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/detailmenu_sheet.dart';
import 'package:java_code_app/widget/labellevel_selection.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:provider/provider.dart';

class DetailMenu extends StatefulWidget {
  final Map<String, dynamic> data;
  final int countOrder;

  const DetailMenu({
    Key? key,
    required this.data,
    required this.countOrder,
  }) : super(key: key);

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  late final String urlImage, name, harga;
  late final int amount;
  int _jumlahOrder = 0;
  String _selectedLevel = "1";
  List<String> _selectedTopping = ["Mozarella"];

  @override
  void initState() {
    _jumlahOrder = widget.countOrder;
    name = widget.data["name"] ?? "";
    urlImage = widget.data["image"] ?? "";
    harga = widget.data["harga"] ?? "";
    amount = widget.data["amount"] ?? 0;

    super.initState();
  }

  final List<String> _listLevel = ["1", "2", "3"];
  final List<String> _listTopping = ["Mozarella", "Sausagge", "Dimsum"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        title: 'Detail Menu',
        back: true,
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const SizedBox(height: SpaceDims.sp24),
            SizedBox(
              width: 234.0,
              height: 182.4,
              child: Image.asset(urlImage),
            ),
            const SizedBox(height: SpaceDims.sp24),
            Container(
              decoration: BoxDecoration(
                color: ColorSty.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -1),
                    color: ColorSty.grey.withOpacity(0.01),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SpaceDims.sp24,
                      left: SpaceDims.sp24,
                      right: SpaceDims.sp24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TypoSty.title.copyWith(
                            color: ColorSty.primary,
                          ),
                        ),
                        AddOrderButton(
                          initCount: _jumlahOrder,
                          onChange: (int value) {
                            setState(() => _jumlahOrder = value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: SpaceDims.sp12,
                      left: SpaceDims.sp24,
                      right: 108.0,
                    ),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: SpaceDims.sp24,
                      right: SpaceDims.sp24,
                    ),
                    child: Column(
                      children: [
                        TileListDMenu(
                          icon: IconsCs.bi_cash_coin,
                          title: "Harga",
                          prefix: harga,
                          onPressed: () {},
                        ),
                        TileListDMenu(
                          prefixIcon: true,
                          icon: IconsCs.fire,
                          title: "Level",
                          prefix: _selectedLevel,
                          onPressed: () => _showDialogLevel(_listLevel),
                        ),
                        TileListDMenu(
                            prefixIcon: true,
                            icon: IconsCs.topping_icon,
                            prefixCostume: RichText(
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  style: TypoSty.captionSemiBold
                                      .copyWith(color: ColorSty.black),
                                  text: _selectedTopping.isEmpty
                                      ? _listTopping[0]
                                      : "",
                                  children: [
                                    for (final item in _selectedTopping)
                                      TextSpan(
                                        text: item + " ",
                                        style: TypoSty.captionSemiBold
                                            .copyWith(color: ColorSty.black),
                                      )
                                  ]),
                            ),
                            title: "Topping",
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                context: context,
                                builder: (_) => BottomSheetDetailMenu(
                                  title: "Pilih Toping",
                                  content: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (String item in _listTopping)
                                          LabelToppingSelection(
                                            title: item,
                                            initial: _selectedTopping
                                                .where((e) => e == item)
                                                .isNotEmpty,
                                            onSelection: (value) {
                                              if (_selectedTopping
                                                  .where((e) => e == value)
                                                  .isNotEmpty) {
                                                setState(() => _selectedTopping
                                                    .remove(value));
                                              } else {
                                                setState(() => _selectedTopping
                                                    .add(value));
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        TileListDMenu(
                          prefixIcon: true,
                          icon: IconsCs.note_icon,
                          title: "Catatan",
                          prefix: "Lorem Ipsum sit aaasss",
                          onPressed: () => showModalBottomSheet(
                            isScrollControlled: true,
                            barrierColor: ColorSty.grey.withOpacity(0.2),
                            context: context,
                            builder: (BuildContext context) =>
                                BottomSheetDetailMenu(
                              title: "Buat Catatan",
                              content: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 100,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      minimumSize: const Size(25.0, 25.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                    child: const Icon(Icons.check, size: 26.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: SpaceDims.sp12),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<OrderProvider>(context, listen: false)
                                .addOrder({
                              "id": getRandomString(10),
                              "jenis": widget.data["jenis"],
                              "image": widget.data["image"],
                              "harga": widget.data["harga"],
                              "amount": widget.data["amount"],
                              "name": widget.data["name"],
                              "countOrder": _jumlahOrder,
                            });

                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: SpaceDims.sp2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tambahkan Ke Pesanan",
                                style: TypoSty.button,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialogLevel(List<String> _listLevel) async {
    String _value = "1";
    _value = await showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: ColorSty.grey.withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (_, setState) {
            return BottomSheetDetailMenu(
              title: "Pilih Level",
              content: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (String item in _listLevel)
                      LabelLevelSelection(
                        title: item,
                        isSelected: item == _selectedLevel,
                        onSelection: (String value) {
                          setState(() => _selectedLevel = value);
                          Navigator.of(context).pop(value);
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    setState(() => _selectedLevel = _value);
  }
}

class LabelToppingSelection extends StatefulWidget {
  final String title;
  final bool? initial;
  final ValueChanged<String> onSelection;

  const LabelToppingSelection({
    Key? key,
    required this.title,
    required this.onSelection,
    this.initial,
  }) : super(key: key);

  @override
  State<LabelToppingSelection> createState() => _LabelToppingSelectionState();
}

class _LabelToppingSelectionState extends State<LabelToppingSelection> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.initial ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: SpaceDims.sp20,
        horizontal: SpaceDims.sp4,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: _isSelected ? ColorSty.primary : ColorSty.white,
          primary: !_isSelected ? ColorSty.primary : ColorSty.white,
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorSty.primary),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          setState(() => _isSelected = !_isSelected);
          widget.onSelection(widget.title);
        },
        child: Row(
          children: [
            const SizedBox(width: SpaceDims.sp4),
            Text(widget.title),
            const SizedBox(width: SpaceDims.sp4),
            if (_isSelected) const Icon(Icons.check, size: 18.0),
          ],
        ),
      ),
    );
  }
}
