// @dart=2.9

// ignore_for_file: non_constant_identifier_names


class AdminModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  AdminDataModel data;


  AdminModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
 });

  AdminModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    data = json['data'] != null ? AdminDataModel.fromJson(json['data']) : null;

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

class AdminDataModel {
  String apitoken;
  String userName;
  String name;
  String clientName;
  String email;
  String phone;
  String organizationUnit;
  String defaultFilter;
  bool enableNotifications;

  AdminDataModel(
      {this.apitoken,
        this.userName,
        this.name,
        this.clientName,
        this.email,
        this.phone,
        this.organizationUnit,
        this.defaultFilter,
        this.enableNotifications});

  AdminDataModel.fromJson(Map<String, dynamic> json) {
    apitoken = json['apitoken'];
    userName = json['UserName'];
    name = json['Name'];
    clientName = json['ClientName'];
    email = json['Email'];
    phone = json['Phone'];
    organizationUnit = json['OrganizationUnit'];
    defaultFilter = json['DefaultFilter'];
    enableNotifications = json['EnableNotifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apitoken'] = apitoken;
    data['UserName'] = userName;
    data['Name'] = name;
    data['ClientName'] = clientName;
    data['Email'] = email;
    data['Phone'] = phone;
    data['OrganizationUnit'] = organizationUnit;
    data['DefaultFilter'] = defaultFilter;
    data['EnableNotifications'] = enableNotifications;
    return data;
  }
}
















































// class AdminModel {
//   int errorCode;
//   String errorDescription;
//   AdminDataModel data;
//
//   AdminModel({this.data, this.errorCode, this.errorDescription});
//
//   AdminModel.fromMap(Map<String, dynamic> json) {
//     errorCode = json['errorCode'];
//     errorDescription = json['errorDescription'];
//
//     data = json['data'] != null ? AdminDataModel.fromMap(json['data']) : null;
//   }
// }
//
// class AdminDataModel {
//   String apitoken;
//   String UserName;
//   String Name;
//   String ClientName;
//   String Email;
//   String Phone;
//   String OrganizationUnit;
//   String DefaultFilter;
//   bool EnableNotifications;
//
//   AdminDataModel.fromMap(Map<String, dynamic> json) {
//     apitoken = json['apitoken'];
//     UserName = json['UserName'];
//     Name = json['Name'];
//     ClientName = json['ClientName'];
//     Email = json['Email'];
//     Phone = json['Phone'];
//     OrganizationUnit = json['OrganizationUnit'];
//     DefaultFilter = json['DefaultFilter'];
//     EnableNotifications = json['EnableNotifications'];
//   }
// }
