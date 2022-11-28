// @dart=2.9
// ignore_for_file: non_constant_identifier_names
class ProductModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<ProductData> data;
  int count;

  ProductModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  ProductModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data.add(ProductData.fromJson(v));
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

class ProductData {
  int id;
  String name;

  ProductData({this.id, this.name});

  ProductData.fromJson(Map<String, dynamic> json) {
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

