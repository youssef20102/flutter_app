// @dart=2.9
// ignore_for_file: non_constant_identifier_names, missing_return
//
// class GroupModel {
//   String name;
//
//
//   GroupModel({ this.name, });
//
//   GroupModel.fromJson(Map<String, dynamic> json)
//   {
//     name=json['name'];
//
//   }
//
//
//   Map <String ,dynamic>toJson(){
//     final Map<String,dynamic>data=<String,dynamic>{};
//     data['name'] = name;
//
//
//   }
//
//
//
// }



class GroupModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<GroupData> data;
  int count;

  GroupModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  GroupModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <GroupData>[];
      json['data'].forEach((v) {
        data.add(GroupData.fromJson(v));
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

class GroupData {
  int id;
  String name;

  GroupData({this.id, this.name});

  GroupData.fromJson(Map<String, dynamic> json) {
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
