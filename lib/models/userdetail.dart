// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    required this.statusCode,
    required this.data,
  });

  final int statusCode;
  final DUser data;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    statusCode: json["status_code"],
    data: DUser.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "data": data.toJson(),
  };
}

class DUser {
  DUser({
    required this.idUser,
    required this.nama,
    required this.tglLahir,
    required this.email,
    required this.alamat,
    required this.telepon,
    required this.foto,
    required this.username,
    required this.password,
    required this.ktp,
    required this.status,
    required this.mRolesId,
    required this.isDeleted,
  });

  final int idUser;
  final String nama;
  final dynamic tglLahir;
  final String email;
  final String alamat;
  final String telepon;
  final dynamic foto;
  final String username;
  final String password;
  final dynamic ktp;
  final int status;
  final int mRolesId;
  final int isDeleted;

  factory DUser.fromJson(Map<String, dynamic> json) => DUser(
    idUser: json["id_user"],
    nama: json["nama"],
    tglLahir: json["tgl_lahir"],
    email: json["email"],
    alamat: json["alamat"],
    telepon: json["telepon"],
    foto: json["foto"],
    username: json["username"],
    password: json["password"],
    ktp: json["ktp"],
    status: json["status"],
    mRolesId: json["m_roles_id"],
    isDeleted: json["is_deleted"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nama": nama,
    "tgl_lahir": tglLahir,
    "email": email,
    "alamat": alamat,
    "telepon": telepon,
    "foto": foto,
    "username": username,
    "password": password,
    "ktp": ktp,
    "status": status,
    "m_roles_id": mRolesId,
    "is_deleted": isDeleted,
  };
}
