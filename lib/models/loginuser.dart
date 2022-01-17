// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final Data data;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
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
    required this.user,
    required this.token,
  });

  final User user;
  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  User({
    required this.idUser,
    required this.username,
    required this.nama,
    required this.mRolesId,
    required this.akses,
  });

  final int idUser;
  final String username;
  final String nama;
  final int mRolesId;
  final Akses akses;

  factory User.fromJson(Map<String, dynamic> json) => User(
    idUser: json["id_user"],
    username: json["username"],
    nama: json["nama"],
    mRolesId: json["m_roles_id"],
    akses: Akses.fromJson(json["akses"]),
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "username": username,
    "nama": nama,
    "m_roles_id": mRolesId,
    "akses": akses.toJson(),
  };
}

class Akses {
  Akses({
    required this.masterRoles,
    required this.masterUser,
    required this.masterAkses,
    required this.penggunaAkses,
    required this.penggunaUser,
    required this.appTransaksi1,
    required this.laporanLaporan1,
  });

  final bool masterRoles;
  final bool masterUser;
  final bool masterAkses;
  final bool penggunaAkses;
  final bool penggunaUser;
  final bool appTransaksi1;
  final bool laporanLaporan1;

  factory Akses.fromJson(Map<String, dynamic> json) => Akses(
    masterRoles: json["master_roles"],
    masterUser: json["master_user"],
    masterAkses: json["master_akses"],
    penggunaAkses: json["pengguna_akses"],
    penggunaUser: json["pengguna_user"],
    appTransaksi1: json["app_transaksi1"],
    laporanLaporan1: json["laporan_laporan1"],
  );

  Map<String, dynamic> toJson() => {
    "master_roles": masterRoles,
    "master_user": masterUser,
    "master_akses": masterAkses,
    "pengguna_akses": penggunaAkses,
    "pengguna_user": penggunaUser,
    "app_transaksi1": appTransaksi1,
    "laporan_laporan1": laporanLaporan1,
  };
}
