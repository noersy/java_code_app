import 'package:flutter/material.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/orders/checkout_page.dart';
import 'package:provider/provider.dart';

class CardMenu extends StatefulWidget {
  final Map<String, dynamic> data;

  const CardMenu({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  int _jumlahOrder = 0;
  late final String nama, harga, url, id;
  late final int amount;

  void  _add(){
    setState(() => _jumlahOrder++);
    if(_jumlahOrder == 1){
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        jumlahOrder: _jumlahOrder,
        data: widget.data,
        catatan: '',
        topping: [],
        level: '',
      );
    }else{
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        data: widget.data,
        catatan: '',
        topping: [],
        level: '',
      );
    }
  }

  void _min() async {
    setState(() => _jumlahOrder--);
    final orders = Provider.of<OrderProviders>(context, listen: false).checkOrder;
    if(_jumlahOrder >= 1){
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        data: widget.data,
        catatan: '',
        topping: [],
        level: '',
      );
    } else if (_jumlahOrder != 0) {
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        jumlahOrder: _jumlahOrder,
        data: widget.data,
        catatan: '',
        topping: [],
        level: '',
      );
    }else{
      await showDialog(context: context,
        builder: (_) => DeleteMenuInCheckoutDialog(id: widget.data["id"]),
      );
    }
  }

  @override
  void initState() {
    amount = widget.data["amount"] ?? 0;
    id = widget.data["id"];

    _jumlahOrder = widget.data["countOrder"] ?? 0;
    nama = widget.data["name"] ?? "";
    url = widget.data["image"] ?? "";
    harga = widget.data["harga"] ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDims.sp12, vertical: SpaceDims.sp2),
      child: Card(
        elevation: 4,
        color: ColorSty.white80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: amount == 0 ? null: () {
            Navigate.toDetailMenu(
              context,
              data: widget.data,
              countOrder: _jumlahOrder,
            );
          },
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
                  child: Image.asset(url),
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
                    style: TypoSty.title.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    harga,
                    style: TypoSty.title.copyWith(color: ColorSty.primary),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.playlist_add_check,
                        color: ColorSty.primary,
                      ),
                      const SizedBox(width: SpaceDims.sp4),
                      AnimatedBuilder(
                        animation: OrderProviders(),
                        builder: (context, snapshot) {
                          final _orders = Provider.of<OrderProviders>(context).checkOrder;
                          String _catatan = "";

                          if(_orders.containsKey(id)) {
                            _catatan = _orders[id]["catatan"] ?? "";
                          }

                          return Text(
                            _catatan.isEmpty ? "Tambahkan Catatan" : _catatan,
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
              if (amount != 0)
                Expanded(
                  child: AnimatedBuilder(
                      animation: OrderProviders(),
                      builder: (context, snapshot) {
                        final orders = Provider.of<OrderProviders>(context).checkOrder;
                        if (orders.keys.contains(id)) {
                          _jumlahOrder = orders[id]["countOrder"];
                        }
                        if (!orders.keys.contains(id)) _jumlahOrder = 0;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (_jumlahOrder != 0)
                              TextButton(
                                onPressed: _min,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(25, 25),
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
                                minimumSize: const Size(25, 25),
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
                Expanded(
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
      ),
    );
  }
}
