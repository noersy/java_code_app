import 'package:java_code_app/models/lang.dart';

class ConstLang {
  static Lang eng = Lang(
    bottomNav: BottomNav(
      nav1: "Home",
      nav2: "Orders",
      nav3: "Profile",
    ),
    profile: LangProfile(
      nam: "Name",
      tgl: "Date",
      tlp: "No.Telephone",
      ub: "Change",
      role: "Role",
      title: "Info Account",
      title2: "Info Other",
      caption: "You have verified your ID card"
    ),
  );

  static Lang ind = Lang(
    bottomNav: BottomNav(
      nav1: "Beranda",
      nav2: "Pesanan",
      nav3: "Profile",
    ),
    profile: LangProfile(
      nam: "Nama",
      tgl: "Tanggal",
      tlp: "No.Telepon",
      ub: "Ubah",
      role: "Peran",
      title: "Info Akun",
      title2: "Info lainya",
      caption: "Kamu sudah verifikasi KTP"
    ),
  );
}
