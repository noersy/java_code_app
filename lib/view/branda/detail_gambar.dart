import 'package:flutter/material.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/text_style.dart';

class DetailGambar extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
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
