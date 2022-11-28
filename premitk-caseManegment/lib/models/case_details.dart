// @dart=2.9

class CaseDetailsModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  Data data;


  CaseDetailsModel(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
 });

  CaseDetailsModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

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

class Data {
  List<int> userIds;
  List<int> roleIds;
  List<int> ouIds;
  List<int> userGroupIds;
  int id;
  int caseNumber;
  String subject;
  String description;
  String createdOn;
  String createdBy;
  int status;
  int customerID;
  String customerName;
  String customerEmail;
  String customerMobile;
  String customerPhone;
  String customerType;

  List<Notes> notes;
  int notesCount;
  Attachments attachments;
  int attachmentsCount;
  int caseTypeValue;
  int caseSourceValue;
  int caseProductGroupValue;
  int caseProductValue;
  int caseCategoryValue;
  int caseSubCategoryValue;
  int casePriorityValue;
  String sLAColor;

  Data(
      {this.userIds,
        this.roleIds,
        this.ouIds,
        this.userGroupIds,
        this.id,
        this.caseNumber,
        this.subject,
        this.description,
        this.createdOn,
        this.createdBy,
        this.status,
        this.customerID,
        this.customerName,
        this.customerEmail,
        this.customerMobile,
        this.customerType,
        this.customerPhone,
        this.notes,
        this.notesCount,

        this.attachments,
        this.attachmentsCount,
        this.caseTypeValue,
        this.caseSourceValue,
        this.caseProductGroupValue,
        this.caseProductValue,
        this.caseCategoryValue,
        this.caseSubCategoryValue,
        this.casePriorityValue,
        this.sLAColor});

  Data.fromJson(Map<String, dynamic> json) {
    userIds = json['UserIds'].cast<int>();
    roleIds = json['RoleIds'].cast<int>();
    ouIds = json['OuIds'].cast<int>();
    userGroupIds = json['UserGroupIds'].cast<int>();
    id = json['id'];
    caseNumber = json['caseNumber'];
    subject = json['subject'];
    description = json['description'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    status = json['status'];
    customerID = json['customerID'];
    customerType = json['customerType'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    customerPhone = json['customerPhone'];
    customerMobile = json['customerMobile'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes.add(Notes.fromJson(v));
      });
    }
    notesCount = json['notesCount'];

    attachments = json['attachments'] != null
        ? Attachments.fromJson(json['attachments'])
        : null;
    attachmentsCount = json['attachmentsCount'];
    caseTypeValue = json['CaseTypeValue'];
    caseSourceValue = json['CaseSourceValue'];
    caseProductGroupValue = json['CaseProductGroupValue'];
    caseProductValue = json['CaseProductValue'];
    caseCategoryValue = json['CaseCategoryValue'];
    caseSubCategoryValue = json['CaseSubCategoryValue'];
    casePriorityValue = json['CasePriorityValue'];
    sLAColor = json['SLAColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserIds'] = userIds;
    data['RoleIds'] = roleIds;
    data['OuIds'] = ouIds;
    data['UserGroupIds'] = userGroupIds;
    data['id'] = id;
    data['caseNumber'] = caseNumber;
    data['subject'] = subject;
    data['description'] = description;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['status'] = status;
    data['customerName'] = customerName;
    data['customerEmail'] = customerEmail;
    data['customerMobile'] = customerMobile;
    data['customerID'] = customerID;
    data['customerPhone'] = customerPhone;
    data['customerType'] = customerType;
    if (notes != null) {
      data['notes'] = notes.map((v) => v.toJson()).toList();
    }
    data['notesCount'] = notesCount;

    if (attachments != null) {
      data['attachments'] = attachments.toJson();
    }
    data['attachmentsCount'] = attachmentsCount;
    data['CaseTypeValue'] = caseTypeValue;
    data['CaseSourceValue'] = caseSourceValue;
    data['CaseProductGroupValue'] = caseProductGroupValue;
    data['CaseProductValue'] = caseProductValue;
    data['CaseCategoryValue'] = caseCategoryValue;
    data['CaseSubCategoryValue'] = caseSubCategoryValue;
    data['CasePriorityValue'] = casePriorityValue;
    data['SLAColor'] = sLAColor;
    return data;
  }
}

class Notes {
  int id;
  String note;
  String createdOn;
  String createdBy;

  Notes({this.id, this.note, this.createdOn, this.createdBy});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    return data;
  }
}

class Attachments {
  List<AttachmentData> attachments;

  Attachments({this.attachments});

  Attachments.fromJson(Map<String, dynamic> json) {
    if (json['attachments'] != null) {
      attachments = <AttachmentData>[];
      json['attachments'].forEach((v) {
        attachments.add(AttachmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attachments != null) {
      data['attachments'] = attachments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttachmentData {
  String clientId;
  String fileName;
  String filePath;

  AttachmentData({this.clientId, this.fileName, this.filePath});

  AttachmentData.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    fileName = json['fileName'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ClientId'] = clientId;
    data['fileName'] = fileName;
    data['filePath'] = filePath;
    return data;
  }
}


