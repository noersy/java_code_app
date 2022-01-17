// To parse this JSON data, do
//
//     final menuDetail = menuDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MenuDetail menuDetailFromJson(String str) => MenuDetail.fromJson(json.decode(str));

String menuDetailToJson(MenuDetail data) => json.encode(data.toJson());

class MenuDetail {
  MenuDetail({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final Data data;

  factory MenuDetail.fromJson(Map<String, dynamic> json) => MenuDetail(
    statusCode: json["status_code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.menu,
    required this.detail,
  });

  final Menu menu;
  final List<Detail> detail;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    menu: Menu.fromJson(json["menu"]),
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "menu": menu.toJson(),
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
    required this.isDeleted,
  });

  final int idDetail;
  final int idMenu;
  final String keterangan;
  final String type;
  final int harga;
  final int isDeleted;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    idDetail: json["id_detail"],
    idMenu: json["id_menu"],
    keterangan: json["keterangan"],
    type: json["type"],
    harga: json["harga"],
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id_detail": idDetail,
    "id_menu": idMenu,
    "keterangan": keterangan,
    "type": type,
    "harga": harga,
    "is_deleted": isDeleted,
  };
}

class Menu {
  Menu({
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

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
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
