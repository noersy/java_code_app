import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

class Penilaian extends StatefulWidget {
  const Penilaian({Key? key}) : super(key: key);

  @override
  _PenilaianState createState() => _PenilaianState();
}

class _PenilaianState extends State<Penilaian> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          final lang = Provider.of<LangProviders>(context).lang;
          return Scaffold(
            appBar: const CostumeAppBar(
              title: '',
              profileTitle: 'Penilaian',
              // profileTitle: lang.profile.title,
              back: true,
            ),
            body: Stack(
              children: [
                Image.asset("assert/image/bg_daftarpenilaian.png"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: Text(
                                        'Berikan Penilaianmu',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                  'assert/image/icons/star_yellow.png'),
                                              Image.asset(
                                                  'assert/image/icons/star_yellow.png'),
                                              Image.asset(
                                                  'assert/image/icons/star_yellow.png'),
                                              Image.asset(
                                                  'assert/image/icons/star_yellow.png'),
                                              SvgPicture.asset(
                                                "assert/image/icons/star_gray.svg",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: const Text('Hampir Sempurna'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    const Text('Apa yang bisa ditingkatkan?'),
                                    Wrap(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Harga')),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Rasa')),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                                'Penyajian Makanan')),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Pelayanan')),
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text('Fasilitas')),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Divider(
                                        thickness: 2,
                                      ),
                                    ),
                                    Text('Tulis Review'),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 5,
                                        initialValue:
                                            'Mohon Menjaga Kebersihan, Kemarin Meja Masih Kotor',
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: '',
                                            fillColor: Colors.white,
                                            filled: true),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Kirim Penilaian')),
                                        RawMaterialButton(
                                          onPressed: () {},
                                          elevation: 2.0,
                                          fillColor: Colors.white,
                                          child: Icon(
                                            Icons.pause,
                                            size: 12.0,
                                          ),
                                          padding: EdgeInsets.all(15.0),
                                          shape: CircleBorder(),
                                        )
                                      ],
                                    )
                                    // TextFormField(
                                    //   style: TextStyle(fontSize: 12),
                                    //   maxLines: 5,
                                    //   initialValue:
                                    //       'Mohon Menjaga Kebersihan, Kemarin Meja Masih Kotor',
                                    //   decoration: InputDecoration(
                                    //       border: OutlineInputBorder(),
                                    //       hintText: '',
                                    //       fillColor: Colors.white),
                                    // )
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
