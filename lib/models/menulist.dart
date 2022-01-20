// To parse this JSON data, do
//
//     final menuList = menuListFromJson(jsonString);

import 'dart:convert';

MenuList menuListFromJson(String str) => MenuList.fromJson(json.decode(str));

String menuListToJson(MenuList data) => json.encode(data.toJson());

class MenuList {
  MenuList({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final List<DMenu> data;

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    statusCode: json["status_code"],
    data: List<DMenu>.from(json["data"].map((x) => DMenu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DMenu {
  DMenu({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    this.deskripsi,
    this.foto,
    required this.status,
  });

  final int idMenu;
  final String nama;
  final String kategori;
  final int harga;
  final String? deskripsi;
  final String? foto;
  final int status;

  factory DMenu.fromJson(Map<String, dynamic> json) => DMenu(
    idMenu: json["id_menu"],
    nama: json["nama"],
    kategori: json["kategori"],
    harga: json["harga"],
    deskripsi: json["deskripsi"],
    foto: json["foto"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id_menu": idMenu,
    "nama": nama,
    "kategori": kategori,
    "harga": harga,
    "deskripsi": deskripsi,
    "foto": foto,
    "status": status,
  };
}
