class LoginResponse {
  LoginResponse({
    this.status,
    this.content,});

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    content = json['data'] != null ? Content.fromJson(json['data']) : null;
  }
  bool? status;
  Content? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (content != null) {
      map['data'] = content?.toJson();
    }
    return map;
  }

}


class Content {
  Content({this.token, this.user});

  Content.fromJson(dynamic json) {
    token = json['token'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null);
  }

  String? token;
  User? user;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}
class User {
  User({this.name,this.EmpCode,this.doj});

  User.fromJson(dynamic json) {
    name = json['name'];
    EmpCode = json['EmpCode'];
    doj = json['doj'];
  }

  String? name;
  String? EmpCode;
  String? doj;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['EmpCode'] = EmpCode;
    map['doj'] = doj;
    return map;
  }

}