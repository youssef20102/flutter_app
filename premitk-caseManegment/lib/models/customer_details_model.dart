// @dart=2.9
class CustomersDetailsModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  CustomerDetailData data;


  CustomersDetailsModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
      });

  CustomersDetailsModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    data = json['data'] != null ? CustomerDetailData.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    return data;
  }
}

class CustomerDetailData {
  int iD;
  String name;
  String email;
  String phone;
  String mobile;
  String address;
  String recordNO;
  String idType;
  String idNumber;
  String imageUrl;
  // Null customerType;

  CustomerDetailData(
      {this.iD,
        this.name,
        this.email,
        this.phone,
        this.mobile,
        this.address,
        this.recordNO,
        this.idType,
        this.idNumber,
        this.imageUrl,
        // this.customerType
      });

  CustomerDetailData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    email = json['Email'];
    phone = json['Phone'];
    mobile = json['Mobile'];
    address = json['Address'];
    recordNO = json['RecordNO'];
    idType = json['IdType'];
    idNumber = json['IdNumber'];
    imageUrl = json['ImageUrl'];
    // customerType = json['CustomerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Email'] = email;
    data['Phone'] = phone;
    data['Mobile'] = mobile;
    data['Address'] = address;
    data['RecordNO'] = recordNO;
    data['IdType'] = idType;
    data['IdNumber'] = idNumber;
    data['ImageUrl'] = imageUrl;
    // data['CustomerType'] = this.customerType;
    return data;
  }
}
