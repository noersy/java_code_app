import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final ValueChanged<int>? onChange;
  final Map<String, dynamic> data;

  const CardMenuCheckout({Key? key, required this.data, this.onChange})
      : super(key: key);

  @override
  State<CardMenuCheckout> createState() => _CardMenuCheckoutState();
}

class _CardMenuCheckoutState extends State<CardMenuCheckout> {
  void _min() async {
    setState(() => _jumlahOrder--);
    if (_jumlahOrder >= 1) {
      Provider.of<OrderProviders>(context, listen: false).editOrder(
        jumlahOrder: _jumlahOrder,
        id: "${widget.data['id']}",
        catatan: '',
      );
    } else {
      await showDialog(
        context: context,
        builder: (_) => DeleteMenuInCheckoutDialog(id: "${widget.data['id']}"),
      ).then((value) => Navigator.pop(context));
    }
  }

  void _add() {
    setState(() => _jumlahOrder++);
    Provider.of<OrderProviders>(context, listen: false).editOrder(
      jumlahOrder: _jumlahOrder,
      id: "${widget.data['id']}",
      catatan: '',
    );
  }

  int _jumlahOrder = 0;
  late final String nama, harga, url;
  late final int status;

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
                        fontSize: 16.0.sp,
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
                              fontSize: 10.0.sp,
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
                right: 10,
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
                      return Row(
                        children: [
                          if (_jumlahOrder != 0)
                            TextButton(
                              onPressed: () {
                                _min();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(25, 25),
                                side: const BorderSide(
                                    color: ColorSty.primary, width: 2),
                              ),
                              child: const Icon(Icons.remove),
                            ),
                          Text("$_jumlahOrder", style: TypoSty.subtitle),
                          TextButton(
                            onPressed: () {
                              _add();
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
                    }),
              )
          ],
        ),
      ),
    );
  }
}
