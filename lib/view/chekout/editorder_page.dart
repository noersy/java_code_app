import 'package:flutter/material.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/shadows.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:java_code_app/widget/button/addorder_button.dart';
import 'package:java_code_app/widget/input/label_toppingselection.dart';
import 'package:java_code_app/widget/list/listmenu_tile.dart';
import 'package:java_code_app/widget/sheet/detailmenu_sheet.dart';
import 'package:java_code_app/widget/input/labellevel_selection.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class EditOrderPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final int countOrder;

  const EditOrderPage({
    Key? key,
    required this.data,
    required this.countOrder,
  }) : super(key: key);

  @override
  State<EditOrderPage> createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  Level? _selectedLevel;
  List<Level> _selectedTopping = [];

  int status = 0;
  int _jumlahOrder = 0;
  late final num _harga;
  num _hargaTotal = 0, _hargaLevel = 0, _hargaTopping = 0;
  List<Level> _listLevel = [];
  List<Level> _listTopping = [];
  final TextEditingController _editingController = TextEditingController();
  String _catatan = "";

  Menu? _menu;

  bool _isLoading = true;

  getMenu() async {
    final data = await Provider.of<OrderProviders>(context, listen: false).getDetailMenu(id: int.parse(widget.data["id"]));
    if (mounted) setState(() => _isLoading = true);

    if (data != null) {
      _menu = data.data.menu;
      _harga = _menu?.harga ?? 0;
      _hargaTotal = _harga;

      if (data.data.topping?.isNotEmpty ?? false) {
        _selectedTopping = [data.data.topping!.first];
        _hargaLevel = data.data.topping!.first.harga;
        _hargaTotal = _harga + _hargaLevel + _hargaTopping;
      }
      if (data.data.level?.isNotEmpty ?? false) {
        _selectedLevel = data.data.level!.first;
        _hargaTopping = data.data.level!.first.harga;
        _hargaTotal = _harga + _hargaLevel + _hargaTopping;
      }

      _listLevel = data.data.level ?? [];
      _listTopping = data.data.topping ?? [];

      ///Get if order already exist
      final orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;

      if (orders.containsKey("${_menu?.idMenu}")) {
        final dat = orders["${_menu?.idMenu}"];
        _jumlahOrder = dat["countOrder"];

        if (dat["level"] != null) {
          final _level = data.data.level
              ?.where((element) => "${element.idDetail}" == dat["level"]);
          if (_level?.isNotEmpty ?? false){
            _selectedLevel = _level!.first;
            _hargaLevel = _level.first.harga;
            _hargaTotal = _harga + _hargaLevel + _hargaTopping;
          }
        }
        if (dat["topping"] != null) {
          final topping = data.data.topping?.where((item) {
            for (final e in dat["topping"]) {
              if (e == item.idDetail) return true;
            }
            return false;
          }).toList();

          if(topping?.isNotEmpty ?? false){
            _selectedTopping = topping!;
            _hargaTopping = topping.map((e) => e.harga).reduce((e, a) => e+a);
            _hargaTotal = _harga + _hargaLevel + _hargaTopping;
          }
        }

        if (dat["catatan"] != null) _catatan = dat["catatan"];
      }

      _isLoading = false;
    }

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _jumlahOrder = widget.countOrder;

    getMenu();
    super.initState();
  }

  void _showTopping(List<Level>? _listTopping) {
    if (_listTopping?.isEmpty ?? false) return;
    showModalBottomSheet(
      barrierColor: ColorSty.grey.withOpacity(0.2),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (_) => BottomSheetDetailMenu(
        title: "Pilih Toping",
        content: Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final item in _listTopping!)
                LabelToppingSelection(
                  data: item,
                  initial: _selectedTopping.where((e) => e == item).isNotEmpty,
                  onSelection: (value) {
                    if (_selectedTopping.where((e) => e == value).isNotEmpty) {
                      setState(() => _selectedTopping.remove(value));
                    } else {
                      setState(() => _selectedTopping.add(value));
                    }
                    final _top = _selectedTopping.map((e) => e.harga);
                    if(_top.isNotEmpty) {
                      _hargaTopping = _top.reduce((e, a) => e+a);
                    } else {
                      _hargaTopping = 0;
                    }
                    _hargaTotal = _harga + _hargaLevel + _hargaTopping;
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  void _showLevel(List<Level> _listLevel) async {
    if (_listLevel.isEmpty) return;
    Level _value = _listLevel.first;
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
                    for (final item in _listLevel)
                      LabelLevelSelection(
                        data: item,
                        isSelected: item == _selectedLevel,
                        onSelection: (Level value) {
                          _hargaTotal = _harga + _hargaLevel + _hargaTopping;
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

  void _editPesanan() {
    final data = widget.data;

    if (_jumlahOrder <= 0) {
      Provider.of<OrderProviders>(context, listen: false).deleteOrder(id: "${_menu?.idMenu}");
    } else {
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        id: data["id"],
        hargaTotal: _hargaTotal,
        jumlahOrder: _jumlahOrder,
        level: _selectedLevel,
        catatan: _catatan,
        topping: _selectedTopping,
      );
    }

    Navigator.of(context).pop();
  }

  void _addCatatan() {
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
            onTap: () => Navigate.toViewImage(urlImage: "${_menu?.foto}"),
            child: SizedBox(
              width: 234.0,
              height: 182.4,
              child: Hero(
                  tag: 'image',
                  child: Image.network(
                    _menu?.foto ?? "",
                    loadingBuilder: imageOnLoad,
                    errorBuilder: imageError,
                  )),
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
                          if (_menu != null)
                            Text(
                              "${_menu?.nama}",
                              style: TypoSty.title.copyWith(
                                color: ColorSty.primary,
                              ),
                            )
                          else
                            const SizedBox(
                              width: 90,
                              child: SkeletonText(height: 16.0),
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
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: SpaceDims.sp12,
                        left: SpaceDims.sp24,
                        right: 108.0,
                      ),
                      child: SizedBox(
                        height: 120,
                        child: _isLoading
                            ? const SkeletonText(height: 12.0)
                            : Text(_menu?.deskripsi ?? "none", textAlign: TextAlign.start),
                      ),
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
                            isLoading: _isLoading,
                            title: "Harga",
                            prefix: "$_hargaTotal",
                            onPressed: () {},
                          ),
                          TileListDMenu(
                            prefixIcon: true,
                            isLoading: _isLoading,
                            icon: IconsCs.fire,
                            title: "Level",
                            prefix: _selectedLevel?.keterangan,
                            onPressed: () => _showLevel(_listLevel),
                          ),
                          TileListDMenu(
                            prefixIcon: true,
                            icon: IconsCs.topping,
                            title: "Topping",
                            isLoading: _isLoading,
                            prefixCostume: RichText(
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  style: TypoSty.captionSemiBold
                                      .copyWith(color: ColorSty.black),
                                  text: _selectedTopping.isEmpty
                                      ? ""
                                      : _selectedTopping.first.keterangan,
                                  children: [
                                    for (var i = 0;
                                        i < _selectedTopping.length;
                                        i++)
                                      if (i > 0)
                                        TextSpan(
                                          text:
                                              ", ${_selectedTopping[i].keterangan}",
                                          style:
                                              TypoSty.captionSemiBold.copyWith(
                                            color: ColorSty.black,
                                          ),
                                        )
                                  ]),
                            ),
                            onPressed: () => _showTopping(_listTopping),
                          ),
                          TileListDMenu(
                            prefixIcon: true,
                            icon: IconsCs.note,
                            title: "Catatan",
                            isLoading: _isLoading,
                            prefix: _catatan.isEmpty
                                ? "Lorem Ipsum sit aaasss"
                                : _catatan,
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
                                          contentPadding: EdgeInsets.symmetric(
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
}
