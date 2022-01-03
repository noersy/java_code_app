import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset("assert/image/bg_login.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 80.0),
                    Image.asset("assert/image/javacode_logo.png"),
                    const SizedBox(height: 90.0),
                    const SizedBox(
                      width: 339.0,
                      child: Text('Masuk untuk melanjutkan!',
                          style: TypoSty.title),
                    ),
                    const SizedBox(height: 30.0),
                    FormLogin(
                      title: 'Alamat Email',
                      hint: 'Lorem.ipsum@gmail.com',
                      type: TextInputType.emailAddress,
                      editingController: _controllerEmail,
                    ),
                    const SizedBox(height: 30.0),
                    FormLogin(
                      title: 'Kata Sandi',
                      hint: '****************',
                      type: TextInputType.visiblePassword,
                      editingController: _controllerPassword,
                    ),
                    const SizedBox(height: 30.0),
                    const ButtonLogin(
                      title: 'Masuk',
                      bgColors: ColorSty.primary,
                    ),
                    const SizedBox(height: 40.0),
                    Row(
                      children: const [
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: ColorSty.grey),
                            child: SizedBox(height: 1),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
                          child: Text("atau", style: TypoSty.caption2),
                        ),
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: ColorSty.grey),
                            child: SizedBox(height: 1),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpaceDims.sp16),
                    const ButtonLogin(
                      title: 'Masuk menggunakan',
                      boldTitle: "Google",
                      bgColors: ColorSty.white,
                      icon: "assert/image/icon_google.png",
                    ),
                    const SizedBox(height: SpaceDims.sp8),
                    const ButtonLogin(
                      title: 'Masuk menggunakan',
                      boldTitle: "Apple",
                      icon: "assert/image/icon_apple.png",
                      bgColors: ColorSty.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonLogin extends StatelessWidget {
  final String? icon;
  final Color bgColors;
  final String title;

  const ButtonLogin({
    Key? key,
    this.icon,
    this.boldTitle,
    required this.bgColors,
    required this.title,
  }) : super(key: key);

  final String? boldTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: bgColors,
        padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(144.0),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: SpaceDims.sp12),
                child: Image.asset(icon!),
              ),
            Text(
              title,
              style: TypoSty.button.copyWith(
                fontWeight: boldTitle == null ? FontWeight.bold : null,
                color: ColorSty.white != bgColors
                    ? ColorSty.white
                    : ColorSty.black,
              ),
            ),
            if (boldTitle != null)
              Text(
                " " + boldTitle!,
                style: TypoSty.button.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorSty.white != bgColors
                      ? ColorSty.white
                      : ColorSty.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  final TextEditingController editingController;
  final String title, hint;
  final TextInputType type;

  const FormLogin({
    Key? key,
    required this.editingController,
    required this.title,
    required this.hint,
    required this.type,
  }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TypoSty.caption),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            TextFormField(
              controller: widget.editingController,
              keyboardType: widget.type,
              obscureText:
                  widget.type == TextInputType.visiblePassword && isHide
                      ? true
                      : false,
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hint,
                hintStyle: TypoSty.caption2,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: SpaceDims.sp8),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorSty.primary),
                ),
              ),
            ),
            if (widget.type == TextInputType.visiblePassword)
              GestureDetector(
                onTap: () => setState(() => isHide = !isHide),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isHide ? Icons.visibility_off : Icons.visibility,
                    color: ColorSty.grey,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
