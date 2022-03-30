import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/lang.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/widget/bottom_sheet.dart';
import 'package:java_code_app/widget/button/addorder_button.dart';
import 'package:java_code_app/widget/dialog/custom_text.dart';
import 'package:java_code_app/widget/input/label_toppingselection.dart';
import 'package:java_code_app/widget/list/listmenu_tile.dart';
import 'package:java_code_app/widget/sheet/detailmenu_sheet.dart';
import 'package:java_code_app/widget/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../providers/lang_providers.dart';

class DetailMenu extends StatefulWidget {
  final int countOrder, id;

  const DetailMenu({
    Key? key,
    required this.countOrder,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  int _jumlahOrder = 0;
  late final num _harga;
  num _hargaTotal = 0, _hargaLevel = 0, _hargaTopping = 0;
  Level? _selectedLevel;
  List<Level> _selectedTopping = [];
  List<Level> _listLevel = [];
  List<Level> _listTopping = [];
  String _catatan = "";
  final TextEditingController _editingController = TextEditingController();
  static bool _isLoading = true;

  Menu? _menu;

  @override
  void initState() {
    _jumlahOrder = widget.countOrder;
    getMenu();
    super.initState();
  }

  getMenu() async {
    if (mounted) setState(() => _isLoading = true);
    final data = await Provider.of<OrderProviders>(context, listen: false)
        .getDetailMenu(id: widget.id);

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
      final orders =
          Provider.of<OrderProviders>(context, listen: false).checkOrder;

      if (orders.containsKey("${_menu?.idMenu}")) {
        final dat = orders["${_menu?.idMenu}"];

        if (dat["level"] != null) {
          final _level =
              data.data.level?.where((e) => "${e.idDetail}" == dat["level"]);
          if (_level?.isNotEmpty ?? false) {
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

          if (topping?.isNotEmpty ?? false) {
            _selectedTopping = topping!;
            _hargaTopping = topping.map((e) => e.harga).reduce((e, a) => e + a);
            _hargaTotal = _harga + _hargaLevel + _hargaTopping;
          }
        }

        if (dat["catatan"] != null) _catatan = dat["catatan"];
      }

      _isLoading = false;
    }

    if (mounted) setState(() {});
  }

  void _viewImage() => Navigate.toDetailGambar(context, _menu!.foto);

  _showDialogLevel(List<Level>? _listLevel) async {
    if (_listLevel?.isEmpty ?? false) return;
    Level? _value = _listLevel!.first;

    _value = await showModalBottomSheet(
      barrierColor: ColorSty.grey.withOpacity(0.2),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDetailMenuTopping(
          listLevel: _listLevel,
          selectedLevel: _selectedLevel,
          onSelection: (Level value) {
            _hargaLevel = value.harga;
            _hargaTotal = _harga + _hargaLevel + _hargaTopping;
            setState(() => _selectedLevel = value);
          },
        );
      },
    );

    if (_value != null) {
      setState(() => _selectedLevel = _value);
    }
  }

  _showDialogTopping(List<Level>? _listTopping) async {
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
                    if (_top.isNotEmpty) {
                      _hargaTopping = _top.reduce((e, a) => e + a);
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

  void _addCatatan() {
    setState(() => _catatan = _editingController.text);
    Navigator.pop(context);
  }

  void _tambahkanPesanan() {
    if (_menu == null) return;

    double? height = MediaQuery.of(context).size.height;

    final orders =
        Provider.of<OrderProviders>(context, listen: false).checkOrder;

    final data = {
      "id": "${widget.id}",
      "jenis": _menu!.kategori,
      "image": _menu!.foto,
      "harga": _hargaTotal,
      "amount": _menu!.status,
      "name": _menu!.nama,
    };

    if (_jumlahOrder > 0) {
      if (orders.keys.contains("${widget.id}")) {
        Provider.of<OrderProviders>(context, listen: false).editOrder(
          id: "${widget.id}",
          jumlahOrder: _jumlahOrder,
          hargaTotal: _hargaTotal,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      } else {
        Provider.of<OrderProviders>(context, listen: false).addOrder(
          data: data,
          jumlahOrder: _jumlahOrder,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      }
      Navigator.of(context).pop();
    } else {
      showCustomSnackbar(
        context,
        'Item belum ditambahkan!',
      );
    }
  }

  void _onGoback() async {
    // print('detailmenu _onGoback');
    if (_menu == null) return;

    final orders =
        Provider.of<OrderProviders>(context, listen: false).checkOrder;

    final data = {
      "id": "${widget.id}",
      "jenis": _menu!.kategori,
      "image": _menu!.foto,
      "harga": _hargaTotal,
      "amount": _menu!.status,
      "name": _menu!.nama,
    };

    if (_jumlahOrder > 0) {
      if (orders.keys.contains("${widget.id}")) {
        await Provider.of<OrderProviders>(context, listen: false).editOrder(
          id: "${widget.id}",
          jumlahOrder: _jumlahOrder,
          hargaTotal: _hargaTotal,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      } else {
        await Provider.of<OrderProviders>(context, listen: false).addOrder(
          data: data,
          jumlahOrder: _jumlahOrder,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      }
      Navigator.of(context).pop();
    } else {
      // await Provider.of<OrderProviders>(context, listen: false).addOrder(
      //   data: data,
      //   jumlahOrder: _jumlahOrder,
      //   catatan: '',
      // );
      Navigator.of(context).pop();
    }
  }

  AppBar appBarDetailMenu() {
    return AppBar(
      title: Text(
        'Detail Menu',
        style: TypoSty.title,
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(30),
        bottomLeft: Radius.circular(30),
      )),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorSty.primary),
        onPressed: () => {
          if (_jumlahOrder >= 0)
            {
              _onGoback(),
            }
          else
            {Navigator.pop(context)}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: appBarDetailMenu(),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const SizedBox(height: SpaceDims.sp24),
            GestureDetector(
              onTap: _viewImage,
              child: SizedBox(
                width: 234.0,
                height: 182.4,
                child: Hero(
                  tag: "image",
                  child: Image.network(
                    _menu?.foto ?? "http://",
                    loadingBuilder: imageOnLoad,
                    errorBuilder: imageError,
                  ),
                ),
              ),
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
                    color: ColorSty.grey.withOpacity(0.02),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (_isLoading)
                          const SkeletonText(height: 16.0)
                        else
                          Text(
                            "${_menu?.nama}",
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
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SpaceDims.sp12,
                      left: SpaceDims.sp24,
                      right: 108.0,
                    ),
                    child: _isLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SkeletonText(height: 12.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: SkeletonText(height: 12.0),
                              ),
                              SizedBox(
                                width: 120,
                                child: SkeletonText(height: 12.0),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 100.0,
                            child: Text(
                              _menu?.deskripsi ?? "",
                              overflow: TextOverflow.fade,
                            ),
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
                          title: Provider.of<LangProviders>(context)
                              .lang
                              .detailMenu!
                              .harga,
                          prefix: !_isLoading ? "Rp $_hargaTotal" : "Rp 0",
                          onPressed: () {},
                        ),

                        //if level ada
                        if (_listLevel.isNotEmpty)
                          TileListDMenu(
                            prefixIcon: true,
                            isLoading: _isLoading,
                            icon: IconsCs.fire,
                            title: Provider.of<LangProviders>(context)
                                .lang
                                .detailMenu!
                                .level,
                            prefix: _selectedLevel?.keterangan,
                            onPressed: () => _showDialogLevel(_listLevel),
                          ),
                        //if topping ada
                        if (_listTopping.isNotEmpty)
                          TileListDMenu(
                            prefixIcon: true,
                            isLoading: _isLoading,
                            iconSvg: SvgPicture.asset(
                              "assert/image/icons/topping-icon.svg",
                              height: 22.0,
                            ),
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
                            title: Provider.of<LangProviders>(context)
                                .lang
                                .detailMenu!
                                .topping,
                            onPressed: () => _showDialogTopping(_listTopping),
                          ),
                        TileListDMenu(
                          prefixIcon: true,
                          icon: IconsCs.note,
                          isLoading: _isLoading,
                          title: Provider.of<LangProviders>(context)
                              .lang
                              .detailMenu!
                              .catatan,
                          prefix:
                              _catatan.isEmpty ? "Tambahkan catatan" : _catatan,
                          onPressed: () => showModalBottomSheet(
                            barrierColor: ColorSty.grey.withOpacity(0.2),
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) =>
                                BottomSheetDetailMenu(
                              title: "Buat Catatan",
                              content: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 100,
                                      controller: _editingController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
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
                          onPressed: _tambahkanPesanan,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: SpaceDims.sp2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                Provider.of<LangProviders>(context)
                                    .lang
                                    .detailMenu!
                                    .tambahKeranjang,
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
}
