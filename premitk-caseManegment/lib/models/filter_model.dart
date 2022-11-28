// @dart=2.9
// ignore_for_file: non_constant_identifier_names, duplicate_ignore, invalid_language_version_override
//
// class FilterModel {
//   String filterName;
//
//
//   FilterModel({this.filterName });
//
//   FilterModel.fromJson(Map<String, dynamic> json)
//   {
//     filterName=json['filterName'];
//
//   }
//
//
//
//
// }





// @dart=2.9
// ignore_for_file: non_constant_identifier_names
//
// class FilterModel {
//   int errorCode;
//   List<FilterData> data;
//
//   FilterModel({this.data});
//
//   FilterModel.fromMap(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data.add(FilterData.fromMap(v));
//       });
//     } else {
//       data = [];
//     }
//   }
// }
//
// class FilterData {
//   int Id;
//   String Name;
//
//   FilterData.fromMap(Map<String, dynamic> json) {
//     Id = json['Id'];
//     Name = json['Name'];
//   }
// }



class UserFilters {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<FilterData> data;
  int count;

  UserFilters(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  UserFilters.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <FilterData>[];
      json['data'].forEach((v) {
        data.add(FilterData.fromJson(v));
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

class FilterData {
  int id;
  String name;

  FilterData({this.id, this.name});

  FilterData.fromJson(Map<String, dynamic> json) {
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
