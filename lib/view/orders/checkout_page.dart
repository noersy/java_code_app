import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/models/list_voucher.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/shadows.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/infodiscount_dialog.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:java_code_app/widget/vp_fingerprint_dialog.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  LVoucher? _selectedVoucher;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const CostumeAppBar(
        back: true,
        icon: Icon(IconsCs.pesanan, size: 28.0, color: ColorSty.primary),
        title: 'Pesanan',
      ),
      body: ScreenUtilInit(builder: () {
        return SingleChildScrollView(
          primary: true,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: OrderProviders(),
                builder: (context, snapshot) {
                  final _orders = Provider.of<OrderProviders>(context).checkOrder;
                  return Column(
                    children: [
                      if (_orders.values
                          .where((element) => element["jenis"] == "makanan")
                          .isNotEmpty)
                        ListOrder(
                          orders: _orders,
                          title: 'Makanan',
                          type: 'makanan',
                        ),
                      if (_orders.values
                          .where((element) => element["jenis"] == "minuman")
                          .isNotEmpty)
                        ListOrder(
                          orders: _orders,
                          title: 'Minuman',
                          type: 'minuman',
                        ),
                    ],
                  );
                }
              ),
              const SizedBox(height: SpaceDims.sp24),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: _selectedVoucher == null ? 300 : 240,
        decoration: const BoxDecoration(
          color: ColorSty.grey80,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SpaceDims.sp24.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SpaceDims.sp24.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total Pesanan ",
                              style: TypoSty.captionSemiBold,
                            ),
                            Text("(3 Menu) :", style: TypoSty.caption),
                          ],
                        ),
                        Text(
                          "Rp 30.000",
                          style: TypoSty.subtitle.copyWith(
                            color: ColorSty.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SpaceDims.sp14.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpaceDims.sp24,
                    ),
                    child: Column(
                      children: [
                        if (_selectedVoucher == null)
                          TileListDMenu(
                            dense: true,
                            prefixIcon: true,
                            title: "Diskon 20%",
                            prefix: "Rp 4.000",
                            textStylePrefix: const TextStyle(color: Colors.red),
                            iconSvg: SvgPicture.asset("assert/image/icons/discount-icon.svg", height: 24.0),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (_) => const InfoDiscountDialog()),
                          ),
                        TileListDMenu(
                            dense: true,
                            prefixIcon: true,
                            title: "Voucher",
                            prefixCostume: _selectedVoucher == null
                                ? null
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Rp ${_selectedVoucher!.nominal}",
                                        style: TypoSty.captionSemiBold
                                            .copyWith(color: Colors.red),
                                      ),
                                      Text(
                                        _selectedVoucher!.nama,
                                        style: TypoSty.mini,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      )
                                    ],
                                  ),
                            prefix: _selectedVoucher == null
                                ? "Pilih Voucher"
                                : null,
                            // icon: IconsCs.voucher,
                            iconSvg: SvgPicture.asset(
                                "assert/image/icons/voucher-icon-line.svg"),
                            onPressed: () async {
                              _selectedVoucher = await Navigate.toSelectionVoucherPage(context, initialData: _selectedVoucher);
                              setState(() {});
                            }),
                        Stack(children: [
                          TileListDMenu(
                            dense: true,
                            title: "Pembayaran",
                            prefix: "Pay Leter",
                            // icon: IconsCs.coins,
                            iconSvg: SvgPicture.asset(
                                "assert/image/icons/la_coins.svg",
                            ),
                            onPressed: () {},
                          ),
                        ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                padding: EdgeInsets.symmetric(horizontal: SpaceDims.sp24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          IconsCs.shopingbag,
                          color: ColorSty.primary,
                        ),
                        SizedBox(width: SpaceDims.sp14.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total Pembayaran",
                              style: TextStyle(color: ColorSty.black60),
                            ),
                            Text("Rp 27.000", style: TypoSty.titlePrimary),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_selectedVoucher != null) {
                          showDialog(
                          context: context,
                          builder: (_) => VFingerPrintDialog(ctx: context, voucher: _selectedVoucher!),
                        );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        "Pesan Sekarang",
                        style: TypoSty.button,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListOrder extends StatelessWidget {
  final String type, title;
  final Map<String, dynamic> orders;

  const ListOrder({
    Key? key,
    required this.type,
    required this.title,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: SpaceDims.sp22),
        Padding(
          padding: const EdgeInsets.only(left: SpaceDims.sp24),
          child: Row(
            children: [
              type.compareTo("makanan") == 0
                  ? SvgPicture.asset("assert/image/icons/ep_food.svg",
                      height: 22)
                  : SvgPicture.asset("assert/image/icons/ep_coffee.svg",
                      height: 26),
              const SizedBox(width: SpaceDims.sp4),
              Text(
                title,
                style: TypoSty.title.copyWith(
                  color: ColorSty.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpaceDims.sp12),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              for (Map<String, dynamic> item in orders.values)
                if (item["jenis"]?.compareTo(type) == 0)
                  CardMenuCheckout(data: item),
            ],
          ),
        ),
      ],
    );
  }
}

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

    if(orders.isEmpty) Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _jumlahOrder = widget.data["countOrder"] ?? 0;
    nama = widget.data["name"] ?? "";
    url = widget.data["image"] ?? "";
    harga = "${widget.data["harga"]}";
    amount = widget.data["amount"] ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SpaceDims.sp12,
          vertical: SpaceDims.sp2,
      ),
      child: Card(
        elevation: 4,
        color: ColorSty.white80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: () async {
            var _isEmpty = await Navigate.toEditOrderMenu(
              context,
              data: widget.data,
              countOrder: _jumlahOrder,
            );
            if(_isEmpty ?? false) Navigator.pop(context);
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
                  child: url.isNotEmpty
                      ? Image.asset(url)
                      : const Icon(Icons.image_not_supported, color: ColorSty.grey),
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
              if (amount != 0)
                Expanded(
                  child: AnimatedBuilder(
                    animation: OrderProviders(),
                    builder: (context, snapshot) {

                      final orders = Provider.of<OrderProviders>(context).checkOrder;
                      if(orders.keys.contains(widget.data["id"])) _jumlahOrder = orders[widget.data["id"]]["countOrder"];
                      if(!orders.keys.contains(widget.data["id"]))  _jumlahOrder = 0;

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
                            child: const Icon(Icons.add, color: ColorSty.white),
                          )
                        ],
                      );
                    }
                  ),
                )
              else
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 70,
                    padding:
                        const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
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


class DeleteMenuInCheckoutDialog extends StatelessWidget {
  final String id;
  const DeleteMenuInCheckoutDialog({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: SizedBox(
          height: 0.5.sh,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: 42.h),
            child: Column(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset(
                      "assert/image/icons/img-pesanan-disiapkan.svg",
                    ),
                    Positioned(
                      top: 5,
                      left: 2,
                      child: Stack(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: ColorSty.white,
                              borderRadius: BorderRadius.circular(100.0)
                            ),
                          ),
                          const Icon(Icons.cancel, size: 42.0, color: Colors.redAccent)
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: SizedBox(
                    width: 200.w,
                    child: Column(
                      children: [
                        Text(
                          "Hapus Item?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Kamu akan mengeluarkan menu ini dari ',
                            style: TypoSty.caption2.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Pesanan',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorSty.white,
                                  onPrimary: ColorSty.primary,
                                  padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(color: ColorSty.primary),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: (){
                                  Provider.of<OrderProviders>(context, listen: false).deleteOrder(id: id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Oke"),
                              ),
                            ),
                            const SizedBox(width: SpaceDims.sp12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Kembali"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
