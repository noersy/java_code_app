import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/providers/profile_providers.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/detailmenu_sheet.dart';
import 'package:java_code_app/widget/silver_appbar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainSilverAppBar(
        floating: true,
        pinned: true,
        isExpand: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profil",
              style: TypoSty.title.copyWith(color: ColorSty.primary),
            ),
            const SizedBox(
              width: 65,
              child: Divider(
                thickness: 2,
                color: ColorSty.primary,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Image.asset("assert/image/bg_findlocation.png"),
            SingleChildScrollView(
              primary: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: SpaceDims.sp22),
                      SizedBox(
                        height: 171,
                        width: 171,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(300.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SvgPicture.asset(
                                "assert/image/icons/user-icon.svg",
                              ),
                              Positioned(
                                bottom: -10,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: ColorSty.primary,
                                    primary: ColorSty.white,
                                  ),
                                  child: const SizedBox(
                                    width: 160,
                                    height: 25,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text("Ubah"),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check,
                            color: ColorSty.primary,
                            size: 18.0,
                          ),
                          SizedBox(width: SpaceDims.sp2),
                          Text(
                            "Kamu sudah verifikasi KTP",
                            style: TextStyle(color: ColorSty.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: SpaceDims.sp22),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: SpaceDims.sp32),
                        child: Text("Info Akun", style: TypoSty.titlePrimary),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp24,
                          vertical: SpaceDims.sp12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: SpaceDims.sp22,
                        ),
                        decoration: BoxDecoration(
                          color: ColorSty.grey60,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: [
                            const TileListProfile(
                              top: false,
                              title: 'Nama',
                              suffix: 'Fajar',
                            ),
                            const TileListProfile(
                              title: 'Tanggal Lahir',
                              suffix: '01/03/1993',
                            ),
                            const TileListProfile(
                              title: 'No.Telepon',
                              suffix: '0822-4111-400',
                            ),
                            const TileListProfile(
                              title: 'Email',
                              suffix: 'lorem.ipsum@gmail.com',
                            ),
                            const TileListProfile(
                              title: 'Ubah PIN',
                              suffix: '*********',
                            ),
                            TileListProfile(
                              title: 'Ganti Bahasa',
                              suffix: 'Indonesia',
                              onPreseed: () =>
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
                                    builder: (BuildContext context) => const ChangeLagSheet(),
                                  ),
                            ),
                            TileListProfile(
                              title: 'Role',
                              suffix: '',
                              onPreseed: () =>
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
                                    builder: (BuildContext context) => const ChangeRoleSheet(),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp22),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: SpaceDims.sp32),
                        child:
                        Text("Info Lainnya", style: TypoSty.titlePrimary),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: SpaceDims.sp24,
                          vertical: SpaceDims.sp12,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: SpaceDims.sp22,
                        ),
                        decoration: BoxDecoration(
                          color: ColorSty.grey60,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          children: const [
                            TileListProfile(
                              top: false,
                              title: 'Device Info',
                              suffix: 'Iphone 13',
                            ),
                            TileListProfile(
                              title: 'Version',
                              suffix: '1.3',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: SpaceDims.sp22),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const SizedBox(
                          width: 204,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Log Out", style: TypoSty.button),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: SpaceDims.sp22),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoSheet extends StatelessWidget {
  const InfoSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TileListProfile extends StatefulWidget {
  final bool? top, bottom;
  final String title, suffix;
  final Function()? onPreseed;

  const TileListProfile({
    Key? key,
    this.top = true,
    this.bottom = false,
    required this.title,
    required this.suffix,
    this.onPreseed,
  }) : super(key: key);

  @override
  State<TileListProfile> createState() => _TileListProfileState();
}

class _TileListProfileState extends State<TileListProfile> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.top!
            ? Container(
          margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp18),
          width: double.infinity,
          color: ColorSty.grey,
          height: 2,
        )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceDims.sp18,
          ),
          child: TextButton(
            onPressed: widget.onPreseed ?? () =>
                showModalBottomSheet(
                  isScrollControlled: true,
                  barrierColor: ColorSty.grey.withOpacity(0.2),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                      )
                  ),
                  context: context,
                  builder: (BuildContext context) =>
                      BottomSheetDetailMenu(
                        title: widget.title,
                        content: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 100,
                                controller: _editingController,
                                decoration: InputDecoration(
                                  hintText: widget.suffix,
                                  contentPadding: const EdgeInsets.all(0),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                minimumSize: const Size(25.0, 25.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              child: const Icon(Icons.check, size: 26.0),
                            ),
                          ],
                        ),
                      ),
                ),
            style: TextButton.styleFrom(
              primary: ColorSty.black,
              padding: const EdgeInsets.all(SpaceDims.sp8),
              minimumSize: const Size(0, 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: TypoSty.captionSemiBold),
                Row(
                  children: [
                    Text(
                      widget.suffix,
                      style: TypoSty.caption.copyWith(fontSize: 14.0),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorSty.grey,
                      size: 16.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        widget.bottom!
            ? Container(
          margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp18),
          width: double.infinity,
          color: ColorSty.grey,
          height: 2,
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class ChangeLagSheet extends StatefulWidget {
  const ChangeLagSheet({Key? key}) : super(key: key);

  @override
  _ChangeLagSheetState createState() => _ChangeLagSheetState();
}

class _ChangeLagSheetState extends State<ChangeLagSheet> {
  bool _isIndo = true;

  @override
  Widget build(BuildContext context) {
    return BottomSheetDetailMenu(
      title: "Ganti Bahasa",
      heightGp: SpaceDims.sp12,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => setState(()=> _isIndo = true),
            style: ElevatedButton.styleFrom(
              primary: _isIndo ? ColorSty.primary : ColorSty.white,
              onPrimary: _isIndo ? ColorSty.white : ColorSty.black,
              padding: const EdgeInsets.all(SpaceDims.sp8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset("assert/image/ind-flag.png"),
                  const SizedBox(width: SpaceDims.sp12),
                  const Text("Indonesia", style: TypoSty.button)
                ],
              ),
            ),
          ),
          const SizedBox(width: SpaceDims.sp14),
          ElevatedButton(
            onPressed: () => setState(()=> _isIndo = false),
            style: ElevatedButton.styleFrom(
              primary: !_isIndo ? ColorSty.primary : ColorSty.white,
              onPrimary: !_isIndo ? ColorSty.white : ColorSty.black,
              padding: const EdgeInsets.all(SpaceDims.sp8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset("assert/image/eng-flag.png", height: 40),
                  const SizedBox(width: SpaceDims.sp12),
                  const Text("Inggris", style: TypoSty.button)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeRoleSheet extends StatefulWidget {
  const ChangeRoleSheet({Key? key}) : super(key: key);

  @override
  _ChangeRoleSheetState createState() => _ChangeRoleSheetState();
}

class _ChangeRoleSheetState extends State<ChangeRoleSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ProfileProviders(),
      builder: (context, snapshot) {
        final _role = Provider.of<ProfileProviders>(context).isKasir;

        return BottomSheetDetailMenu(
          title: "Ganti Bahasa",
          heightGp: SpaceDims.sp12,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Provider.of<ProfileProviders>(context, listen: false).changeRole(true),
                  style: ElevatedButton.styleFrom(
                    primary: _role ? ColorSty.primary : ColorSty.white,
                    onPrimary: _role ? ColorSty.white : ColorSty.black,
                    padding: const EdgeInsets.all(SpaceDims.sp12),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: ColorSty.primary),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Kasir", style: TypoSty.button),
                  ),
                ),
              ),
              const SizedBox(width: SpaceDims.sp14),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Provider.of<ProfileProviders>(context, listen: false).changeRole(false),
                  style: ElevatedButton.styleFrom(
                    primary: !_role ? ColorSty.primary : ColorSty.white,
                    onPrimary: !_role ? ColorSty.white : ColorSty.black,
                    padding: const EdgeInsets.all(SpaceDims.sp12),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: ColorSty.primary),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Pelanggan", style: TypoSty.button),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
