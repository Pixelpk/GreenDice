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
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['success'] = this.success;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  GraphData? graphData;

  Data({this.graphData});

  Data.fromJson(Map<String, dynamic> json) {
    graphData = json['graph_data'] != null
        ? new GraphData.fromJson(json['graph_data'])
        : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.graphData != null) {
  //     data['graph_data'] = this.graphData!.toJson();
  //   }
  //   return data;
  // }
}

class GraphData {
  List<CurrentYearProfit>? currentYearProfit= [];
  List<LastYearProfit>? lastYearProfit= [];


  GraphData(
      {this.currentYearProfit,
        this.lastYearProfit,
    });

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['current_year_profit'] != null) {
      currentYearProfit = [];
      json['current_year_profit'].forEach((v) {
        currentYearProfit!.add(new CurrentYearProfit.fromJson(v));
      });
    }
    if (json['last_year_profit'] != null) {
      lastYearProfit = [];
      json['last_year_profit'].forEach((v) {
        lastYearProfit!.add(new LastYearProfit.fromJson(v));
      });
    }
    // if (json['current_year_roi'] != null) {
    //   currentYearRoi = [];
    //   json['current_year_roi'].forEach((v) {
    //     currentYearRoi!.add(new CurrentYearRoi.fromJson(v));
    //   });
    // }
    // if (json['last_year_roi'] != null) {
    //   lastYearRoi = [];
    //   json['last_year_roi'].forEach((v) {
    //     lastYearRoi!.add(new LastYearRoi.fromJson(v));
    //   });
    // }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.yearlyProfit != null) {
  //     data['yearly_profit'] = this.yearlyProfit!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.lastWeekProfit != null) {
  //     data['last_week_profit'] =
  //         this.lastWeekProfit!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.currentYearRoi != null) {
  //     data['current_year_roi'] =
  //         this.currentYearRoi!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.lastYearRoi != null) {
  //     data['last_year_roi'] = this.lastYearRoi!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class CurrentYearProfit {
  String? month;
  String? profit;
  String? progressiveProfit;
  CurrentYearProfit({this.month, this.profit,this.progressiveProfit});

  CurrentYearProfit.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    profit = json['profit'];
    progressiveProfit =json['progressive_profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['profit'] = this.profit;
    return data;
  }
}

class LastYearProfit {
  String? month;
  String? profit;
  String? progressiveProfit;
  LastYearProfit({this.month, this.profit,this.progressiveProfit});

  LastYearProfit.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // signalDate = json['signal_date'];
    month = json['month'];
    profit = json['profit'];
    progressiveProfit =json['progressive_profit'];
    // day = json['day'];
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
    month = json['month'] ??'';
    roi = json['roi'] ??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['roi'] = this.roi;
    return data;
  }
}