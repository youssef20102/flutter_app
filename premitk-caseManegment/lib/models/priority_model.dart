// @dart=2.9

class PrioritiesModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<PriorityData> data;


  PrioritiesModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
 });

  PrioritiesModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <PriorityData>[];
      json['data'].forEach((v) {
        data.add(PriorityData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class PriorityData {
  int id;
  String name;

  PriorityData({this.id, this.name});

  PriorityData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
