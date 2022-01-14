// To parse this JSON data, do
//
//     final menuList = menuListFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

MenuList menuListFromJson(String str) => MenuList.fromJson(json.decode(str));

String menuListToJson(MenuList data) => json.encode(data.toJson());

class MenuList {
  MenuList({
    required this.data,
  });

  final List<MenuCard> data;

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    data: List<MenuCard>.from(json["data"].map((x) => MenuCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MenuCard {
  MenuCard({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.foto,
    required this.harga,
    required this.deskripsi,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.createdBy,
  });

  final int idMenu;
  final String nama;
  final String kategori;
  final dynamic foto;
  final int harga;
  final String deskripsi;
  final int status;
  final int isDeleted;
  final int createdAt;
  final int createdBy;

  factory MenuCard.fromJson(Map<String, dynamic> json) => MenuCard(
    idMenu: json["id_menu"],
    nama: json["nama"],
    kategori: json["kategori"],
    foto: json["foto"],
    harga: json["harga"],
    deskripsi: json["deskripsi"],
    status: json["status"],
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id_menu": idMenu,
    "nama": nama,
    "kategori": kategori,
    "foto": foto,
    "harga": harga,
    "deskripsi": deskripsi,
    "status": status,
    "is_deleted": isDeleted,
    "created_at": createdAt,
    "created_by": createdBy,
  };
}
