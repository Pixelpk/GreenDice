class EBookModelClass {
  int? success;
  String? message;
  Data? data;

  EBookModelClass({this.success, this.message, this.data});

  EBookModelClass.fromJson(Map<String, dynamic> json) {
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
  List<Ebooks>? ebooks;

  Data({this.ebooks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ebooks'] != null) {
      ebooks = [];
      json['ebooks'].forEach((v) {
        ebooks!.add(new Ebooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ebooks != null) {
      data['ebooks'] = this.ebooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ebooks {
  int? id;
  String? name;
  String? description;
  String? fileName;
  int? status;
  String? createdAt;
  String? updatedAt;

  Ebooks(
      {this.id,
        this.name,
        this.description,
        this.fileName,
        this.status,
        this.createdAt,
        this.updatedAt});

  Ebooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    fileName = json['file_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['file_name'] = this.fileName;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}