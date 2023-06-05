class UserApiModel {
  int? code;
  String? message;
  List<Datum>? data;

  UserApiModel({
    this.code,
    this.message,
    this.data,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) => UserApiModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  String? name;
  String? birthday;
  String? email;
  String? telephone;
  String? gender;
  String? address;
  String? role;
  String? image;
  String? password;
  String? username;

  //Now let's create the constructor
  Datum({
    this.id,
    this.name,
    this.birthday,
    this.email,
    this.telephone,
    this.gender,
    this.address,
    this.role,
    this.image,
    this.password,
    this.username,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"].toString(),
        name: json["name"],
        birthday: json["birthday"],
        email: json["email"],
        telephone: json["telephone"],
        gender: json["gender"],
        address: json["address"],
        role: json["role"],
        image: json["image"],
        password: json["password"],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "birthday": birthday,
        "email": email,
        "telephone": telephone,
        "gender": gender,
        "address": address,
        "role": role,
        "image": image,
        "password": password,
        'username': username,
      };
}
