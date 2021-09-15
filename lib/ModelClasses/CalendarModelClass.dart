class CalendarModelClass {
  int? success;
  String? message;
  Data? data;

  CalendarModelClass({required this.success, required this.message, required this.data});

  CalendarModelClass.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
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
  GraphData? graphData;

  Data({this.graphData});

  Data.fromJson(Map<String, dynamic> json) {
    graphData = (json['graph_data'] != null
        ? new GraphData.fromJson(json['graph_data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.graphData != null) {
      data['graph_data'] = this.graphData!.toJson();
    }
    return data;
  }
}

class GraphData {
  List<YearlyProfit>? yearlyProfit;
  List<CurrentYearRoi>? currentYearRoi;
  List<LastYearRoi>? lastYearRoi;

  GraphData({required this.yearlyProfit, required this.currentYearRoi, required this.lastYearRoi});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['yearly_profit'] != null) {
      yearlyProfit = [];
      json['yearly_profit'].forEach((v) {
        yearlyProfit!.add(new YearlyProfit.fromJson(v));
      });
    }
    if (json['current_year_roi'] != null) {
      currentYearRoi = [];
      json['current_year_roi'].forEach((v) {
        currentYearRoi!.add(new CurrentYearRoi.fromJson(v));
      });
    }
    if (json['last_year_roi'] != null) {
      lastYearRoi = [];
      json['last_year_roi'].forEach((v) {
        lastYearRoi!.add(new LastYearRoi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yearlyProfit != null) {
      data['yearly_profit'] = this.yearlyProfit!.map((v) => v.toJson()).toList();
    }
    if (this.currentYearRoi != null) {
      data['current_year_roi'] =
          this.currentYearRoi!.map((v) => v.toJson()).toList();
    }
    if (this.lastYearRoi != null) {
      data['last_year_roi'] = this.lastYearRoi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YearlyProfit {
  int? id;
  String? signalDate;
  String? profit;

  YearlyProfit({required this.id, required this.signalDate, required this.profit});

  YearlyProfit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    signalDate = json['signal_date'];
    profit = json['profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['signal_date'] = this.signalDate;
    data['profit'] = this.profit;
    return data;
  }
}

class CurrentYearRoi {
  int? id;
  String? roi;
  String? signalDate;

  CurrentYearRoi({this.id, this.roi, this.signalDate});

  CurrentYearRoi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roi = json['roi'];
    signalDate = json['signal_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roi'] = this.roi;
    data['signal_date'] = this.signalDate;
    return data;
  }
}



class LastYearRoi {
  int? id;
  String? roi;
  String? signalDate;

  LastYearRoi({this.id, this.roi, this.signalDate});

  LastYearRoi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roi = json['roi'];
    signalDate = json['signal_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roi'] = this.roi;
    data['signal_date'] = this.signalDate;
    return data;
  }
}