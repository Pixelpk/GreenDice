class ForgotPassword {
  int? success;
  String? message;
  Data? data;

  ForgotPassword({this.success, this.message, this.data});

  ForgotPassword.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Token? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    return data;
  }
}

class Token {
  int? id;
  String? email;
  int? verificationCode;
  String? updatedAt;

  Token({this.id, this.email, this.verificationCode, this.updatedAt});

  Token.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    verificationCode = json['verification_code'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['verification_code'] = this.verificationCode;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
