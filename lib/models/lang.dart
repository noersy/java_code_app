import 'dart:convert';

Lang lagFromJson(String str) => Lang.fromJson(json.decode(str));

String lagToJson(Lang data) => json.encode(data.toJson());

class Lang {
  final BottomNav bottomNav;
  final LangProfile profile;

  Lang({
    required this.bottomNav,
    required this.profile,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
        bottomNav: json["bottomNav"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "bottomNav": bottomNav.toJson(),
        "profile": profile.toJson(),
      };
}

class BottomNav {
  final String nav1, nav2, nav3;

  BottomNav({
    required this.nav1,
    required this.nav2,
    required this.nav3,
  });

  factory BottomNav.fromJson(Map<String, dynamic> json) => BottomNav(
        nav1: json["bottomNav1"],
        nav2: json["bottomNav2"],
        nav3: json["bottomNav3"],
      );

  Map<String, dynamic> toJson() => {
        "bottomNav1": nav1,
        "bottomNav2": nav2,
        "bottomNav3": nav3,
      };
}

class LangProfile {
  final String nam, tgl, tlp, ub, role;
  final String title, title2, caption;

  LangProfile({
    required this.nam,
    required this.tgl,
    required this.tlp,
    required this.ub,
    required this.role,
    required this.title,
    required this.title2,
    required this.caption,
  });

  factory LangProfile.fromJson(Map<String, dynamic> json) => LangProfile(
        nam: json["nam"],
        tgl: json["tgl"],
        tlp: json["tlp"],
        role: json["role"],
        ub: json["ub"],
        title: json["title"],
        title2: json["title2"],
        caption: json["caption"],
      );

  Map<String, dynamic> toJson() => {
        "nam": nam,
        "tgl": tgl,
        "tlp": tlp,
        "ub": ub,
        "role": role,
        "title": title,
        "title2": title2,
        "caption": caption,
      };
}

class LangPesanan {
  final String tap, tap2, ongoingCaption;

  LangPesanan({
    required this.tap,
    required this.tap2,
    required this.ongoingCaption,
  });

  factory LangPesanan.fromJson(Map<String, dynamic> json) => LangPesanan(
        tap: json["tap"],
        tap2: json["tap2"],
        ongoingCaption: json["ongoingTitle"],
      );

  Map<String, dynamic> toJson() => {
        "tap": tap,
        "tap2": tap2,
        "ongoingTitle": ongoingCaption,
      };
}
