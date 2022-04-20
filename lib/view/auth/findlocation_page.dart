import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code_app/constans/key_prefens.dart';
import 'package:java_code_app/constans/try_api.dart';
import 'package:java_code_app/providers/auth_providers.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/providers/location_provider.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/singletons/shared_preferences.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:provider/provider.dart';

class FindLocationPage extends StatefulWidget {
  const FindLocationPage({Key? key}) : super(key: key);

  @override
  State<FindLocationPage> createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {
  final Preferences _preferences = Preferences.getInstance();

  _startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }

  void _navigationPage() async {
    bool _isAlreadyLogin = await _preferences.getBoolValue(KeyPrefens.login);
    await Provider.of<LangProviders>(context, listen: false).checkLangPref();
    if (_isAlreadyLogin) {
      Navigate.toDashboard(context);
    } else {
      Navigate.toLogin(context);
    }
  }

  getAddress() async {
    await Provider.of<LocationProvider>(context, listen: false)
        .determinePosition();
    await Provider.of<LocationProvider>(context, listen: false)
        .getAddressFromLatLng();
    _startTime();
  }

  Future _checkPrefens() async {
    await checkConnection().then((value) async {
      if (value) {
        bool _isAlreadyLogin =
            await _preferences.getBoolValue(KeyPrefens.login);
        if (_isAlreadyLogin) {
          final id = await _preferences.getIntValue(KeyPrefens.loginID);
          await Provider.of<AuthProviders>(context, listen: false)
              .getUser(context, id: id);
        }
      } else {
        Provider.of<OrderProviders>(context, listen: false).setNetworkError(
          true,
          context: context,
          title: 'Koneksi anda terputus',
          then: () => _checkPrefens(),
        );
      }
    });
  }

  @override
  void initState() {
    _checkPrefens().then((value) => getAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safeTopPadding = MediaQuery.of(context).padding.vertical;
    final height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(builder: () {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: height <= 780 ? height + safeTopPadding + 20 : height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35.0.w,
                        vertical: 35.0.h,
                      ),
                      child: Image.asset('assert/image/bg_findlocation.png'),
                    ),
                  ),
                  SizedBox(
                    height: 460.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (Provider.of<LocationProvider>(context)
                                .currentAddress ==
                            null)
                          Text(
                            "Mencari Lokasimu ...",
                            textAlign: TextAlign.center,
                            style: TypoSty.title2,
                          ),
                        const SizedBox(height: SpaceDims.sp2),
                        Image.asset("assert/image/maps_ilustrasion.png"),
                        const SizedBox(height: SpaceDims.sp24),
                        const SizedBox(height: SpaceDims.sp24),
                        if (Provider.of<LocationProvider>(context)
                                .currentAddress !=
                            null)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpaceDims.sp16,
                            ),
                            child: Text(
                              "${Provider.of<LocationProvider>(context).currentAddress}",
                              textAlign: TextAlign.center,
                              style: TypoSty.title.copyWith(fontSize: 18.0),
                            ),
                          ),
                        const SizedBox(height: SpaceDims.sp24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
