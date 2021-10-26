class SubscriptionPackages  {
  int? success;
  String? message;
  Data? data;

  SubscriptionPackages ({this.success, this.message, this.data});

  SubscriptionPackages .fromJson(Map<String, dynamic> json) {
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
  List<Packages>? packages;

  Data({this.packages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages =[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  int? id;
  String? name;
  int ?type;
  int ?price;
  String? priceId;
  int ?status;
  String? createdAt;
  String ?updatedAt;

  Packages(
      {this.id,
        this.name,
        this.type,
        this.price,
        this.priceId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Packages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'] ?? 0;
    price = json['price'];
    priceId = json['price_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['price_id'] = this.priceId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}