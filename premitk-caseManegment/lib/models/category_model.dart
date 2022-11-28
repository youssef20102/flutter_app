// @dart=2.9
// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<CategoryData> data;
  int  count;

  CategoryModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data.add(CategoryData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class CategoryData {
  int id;
  String name;

  CategoryData({this.id, this.name});

  CategoryData.fromJson(Map<String, dynamic> json) {
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
