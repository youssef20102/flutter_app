

// @dart=2.9

class GetTypesModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  Data data;
  int count;

  GetTypesModel(
      {this.errorCode,
      this.errorDescription,
      this.technicalError,
      this.data,
      this.count});

  GetTypesModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  List<TypeList> typeList;
  int deaultTypeId;

  Data({this.typeList, this.deaultTypeId});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['TypeList'] != null) {
      typeList = <TypeList>[];
      json['TypeList'].forEach((v) {
        typeList.add(TypeList.fromJson(v));
      });
    }
    deaultTypeId = json['DeaultTypeId'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (typeList != null) {
      data['TypeList'] = typeList.map((v) => v.toJson()).toList();
    }
    data['DeaultTypeId'] = deaultTypeId;
    return data;
  }
}

class TypeList {
  int id;
  String name;

  TypeList({this.id, this.name});

  TypeList.fromJson(Map<String, dynamic> json) {
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
