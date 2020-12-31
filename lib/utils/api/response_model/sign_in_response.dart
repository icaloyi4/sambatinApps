class UserResponse {
  int code;
  String message;
  List<Data> data;

  UserResponse({this.code, this.message, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String nama;
  String telpon;
  String email;
  int roleId;
  String roleName;
  String tglLahir;
  Null foto;

  Data(
      {this.id,
        this.nama,
        this.telpon,
        this.email,
        this.roleId,
        this.roleName,
        this.tglLahir,
        this.foto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    telpon = json['telpon'];
    email = json['email'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    tglLahir = json['tgl_lahir'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['telpon'] = this.telpon;
    data['email'] = this.email;
    data['roleId'] = this.roleId;
    data['roleName'] = this.roleName;
    data['tgl_lahir'] = this.tglLahir;
    data['foto'] = this.foto;
    return data;
  }
}