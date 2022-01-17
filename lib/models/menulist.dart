// To parse this JSON data, do
//
//     final menuList = menuListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MenuList menuListFromJson(String str) => MenuList.fromJson(json.decode(str));

String menuListToJson(MenuList data) => json.encode(data.toJson());

class MenuList {
  MenuList({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final List<MenuCard> data;

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
    statusCode: json["status_code"],
    data: List<MenuCard>.from(json["data"].map((x) => MenuCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MenuCard {
  MenuCard({
    required this.idMenu,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.foto,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.createdBy,
  });

  final int idMenu;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final dynamic foto;
  final int status;
  final int isDeleted;
  final DateTime createdAt;
  final int createdBy;

  factory MenuCard.fromJson(Map<String, dynamic> json) => MenuCard(
    idMenu: json["id_menu"],
    nama: json["nama"],
    kategori: json["kategori"],
    harga: json["harga"],
    deskripsi: json["deskripsi"],
    foto: json["foto"],
    status: json["status"],
    isDeleted: json["is_deleted"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id_menu": idMenu,
    "nama": nama,
    "kategori": kategori,
    "harga": harga,
    "deskripsi": deskripsi,
    "foto": foto,
    "status": status,
    "is_deleted": isDeleted,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
  };
}
