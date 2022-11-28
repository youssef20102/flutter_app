// @dart=2.9
// ignore_for_file: non_constant_identifier_names



class CustomersModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<CustomerData> customerData;
  String count;

  CustomersModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.customerData,
        this.count});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      customerData = <CustomerData>[];
      json['data'].forEach((v) {
        customerData.add(CustomerData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (customerData != null) {
      data['data'] = customerData.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class CustomerData {
  int iD;
  String name;
  String customerType;
  String email;
  String phone;

  CustomerData({this.iD, this.name, this.customerType, this.email, this.phone});

  CustomerData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    customerType = json['CustomerType'];
    email = json['Email'];
    phone = json['Phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['CustomerType'] = customerType;
    data['Email'] = email;
    data['Phone'] = phone;
    return data;
  }
}


