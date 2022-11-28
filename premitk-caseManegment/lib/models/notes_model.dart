// @dart=2.9
// ignore_for_file: non_constant_identifier_names




class NotesModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  NoteData data;


  NotesModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        });

  NotesModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    data = json['data'] != null ? NoteData.fromJson(json['data']) : null;

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

class NoteData {
  int noteID;
  String noteDescription;

  NoteData({this.noteID, this.noteDescription});

  NoteData.fromJson(Map<String, dynamic> json) {
    noteID = json['Note_ID'];
    noteDescription = json['Note_Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Note_ID'] = noteID;
    data['Note_Description'] = noteDescription;
    return data;
  }
}

