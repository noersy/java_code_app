import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/view/branda/widget/bottom_sheet.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:java_code_app/widget/button/addorder_button.dart';
import 'package:java_code_app/widget/input/label_toppingselection.dart';
import 'package:java_code_app/widget/list/listmenu_tile.dart';
import 'package:java_code_app/widget/sheet/detailmenu_sheet.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class DetailGambar extends StatefulWidget {
  final foto;

  const DetailGambar({
    Key? key,
    required this.foto,
  }) : super(key: key);

  @override
  State<DetailGambar> createState() => _DetailGambarState();
}

class _DetailGambarState extends State<DetailGambar> {
  @override
  void initState() {
    super.initState();
  }

  void _viewImage() => Navigate.toViewImage(urlImage: widget.foto ?? "http://");

  AppBar appBarDetailGambar() {
    return AppBar(
      title: Text(
        '     Detail Gambar',
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
        onPressed: () => {Navigator.pop(context)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: appBarDetailGambar(),
      body: Center(
        child: SingleChildScrollView(
          primary: true,
          child: GestureDetector(
            onTap: _viewImage,
            child: SizedBox(
              width: 234.0,
              height: 182.4,
              child: Hero(
                tag: "image",
                child: Image.network(
                  widget.foto ?? "http://",
                  loadingBuilder: imageOnLoad,
                  errorBuilder: imageError,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
