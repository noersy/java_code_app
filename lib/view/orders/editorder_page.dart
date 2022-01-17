import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/shadows.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/detailmenu_page.dart';
import 'package:java_code_app/widget/addorder_button.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/detailmenu_sheet.dart';
import 'package:java_code_app/widget/label_toppingselection.dart';
import 'package:java_code_app/widget/labellevel_selection.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:provider/provider.dart';

class EditOrderPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final int countOrder;

  const EditOrderPage({
    Key? key, required this.data, required this.countOrder,
  }) : super(key: key);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  String _selectedLevel = "1";
  List<String> _selectedTopping = ["Mozarella"];

  late final String urlImage, name, harga, id;
  late final int amount;
  int _jumlahOrder = 0;
  final List<String> _listLevel = ["1", "2", "3"];
  final List<String> _listTopping = ["Mozarella", "Sausagge", "Dimsum"];
  final TextEditingController _editingController = TextEditingController();
  String _catatan = "";

  @override
  void initState() {
    // print(widget.data);

    _jumlahOrder = widget.countOrder;
    name = widget.data["name"] ?? "";
    urlImage = widget.data["image"] ?? "";
    harga = widget.data["harga"] ?? "";
    amount = widget.data["amount"] ?? 0;
    id = widget.data["id"] ?? '-';

    _catatan = widget.data["catatan"] ?? "";
    _selectedTopping = widget.data["topping"] ?? _selectedTopping;
    _selectedLevel = widget.data["level"] ?? "1";

    final orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    if(orders.keys.contains(id)) {
      _jumlahOrder = orders[id]["countOrder"];
      _catatan = orders[id]["catatan"] ?? "";
      _selectedTopping = orders[id]["topping"] ?? _selectedTopping;
      _selectedLevel = orders[id]["level"] ?? "1";
    }


    super.initState();
  }

  void _editPesanan(){
    // final orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    final data = widget.data;

    data["level"] = _selectedLevel;
    data["topping"] = _selectedTopping;
    data["catatan"] = _catatan;

    if (_jumlahOrder <= 0) {
      Provider.of<OrderProviders>(context, listen: false).deleteOrder(id: id);
    } else {
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        data: data,
        jumlahOrder: _jumlahOrder,
        level: _selectedLevel,
        catatan: _catatan,
        topping: _selectedTopping,
      );
    }

    Navigator.of(context).pop();
  }


  void _addCatatan(){
    setState(() => _catatan = _editingController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        back: true,
        title: "Edit Menu",
      ),
      body: Column(
        children: [
          const SizedBox(height: SpaceDims.sp24),
          GestureDetector(
            onTap: ()=> Navigate.toViewImage(context, urlImage: urlImage),
            child: SizedBox(
              width: 234.0,
              height: 182.4,
              child: Hero(
                  tag: 'image',
                  child: Image.asset(urlImage),
              ),
            ),
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
                ],
              ),
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
                            icon: IconsCs.cash,
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
                            icon: IconsCs.topping,
                            title: "Topping",
                            prefixCostume: RichText(
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  style: TypoSty.captionSemiBold.copyWith(color: ColorSty.black),
                                  text: _selectedTopping.isEmpty ? "" : _selectedTopping[0],
                                  children: [
                                    for (var i = 0; i < _selectedTopping.length; i++)
                                      if(i > 0)
                                      TextSpan(
                                        text: ", " +_selectedTopping[i],
                                        style: TypoSty.captionSemiBold.copyWith(
                                          color: ColorSty.black,
                                        ),
                                      )
                                  ]),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                barrierColor: ColorSty.grey.withOpacity(0.2),
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0)
                                    )
                                ),
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
                                            initial: _selectedTopping.where((e) => e == item).isNotEmpty,
                                            onSelection: (value) {
                                              if (_selectedTopping.where((e) => e == value).isNotEmpty) {
                                                setState(() => _selectedTopping.remove(value));
                                              } else {
                                                setState(() => _selectedTopping.add(value));
                                              }
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          TileListDMenu(
                            prefixIcon: true,
                            icon: IconsCs.note,
                            title: "Catatan",
                            prefix: _catatan.isEmpty ? "Lorem Ipsum sit aaasss" : _catatan,
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
                                            controller: _editingController,
                                            maxLength: 100,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 0),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: _addCatatan,
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(0),
                                            minimumSize: const Size(25.0, 25.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(100.0),
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
      bottomNavigationBar: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorSty.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: ShadowsB.boxShadow1,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceDims.sp24,
            vertical: SpaceDims.sp8,
          ),
          child: ElevatedButton(
            onPressed: _editPesanan,
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Simpan",
                  style: TypoSty.button,
                ),
              ),
            ),
          ),
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
