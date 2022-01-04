import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:provider/provider.dart';

class DetailMenu extends StatefulWidget {
  final String urlImage, name, harga;
  final int amount;
  final int? count;

  const DetailMenu({
    Key? key,
    required this.urlImage,
    required this.name,
    required this.harga,
    required this.amount,
    this.count,
  }) : super(key: key);

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  int _jumlahOrder = 0;
  String _selectedLevel = "1";

  final List<String> _listLevel = [
    "1", "2", "3"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.white.withOpacity(0.95),
      body: SilverAppBar(
        title: const Text("Detail Menu", style: TypoSty.title),
        floating: true,
        pinned: true,
        back: true,
        body: Column(
          children: [
            const SizedBox(height: SpaceDims.sp24),
            SizedBox(
              width: 234.0,
              height: 182.4,
              child: Image.asset(widget.urlImage),
            ),
            const SizedBox(height: SpaceDims.sp24),
            Expanded(
              child: Container(
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
                    ]),
                child: SingleChildScrollView(
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
                              widget.name,
                              style: TypoSty.title.copyWith(
                                color: ColorSty.primary,
                              ),
                            ),
                            AddOrderButton(
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
                              prefix: widget.harga,
                              onPressed: () {},
                            ),
                            TileListDMenu(
                              prefixIcon: true,
                              icon: IconsCs.fire,
                              title: "Level",
                              prefix: "1",
                              onPressed: () => showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                context: context,
                                builder: (BuildContext context){
                                  return StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                    return BottomSheetDetailMenu(
                                      title: "Pilih Level",
                                      content: Expanded(
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: _listLevel.map((e) => LabelSelection(
                                            title: e,
                                            isSelected: e == _selectedLevel ? true : false,
                                            onSelection: (String value) => setState(() => _selectedLevel = value),
                                          ),).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                  );
                                },
                              ),
                            ),
                            TileListDMenu(
                              prefixIcon: true,
                              icon: IconsCs.topping_icon,
                              title: "Topping",
                              prefix: "Morizela",
                              onPressed: () => showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                context: context,
                                builder: (BuildContext context) =>
                                    BottomSheetDetailMenu(
                                  title: "Pilih Toping",
                                  content: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        LabelSelection(
                                          isSelected: "Mozarella"
                                                  .compareTo(_selectedLevel) ==
                                              0,
                                          title: "Mozarella",
                                          onSelection: (String value) {
                                            setState(
                                                () => _selectedLevel = value);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        LabelSelection(
                                          isSelected: "Sausagge"
                                                  .compareTo(_selectedLevel) ==
                                              0,
                                          title: "Sausagge",
                                          onSelection: (String value) {},
                                        ),
                                        LabelSelection(
                                          isSelected: "Dimsum"
                                                  .compareTo(_selectedLevel) ==
                                              0,
                                          title: "Dimsum",
                                          onSelection: (String value) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
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
                                                borderRadius: BorderRadius.circular(100.0),
                                            ),
                                        ),
                                        child:
                                            const Icon(Icons.check, size: 26.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(thickness: 1.5),
                            const SizedBox(height: SpaceDims.sp12),
                            ChangeNotifierProvider(
                              create: (_) => OrderProvider(),
                              child: ElevatedButton(
                                onPressed: () {
                                  Provider.of<OrderProvider>(context, listen: false).addOrder(_jumlahOrder);
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
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelSelection extends StatelessWidget {
  final String title;
  final bool isSelected;
  final ValueChanged<String> onSelection;

  const LabelSelection({
    Key? key,
    required this.title,
    required this.onSelection,
    required this.isSelected,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: SpaceDims.sp20, horizontal: SpaceDims.sp4),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? ColorSty.primary : ColorSty.white,
          primary: !isSelected ? ColorSty.primary : ColorSty.white,
          padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorSty.primary),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          onSelection(title);
          Navigator.of(context).pop();
        },
        child: Row(
          children: [
            const SizedBox(width: SpaceDims.sp4),
            Text(title),
            const SizedBox(width: SpaceDims.sp4),
            if (isSelected) const Icon(Icons.check, size: 18.0),
          ],
        ),
      ),
    );
  }
}

class TileListDMenu extends StatelessWidget {
  final String title, prefix;
  final IconData icon;
  final bool? prefixIcon;
  final TextStyle? textStylePrefix;
  final Function() onPressed;
  final bool? dense;

  const TileListDMenu({
    Key? key,
    required this.title,
    required this.prefix,
    required this.icon,
    this.prefixIcon,
    required this.onPressed,
    this.textStylePrefix,
    this.dense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        ListTile(
          onTap: prefixIcon ?? false ? onPressed : null,
          leading: Padding(
            padding: const EdgeInsets.only(top: SpaceDims.sp2),
            child: Icon(icon, color: ColorSty.primary, size: 22.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TypoSty.captionBold),
              Row(
                children: [
                  SizedBox(
                    width: 108,
                    child: Text(
                      prefix,
                      style: prefixIcon ?? false
                          ? TypoSty.captionSemiBold
                              .copyWith(fontWeight: FontWeight.normal)
                              .merge(textStylePrefix)
                          : dense ?? false
                              ? TypoSty.captionSemiBold
                                  .copyWith(fontWeight: FontWeight.normal)
                                  .merge(textStylePrefix)
                              : TypoSty.title
                                  .copyWith(color: ColorSty.primary)
                                  .merge(textStylePrefix),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (prefixIcon ?? false)
                    Padding(
                      padding: EdgeInsets.only(
                        left: dense ?? false ? SpaceDims.sp4 : SpaceDims.sp8,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: dense ?? false ? 18.0 : 22.0,
                        color: ColorSty.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddOrderButton extends StatefulWidget {
  final ValueChanged<int> onChange;

  const AddOrderButton({Key? key, required this.onChange}) : super(key: key);

  @override
  _AddOrderButtonState createState() => _AddOrderButtonState();
}

class _AddOrderButtonState extends State<AddOrderButton> {
  int jumlahOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (jumlahOrder != 0)
          TextButton(
            onPressed: () {
              setState(() => jumlahOrder--);
              widget.onChange(jumlahOrder);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(25, 25),
              side: const BorderSide(color: ColorSty.primary, width: 2),
            ),
            child: const Icon(Icons.remove),
          ),
        if (jumlahOrder != 0) Text("$jumlahOrder", style: TypoSty.subtitle),
        TextButton(
          onPressed: () {
            setState(() => jumlahOrder++);
            widget.onChange(jumlahOrder);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(25, 25),
            primary: ColorSty.white,
            backgroundColor: ColorSty.primary,
          ),
          child: const Icon(Icons.add, color: ColorSty.white),
        )
      ],
    );
  }
}

class BottomSheetDetailMenu extends StatelessWidget {
  final Widget content;
  final String title;

  const BottomSheetDetailMenu({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp16),
        child: Column(
          children: [
            SizedBox(
              width: 104.0,
              height: 4.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: ColorSty.grey,
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            const SizedBox(height: SpaceDims.sp16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(title, style: TypoSty.title),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
