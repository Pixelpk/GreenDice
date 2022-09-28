class CalDataModelClass {
  int? success;
  String? message;
  Data? data;

  CalDataModelClass({this.success, this.message, this.data});

  CalDataModelClass.fromJson(Map<String, dynamic> json) {
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
  List<CalenderSignal>? calenderSignal;

  Data({this.calenderSignal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['calender_signal'] != null) {
      calenderSignal = [];
      json['calender_signal'].forEach((v) { calenderSignal!.add(new CalenderSignal.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calenderSignal != null) {
      data['calender_signal'] = this.calenderSignal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalenderSignal {
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
  String? comment ;
  String? createdAt;
  bool? isexpanded = false ;
  CalenderSignal({this.id,this.isexpanded ,this.comment, this.signalDate, this.location, this.raceId, this.horse, this.signalFloat, this.oods, this.stake, this.placing, this.status, this.returns, this.roi, this.balance, this.profit, this.createdAt});

CalenderSignal.fromJson(Map<String, dynamic> json) {
id = json['id']?? 0 ;
signalDate = json['signal_date']??'';
location = json['location']??'';
raceId = json['race_id']?? 0 ;
horse = json['horse'] ?? '';
signalFloat = json['signal_float']?? '';
oods = json['oods']?? '';
stake = json['stake']?? '';
placing = json['placing']?? '';
status = json['status']?? 0;
returns = json['return']?? '';
roi = json['roi']?? '';
balance = json['balance']?? '';
comment = json['comment'] ??'';
profit = json['profit']?? '';
createdAt = json['created_at']?? '';
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