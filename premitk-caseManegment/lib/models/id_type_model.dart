// @dart=2.9


class IdTypeModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<IdTypeData> data;


  IdTypeModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
 });

  IdTypeModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <IdTypeData>[];
      json['data'].forEach((v) {
        data.add(IdTypeData.fromJson(v));
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

class IdTypeData {
  int id;
  String name;

  IdTypeData({this.id, this.name});

  IdTypeData.fromJson(Map<String, dynamic> json) {
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
