
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/icons_cs_icons.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/widget/silver_appbar.dart';

class DetailMenu extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.white.withOpacity(0.95),
      body: SilverAppBar(
        title: const Text("Detai Menu", style: TypoSty.title),
        floating: true,
        pinned: true,
        back: true,
        body: Column(
          children: [
            const SizedBox(height: SpaceDims.sp24),
            SizedBox(
              width: 234.0,
              child: Image.asset(urlImage),
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
                              name,
                              style: TypoSty.title.copyWith(
                                color: ColorSty.primary,
                              ),
                            ),
                            const AddOrderButton(),
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
                              prefix: "1",
                              onPressed: ()=> showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                context: context,
                                builder: (BuildContext context) => BottomSheetDetailMenu(
                                  title: "Pilih Toping",
                                  content: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        LabelSelection(
                                          title: "1",
                                          onSelection: (String value){

                                          },
                                        ),
                                        LabelSelection(
                                          title: "2",
                                          onSelection: (String value){

                                          },
                                        ),
                                        LabelSelection(
                                          title: "3",
                                          onSelection: (String value){

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                             TileListDMenu(
                              prefixIcon: true,
                              icon: IconsCs.topping_icon,
                              title: "Topping",
                              prefix: "Morizela",
                              onPressed: ()=> showModalBottomSheet(
                                isScrollControlled: true,
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                context: context,
                                builder: (BuildContext context) => BottomSheetDetailMenu(
                                  title: "Pilih Toping",
                                  content: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        LabelSelection(
                                          title: "Mozarella",
                                          onSelection: (String value){

                                          },
                                        ),
                                        LabelSelection(
                                          title: "Sausagge",
                                          onSelection: (String value){

                                          },
                                        ),
                                        LabelSelection(
                                          title: "Dimsum",
                                          onSelection: (String value){

                                          },
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
                                builder: (BuildContext context) => BottomSheetDetailMenu(
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
                                                borderRadius: BorderRadius.circular(100.0)
                                            )
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: SpaceDims.sp2),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LabelSelection extends StatefulWidget {
  final String title;
  final ValueChanged<String> onSelection;
  const LabelSelection({Key? key, required this.title, required this.onSelection}) : super(key: key);

  @override
  _LabelSelectionState createState() => _LabelSelectionState();
}

class _LabelSelectionState extends State<LabelSelection> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: SpaceDims.sp20, horizontal: SpaceDims.sp4),
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: _isSelected ? ColorSty.primary : ColorSty.white,
            primary:  !_isSelected ? ColorSty.primary : ColorSty.white,
            padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: ColorSty.primary),
              borderRadius: BorderRadius.circular(30.0),
          )
        ),
        onPressed: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onSelection(widget.title);
          });
        },
        child: Row(
          children: [
            const SizedBox(width: SpaceDims.sp4),
            Text(widget.title),
            const SizedBox(width: SpaceDims.sp4),
            if(_isSelected) const Icon(Icons.check, size: 18.0),
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
  final Function() onPressed;

  const TileListDMenu({
    Key? key,
    required this.title,
    required this.prefix,
    required this.icon,
    this.prefixIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1.5),
        ListTile(
          onTap: prefixIcon ?? false
              ? onPressed
              : null,
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
                    width: 168,
                    child: Text(
                      prefix,
                      style: prefixIcon ?? false
                          ? TypoSty.captionSemiBold
                              .copyWith(fontWeight: FontWeight.normal)
                          : TypoSty.title.copyWith(color: ColorSty.primary),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (prefixIcon ?? false)
                    const Padding(
                      padding: EdgeInsets.only(left: SpaceDims.sp8),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 22.0,
                        color: ColorSty.black60,
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
  const AddOrderButton({Key? key}) : super(key: key);

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
            onPressed: () => setState(() => jumlahOrder--),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(25, 25),
              side: const BorderSide(color: ColorSty.primary, width: 2),
            ),
            child: const Icon(Icons.remove),
          ),
        if (jumlahOrder != 0) Text("$jumlahOrder", style: TypoSty.subtitle),
        TextButton(
          onPressed: () => setState(() => jumlahOrder++),
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
