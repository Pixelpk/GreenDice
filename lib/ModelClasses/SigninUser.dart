class SigninUser {
  int? success;
  String? message;
  Data? data;

  SigninUser({this.success, this.message, this.data});

  SigninUser.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  User? user;

  Data({this.accessToken, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? photo;
  int? status;
  String? verificationCode;
  String? createdAt;
  String? updatedAt;
  int? isYearlyPkg;
  int? isFourMonthPkg;
  int? isChairman;

  User(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.photo,
        this.status,
        this.verificationCode,
        this.createdAt,   this.isYearlyPkg,
        this.isFourMonthPkg,
        this.isChairman,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    photo = json['photo'] ?? '';
    status = json['status'];
    verificationCode = json['verification_code'];
    createdAt = json['created_at'];
    isYearlyPkg = json['is_yearly_pkg'];
    isFourMonthPkg = json['is_four_month_pkg'];
    isChairman = json['is_chairman'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['verification_code'] = this.verificationCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_yearly_pkg'] = this.isYearlyPkg;
    data['is_four_month_pkg'] = this.isFourMonthPkg;
    data['is_chairman'] = this.isChairman;

    return data;
  }
}
