class ResultsModelClass {
  int? success;
  String? message;
  Data? data;

  ResultsModelClass({this.success, this.message, this.data});

  ResultsModelClass.fromJson(Map<String, dynamic> json) {
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
  GraphData? graphData;

  Data({this.graphData});

  Data.fromJson(Map<String, dynamic> json) {
    graphData = json['graph_data'] != null
        ? new GraphData.fromJson(json['graph_data'])
        : null;
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
  List<LastWeekProfit>? lastWeekProfit;
  List<CurrentYearRoi>? currentYearRoi;
  List<LastYearRoi>? lastYearRoi;

  GraphData(
      {this.yearlyProfit,
        this.lastWeekProfit,
        this.currentYearRoi,
        this.lastYearRoi});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['yearly_profit'] != null) {
      yearlyProfit = [];
      json['yearly_profit'].forEach((v) {
        yearlyProfit!.add(new YearlyProfit.fromJson(v));
      });
    }
    if (json['last_week_profit'] != null) {
      lastWeekProfit = [];
      json['last_week_profit'].forEach((v) {
        lastWeekProfit!.add(new LastWeekProfit.fromJson(v));
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
    if (this.lastWeekProfit != null) {
      data['last_week_profit'] =
          this.lastWeekProfit!.map((v) => v.toJson()).toList();
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
  String? month;
  String? profit;

  YearlyProfit({this.month, this.profit});

  YearlyProfit.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    profit = json['profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['profit'] = this.profit;
    return data;
  }
}

class LastWeekProfit {
  int? id;
  String? signalDate;
  String? profit;
  String? year;
  String? month;
  String? day;

  LastWeekProfit(
      {this.id, this.signalDate, this.profit, this.year, this.month, this.day});

  LastWeekProfit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    signalDate = json['signal_date'];
    profit = json['profit'];
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['signal_date'] = this.signalDate;
    data['profit'] = this.profit;
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    return data;
  }
}

class CurrentYearRoi {
  String? month;
  String? roi;

  CurrentYearRoi({this.month, this.roi});

  CurrentYearRoi.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    roi = json['roi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['roi'] = this.roi;
    return data;
  }

}


class LastYearRoi {
  String? month;
  String? roi;

  LastYearRoi({this.month, this.roi});

  LastYearRoi.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    roi = json['roi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['roi'] = this.roi;
    return data;
  }
}