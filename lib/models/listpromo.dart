// To parse this JSON data, do
//
//     final listPromo = listPromoFromJson(jsonString);

import 'dart:convert';

ListPromo listPromoFromJson(String str) => ListPromo.fromJson(json.decode(str));

String listPromoToJson(ListPromo data) => json.encode(data.toJson());

class ListPromo {
  ListPromo({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  List<Promo> data;

  factory ListPromo.fromJson(Map<String, dynamic> json) => ListPromo(
    statusCode: json["status_code"],
    data: List<Promo>.from(json["data"].map((x) => Promo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Promo {
  Promo({
    required this.idPromo,
    required this.nama,
    this.diskon,
    this.nominal,
    required this.kadaluarsa,
    required this.syaratKetentuan,
    this.foto,
  });

  int idPromo;
  String nama;
  int? diskon;
  int? nominal;
  int kadaluarsa;
  String syaratKetentuan;
  String? foto;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
    idPromo: json["id_promo"],
    nama: json["nama"],
    diskon: json["diskon"],
    nominal: json["nominal"],
    kadaluarsa: json["kadaluarsa"],
    syaratKetentuan: json["syarat_ketentuan"],
    foto: json["foto"],
  );

  Map<String, dynamic> toJson() => {
    "id_promo": idPromo,
    "nama": nama,
    "diskon": diskon,
    "nominal": nominal,
    "kadaluarsa": kadaluarsa,
    "syarat_ketentuan": syaratKetentuan,
    "foto": foto,
  };
}
