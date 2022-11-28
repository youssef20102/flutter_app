// ignore_for_file: non_constant_identifier_names

// class UserModel {
//   String name;
//   String email;
//
//   String imageURL;
//   String phone;
//   String address;
//   String about;
//
//
//
//   UserModel.fromJson(Map<String, dynamic> json)
//   {
//
//     name=json['name'];
//     email=json['email'];
//     imageURL=json['imageURL'];
//     phone=json['phone'];
//     address=json['address'];
//     about=json['about'];
//   }
//   UserModel.toJson(Map<String, dynamic> json){
//     json['name']=name;
//     json['email']=email;
//     json['imageURL']=imageURL;
//     json['phone']=phone;
//     json['address']=address;
//     json['about']=about;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['name'] = name;
//     data['email'] = email;
//     data['imageURL'] = imageURL;
//     data['phone'] = phone;
//     data['address'] = address;
//     data['about'] = about;
//     return data;
//   }
//
//
//
// }

// @dart=2.9
class UserModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<UserData> data;
  int count;

  UserModel(
      {this.errorCode,
      this.errorDescription,
      this.technicalError,
      this.data,
      this.count});

  UserModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data.add(UserData.fromJson(v));
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

class UserData {
  int id;
  String name;

  UserData({this.id, this.name});

  UserData.fromJson(Map<String, dynamic> json) {
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
