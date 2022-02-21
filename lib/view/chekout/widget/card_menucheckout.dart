import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/constans/tools.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/chekout/widget/delete_chekcout_dialog.dart';
import 'package:provider/provider.dart';

class CardMenuCheckout extends StatefulWidget {
  final Map<String, dynamic> data;

  const CardMenuCheckout({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<CardMenuCheckout> createState() => _CardMenuCheckoutState();
}

class _CardMenuCheckoutState extends State<CardMenuCheckout> {
  int _jumlahOrder = 0;
  late final String nama, harga, url;
  late final int status;

  void _add() {
    if (_jumlahOrder >= 99) return;
    setState(() => _jumlahOrder++);
    if (_jumlahOrder == 1) {
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        catatan: '',
        data: widget.data,
        jumlahOrder: _jumlahOrder,
      );
    } else {
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        id: widget.data["id"],
        catatan: '',
        jumlahOrder: _jumlahOrder,
      );
    }
  }

  void _min() async {
    setState(() => _jumlahOrder--);
    final orders =
        Provider.of<OrderProviders>(context, listen: false).checkOrder;
    if (_jumlahOrder >= 1) {
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        id: widget.data["id"],
        catatan: '',
      );
    } else if (_jumlahOrder != 0) {
      Provider.of<OrderProviders>(context, listen: false).addOrder(
        jumlahOrder: _jumlahOrder,
        data: widget.data,
        catatan: '',
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) => DeleteMenuInCheckoutDialog(id: widget.data["id"]),
      );

      if (orders.isEmpty) Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _jumlahOrder = widget.data["countOrder"] ?? 0;
    nama = widget.data["name"] ?? "";
    url = widget.data["image"] ?? "";
    harga = "Rp ${oCcy.format(widget.data["harga"])}";
    status = widget.data["amount"] ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpaceDims.sp18,
        vertical: SpaceDims.sp2,
      ),
      child: ElevatedButton(
        onPressed: () async {
          var _isEmpty = await Navigate.toEditOrderMenu(
            context,
            data: widget.data,
            countOrder: _jumlahOrder,
          );
          if (_isEmpty ?? false) Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          primary: ColorSty.white80,
          elevation: 3,
          onPrimary: ColorSty.primary,
          padding: const EdgeInsets.all(
            SpaceDims.sp8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
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
                      errorBuilder: imageError,
                      loadingBuilder: imageOnLoad,
                    ),
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
                      harga,
                      style: TypoSty.title.copyWith(color: ColorSty.primary),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assert/image/icons/note-icon.svg"),
                        const SizedBox(width: SpaceDims.sp4),
                        SizedBox(
                          width: 120.0,
                          child: Text(
                            widget.data["catatan"] ?? "Tambahkan Catatan",
                            overflow: TextOverflow.ellipsis,
                            style: TypoSty.caption2.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                              color: ColorSty.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (status != 0)
              Positioned(
                right: 20,
                child: AnimatedBuilder(
                    animation: OrderProviders(),
                    builder: (context, snapshot) {
                      final orders =
                          Provider.of<OrderProviders>(context).checkOrder;
                      if (orders.keys.contains(widget.data["id"])) {
                        _jumlahOrder = orders[widget.data["id"]]["countOrder"];
                      }
                      if (!orders.keys.contains(widget.data["id"])) {
                        _jumlahOrder = 0;
                      }
                      return Text("$_jumlahOrder", style: TypoSty.subtitle);
                    }),
              )
          ],
        ),
      ),
    );
  }
}
