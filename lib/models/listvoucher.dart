// To parse this JSON data, do
//
//     final listVoucher = listVoucherFromJson(jsonString);

import 'dart:convert';

DataListVoucher listVoucherFromJson(String str) => DataListVoucher.fromJson(json.decode(str));

String listVoucherToJson(DataListVoucher data) => json.encode(data.toJson());

class DataListVoucher {
  DataListVoucher({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final List<LVoucher> data;

  factory DataListVoucher.fromJson(Map<String, dynamic> json) => DataListVoucher(
    statusCode: json["status_code"],
    data: List<LVoucher>.from(json["data"].map((x) => LVoucher.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LVoucher {
  LVoucher({
    required this.idVoucher,
    required this.idPromo,
    required this.idUser,
    required this.nominal,
    required this.infoVoucher,
    required this.periodeMulai,
    required this.periodeSelesai,
    required this.jumlah,
    required this.catatan,
    required this.createdAt,
    required this.createdBy,
    required this.isDeleted,
    required this.nama,
  });

  final int idVoucher;
  final int idPromo;
  final int idUser;
  final int nominal;
  final String infoVoucher;
  final DateTime periodeMulai;
  final DateTime periodeSelesai;
  final int jumlah;
  final dynamic catatan;
  final DateTime createdAt;
  final int createdBy;
  final int isDeleted;
  final String nama;

  factory LVoucher.fromJson(Map<String, dynamic> json) => LVoucher(
    idVoucher: json["id_voucher"],
    idPromo: json["id_promo"],
    idUser: json["id_user"],
    nominal: json["nominal"],
    infoVoucher: json["info_voucher"],
    periodeMulai: DateTime.fromMicrosecondsSinceEpoch(json["periode_mulai"]),
    periodeSelesai: DateTime.fromMicrosecondsSinceEpoch(json["periode_selesai"]),
    jumlah: json["jumlah"],
    catatan: json["catatan"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    isDeleted: json["is_deleted"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id_voucher": idVoucher,
    "id_promo": idPromo,
    "id_user": idUser,
    "nominal": nominal,
    "info_voucher": infoVoucher,
    "periode_mulai": periodeMulai.toString(),
    "periode_selesai": periodeSelesai.toString(),
    "jumlah": jumlah,
    "catatan": catatan,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "is_deleted": isDeleted,
    "nama": nama,
  };
}
