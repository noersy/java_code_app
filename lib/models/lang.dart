import 'dart:convert';

Lang lagFromJson(String str) => Lang.fromJson(json.decode(str));

String lagToJson(Lang data) => json.encode(data.toJson());

class Lang {
  final BottomNav bottomNav;

  Lang({
    required this.bottomNav,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
        bottomNav: json["bottomNav"],
      );

  Map<String, dynamic> toJson() => {
        "bottomNav": bottomNav.toJson(),
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
