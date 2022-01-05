import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/widget/button_login.dart';
import 'package:java_code_app/widget/form_login.dart';

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
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Image.asset("assert/image/bg_login.png"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 46.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 80.0),
                    Image.asset("assert/image/javacode_logo.png"),
                    const SizedBox(height: 90.0),
                     SizedBox(
                      width: 339.0,
                      child: Text('Masuk untuk melanjutkan!',
                          style: TypoSty.title,
                      ),
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
                    ButtonLogin(
                      title: 'Masuk',
                      onPressed: ()=> Navigate.toFindLocation(context),
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
                    ButtonLogin(
                      title: 'Masuk menggunakan',
                      boldTitle: "Google",
                      bgColors: ColorSty.white,
                      icon: "assert/image/icon_google.png",
                      onPressed: () {},
                    ),
                    const SizedBox(height: SpaceDims.sp8),
                    ButtonLogin(
                      title: 'Masuk menggunakan',
                      boldTitle: "Apple",
                      icon: "assert/image/icon_apple.png",
                      bgColors: ColorSty.black,
                      onPressed: () {},
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
