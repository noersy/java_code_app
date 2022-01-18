// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    required this.statusCode,
    required this.data,
  });

  int statusCode;
  DUser data;

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
    required this.email,
    this.tglLahir,
    this.alamat,
    this.telepon,
    this.foto,
    this.ktp,
    required this.status,
    required this.mRolesId,
  });

  int idUser;
  String nama;
  String email;
  String? alamat;
  String? tglLahir;
  String? telepon;
  String? foto;
  String? ktp;
  int status;
  int mRolesId;

  factory DUser.fromJson(Map<String, dynamic> json) => DUser(
    idUser: json["id_user"],
    nama: json["nama"],
    email: json["email"],
    tglLahir: json["tgl_lahir"],
    alamat: json["alamat"],
    telepon: json["telepon"],
    foto: json["foto"],
    ktp: json["ktp"],
    status: json["status"],
    mRolesId: json["m_roles_id"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "nama": nama,
    "email": email,
    "tgl_lahir": tglLahir,
    "alamat": alamat,
    "telepon": telepon,
    "foto": foto,
    "ktp": ktp,
    "status": status,
    "m_roles_id": mRolesId,
  };
}
