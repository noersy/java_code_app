import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:java_code_app/providers/lang_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/widget/appbar/appbar.dart';
import 'package:provider/provider.dart';

class DaftarPenilaian extends StatefulWidget {
  const DaftarPenilaian({Key? key}) : super(key: key);

  @override
  _DaftarPenilaianState createState() => _DaftarPenilaianState();
}

class _DaftarPenilaianState extends State<DaftarPenilaian> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: LangProviders(),
        builder: (context, snapshot) {
          final lang = Provider.of<LangProviders>(context).lang;
          return Scaffold(
            appBar: CostumeAppBar(
              title: '',
              profileTitle: 'Daftar Penilaian',
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
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigate.toPenilaian(context),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assert/image/icons/kalender.svg",
                                                ),
                                                Text(
                                                  'Penyajian Makanan',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 1, 154, 173)),
                                                ),
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
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: Text(
                                              'keterangan  ',
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            }),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFFF6F6F6),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 10, top: 10),
                        //         child: Row(
                        //           children: [
                        //             SvgPicture.asset(
                        //               "assert/image/icons/kalender.svg",
                        //             ),
                        //             Text(
                        //               'Penyajian Makanan',
                        //               style: TextStyle(
                        //                   color:
                        //                       Color.fromARGB(255, 1, 154, 173)),
                        //             ),
                        //             Image.asset(
                        //                 'assert/image/icons/star_yellow.png'),
                        //             Image.asset(
                        //                 'assert/image/icons/star_yellow.png'),
                        //             Image.asset(
                        //                 'assert/image/icons/star_yellow.png'),
                        //             Image.asset(
                        //                 'assert/image/icons/star_yellow.png'),
                        //             SvgPicture.asset(
                        //               "assert/image/icons/star_gray.svg",
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 10, bottom: 10),
                        //         child: Text(
                        //           'keterangan  ',
                        //           textAlign: TextAlign.start,
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
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
