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
  final String bottomNav1, bottomNav2, bottomNav3;

  BottomNav({
    required this.bottomNav1,
    required this.bottomNav2,
    required this.bottomNav3,
  });

  factory BottomNav.fromJson(Map<String, dynamic> json) => BottomNav(
        bottomNav1: json["bottomNav1"],
        bottomNav2: json["bottomNav2"],
        bottomNav3: json["bottomNav3"],
      );

  Map<String, dynamic> toJson() => {
        "bottomNav1": bottomNav1,
        "bottomNav2": bottomNav2,
        "bottomNav3": bottomNav3,
      };
}
