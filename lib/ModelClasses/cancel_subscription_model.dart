class CancelSubscription {
  int? success;
  String? message;
  Data? data;

  CancelSubscription({this.success, this.message, this.data});

  CancelSubscription.fromJson(Map<String, dynamic> json) {
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
  String? status;
  String? cancelAt;

  Data({this.status, this.cancelAt});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cancelAt = json['cancel_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['cancel_at'] = this.cancelAt;
    return data;
  }
}