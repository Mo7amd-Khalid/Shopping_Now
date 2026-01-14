class UserDataDto {
  UserDataDto({
      this.message, 
      this.decoded,});

  UserDataDto.fromJson(dynamic json) {
    message = json['message'];
    decoded = json['decoded'] != null ? Decoded.fromJson(json['decoded']) : null;
  }
  String? message;
  Decoded? decoded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (decoded != null) {
      map['decoded'] = decoded?.toJson();
    }
    return map;
  }

}

class Decoded {
  Decoded({
      this.id, 
      this.name, 
      this.role, 
      this.iat, 
      this.exp,});

  Decoded.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    iat = json['iat'];
    exp = json['exp'];
  }
  String? id;
  String? name;
  String? role;
  num? iat;
  num? exp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role'] = role;
    map['iat'] = iat;
    map['exp'] = exp;
    return map;
  }

}