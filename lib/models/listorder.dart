// To parse this JSON data, do
//
//     final listOrder = listOrderFromJson(jsonString);

import 'dart:convert';

ListOrder listOrderFromJson(String str) => ListOrder.fromJson(json.decode(str));

String listOrderToJson(ListOrder data) => json.encode(data.toJson());

class ListOrder {
  ListOrder({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final List<Order> data;

  factory ListOrder.fromJson(Map<String, dynamic> json) => ListOrder(
    statusCode: json["status_code"],
    data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    required this.idOrder,
    required this.noStruk,
    required this.nama,
    required this.tanggal,
    required this.totalBayar,
    required this.status,
  });

  final int idOrder;
  final String noStruk;
  final String nama;
  final DateTime tanggal;
  final int totalBayar;
  final int status;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    idOrder: json["id_order"],
    noStruk: json["no_struk"],
    nama: json["nama"],
    tanggal: DateTime.parse(json["tanggal"]),
    totalBayar: json["total_bayar"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id_order": idOrder,
    "no_struk": noStruk,
    "nama": nama,
    "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "total_bayar": totalBayar,
    "status": status,
  };
}
