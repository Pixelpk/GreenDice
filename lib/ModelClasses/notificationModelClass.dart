class notifcationModelClass {

  int? success;
  String? message;
  Data? data;

  notifcationModelClass({this.success, this.message, this.data});

  notifcationModelClass.fromJson(Map<String, dynamic> json) {
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
  List<NotificationSignal>? notificationSignal;

  Data({required this.notificationSignal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notification_signal'] != null) {
      notificationSignal = [];
      json['notification_signal'].forEach((v) {
        notificationSignal!.add(new NotificationSignal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationSignal != null) {
      data['notification_signal'] =
          this.notificationSignal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationSignal {
  int? id;
  String? signalDate;
  String? location;
  int? raceId;
  String? horse;
  String? signalFloat;
  String? oods;
  String? stake;
  String? placing;
  int? status;
  String? returns;
  String? roi;
  String? balance;
  String? profit;
  String? createdAt;
String? comment;
  NotificationSignal(
      {this.id,
      this.signalDate,
      this.location,
      this.raceId,
        this.comment,
      this.horse,
      this.signalFloat,
      this.oods,
      this.stake,
      this.placing,
      this.status,
      this.returns,
      this.roi,
      this.balance,
      this.profit,
      this.createdAt});

  NotificationSignal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    signalDate = json['signal_date'];
    location = json['location'];
    raceId = json['race_id'];
    horse = json['horse'];
    signalFloat = json['signal_float'];
    oods = json['oods'];
    stake = json['stake'];
    placing = json['placing'];
    status = json['status'];
    returns = json['return'];
    roi = json['roi'];
    balance = json['balance'];
    profit = json['profit'];
    comment = json['comment'] ?? '';
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['signal_date'] = this.signalDate;
    data['location'] = this.location;
    data['race_id'] = this.raceId;
    data['horse'] = this.horse;
    data['signal_float'] = this.signalFloat;
    data['oods'] = this.oods;
    data['stake'] = this.stake;
    data['placing'] = this.placing;
    data['status'] = this.status;
    data['return'] = this.returns;
    data['roi'] = this.roi;
    data['balance'] = this.balance;
    data['profit'] = this.profit;
    data['created_at'] = this.createdAt;
    return data;
  }
}
