class UserContentResponse {
  int code;
  String message;
  List<Data> data;

  UserContentResponse({this.code, this.message, this.data});

  UserContentResponse.fromJson(Map<String, dynamic> json) {
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
  Null gambar;
  String content;
  String createAt;
  int idUser;
  int idResponder;
  int aktif;
  String namaResponden;
  String namaUser;
  int jmlComment;

  Data(
      {this.id,
        this.gambar,
        this.content,
        this.createAt,
        this.idUser,
        this.idResponder,
        this.aktif,
        this.namaResponden,
        this.namaUser,
        this.jmlComment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gambar = json['gambar'];
    content = json['content'];
    createAt = json['create_at'];
    idUser = json['id_user'];
    idResponder = json['id_responder'];
    aktif = json['aktif'];
    namaResponden = json['namaResponden'];
    namaUser = json['namaUser'];
    jmlComment = json['jmlComment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gambar'] = this.gambar;
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['id_user'] = this.idUser;
    data['id_responder'] = this.idResponder;
    data['aktif'] = this.aktif;
    data['namaResponden'] = this.namaResponden;
    data['namaUser'] = this.namaUser;
    data['jmlComment'] = this.jmlComment;
    return data;
  }
}