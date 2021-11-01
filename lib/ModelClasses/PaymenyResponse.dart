class PaymentResponse {
  int ?success;
  String? message;
  Data? data;

  PaymentResponse({this.success, this.message, this.data});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
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
  Subscription? subscription;

  Data({this.subscription});

  Data.fromJson(Map<String, dynamic> json) {
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    return data;
  }
}

class Subscription {
  String? customerId;
  String? paymentId;
  String? subcriptionId;
  String? status;

  Subscription(
      {this.customerId, this.paymentId, this.subcriptionId, this.status});

  Subscription.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    subcriptionId = json['subcription_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['payment_id'] = this.paymentId;
    data['subcription_id'] = this.subcriptionId;
    data['status'] = this.status;
    return data;
  }
}