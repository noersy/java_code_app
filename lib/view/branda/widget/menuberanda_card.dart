import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/menulist.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/checkout_page.dart';
import 'package:provider/provider.dart';

class CardMenu extends StatefulWidget {
  final DMenu data;

  const CardMenu({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  int _jumlahOrder = 0;
  late final String nama, url;
  late final int status, id, harga;
  late final Map<String, dynamic> _data;

  void  _add(){
    setState(() => _jumlahOrder++);
    if(_jumlahOrder == 1){
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        jumlahOrder: _jumlahOrder,
        data: _data,
        catatan: '',
      );
    }else{
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        id: "${widget.data.idMenu}",
        catatan: '',
      );
    }
  }

  void _min() async {
    setState(() => _jumlahOrder--);
    final orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    if(_jumlahOrder >= 1){
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        id: "${widget.data.idMenu}",
        catatan: '',
      );
    } else if (_jumlahOrder != 0) {
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        jumlahOrder: _jumlahOrder,
        data: _data,
        catatan: '',
      );
    }else{
      await showDialog(context: context,
        builder: (_) => DeleteMenuInCheckoutDialog(id: "${widget.data.idMenu}"),
      );
    }
  }

  @override
  void initState() {
    status = widget.data.status;
    id = widget.data.idMenu;

    _jumlahOrder =  0;
    nama = widget.data.nama;
    harga = widget.data.harga;
    url = widget.data.foto ?? "";


    _data = {
    "id": "${widget.data.idMenu}",
    "jenis": widget.data.kategori,
    "image": widget.data.foto,
    "harga": widget.data.harga,
    "amount": widget.data.status,
    "name": widget.data.nama,
    "level": "",
    "topping": [],
    "catatan": "",
    "countOrder": _jumlahOrder,
    };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceDims.sp22,
        vertical: SpaceDims.sp8,
      ),
      child: ElevatedButton(
        onPressed: status == 0 ? null: () {
          Navigate.toDetailMenu(
            context,
            id: widget.data.idMenu,
            countOrder: _jumlahOrder,
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: ColorSty.white80,
          onPrimary: ColorSty.primary,
          padding: const EdgeInsets.all(
            SpaceDims.sp8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 74,
                  width: 74,
                  child: Padding(
                    padding: const EdgeInsets.all(SpaceDims.sp4),
                    child: Image.network(
                      url,
                      loadingBuilder: imageOnLoad,
                      errorBuilder: imageError,
                    )
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
                    Text(
                      nama,
                      overflow: TextOverflow.ellipsis,
                      style: TypoSty.title.copyWith(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Rp $harga",
                      overflow: TextOverflow.ellipsis,
                      style: TypoSty.title.copyWith(color: ColorSty.primary),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assert/image/icons/note-icon.svg"),
                        const SizedBox(width: SpaceDims.sp4),
                        AnimatedBuilder(
                          animation: OrderProviders(),
                          builder: (context, snapshot) {
                            final _orders = Provider.of<OrderProviders>(context).checkOrder;
                            String _catatan = "";

                            if(_orders.containsKey("$id")) {
                              _catatan = _orders["$id"]["catatan"] ?? "";
                            }

                            return Text(
                              _catatan.isEmpty ? "Tambahkan Catatan" : _catatan,
                              overflow: TextOverflow.ellipsis,
                              style: TypoSty.caption2.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                                color: ColorSty.grey,
                              ),
                            );
                          }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (status != 0)
              Positioned.fill(
                right: 0,
                child: AnimatedBuilder(
                    animation: OrderProviders(),
                    builder: (context, snapshot) {
                      final orders = Provider.of<OrderProviders>(context).checkOrder;
                      if (orders.keys.contains("$id")) {
                        _jumlahOrder = orders["$id"]["countOrder"];
                      }
                      if (!orders.keys.contains("$id")) _jumlahOrder = 0;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (_jumlahOrder != 0)
                            TextButton(
                              onPressed: _min,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(24, 24),
                                side: const BorderSide(
                                  color: ColorSty.primary,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(Icons.remove),
                            ),
                          if (_jumlahOrder != 0)
                            Text("$_jumlahOrder", style: TypoSty.subtitle),
                          TextButton(
                            onPressed: _add,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(24, 24),
                              primary: ColorSty.white,
                              backgroundColor: ColorSty.primary,
                            ),
                            child:
                                const Icon(Icons.add, color: ColorSty.white),
                          )
                        ],
                      );
                    }),
              )
            else
              Positioned.fill(
                right: 0,
                child: Container(
                  alignment: Alignment.bottomRight,
                  height: 70,
                  child: Text(
                    "Stok Habis",
                    style: TypoSty.caption.copyWith(
                      color: ColorSty.grey,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
