// @dart=2.9
// ignore_for_file: non_constant_identifier_names

class AllCasesModel {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<CaseModel> caseModel;
  String count;

  AllCasesModel(
      {this.errorCode,
      this.errorDescription,
      this.technicalError,
      this.caseModel,
      this.count});

  AllCasesModel.fromJson(Map<dynamic, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      caseModel = <CaseModel>[];
      json['data'].forEach((v) {
        caseModel.add(CaseModel.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    data['technicalError'] = technicalError;
    if (caseModel != null) {
      data['data'] = caseModel.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class CaseModel {
  int complaintId;
  int caseNumber;
  String subject;
  String submitDate;
  String userName;
  String complaintStatus;
  String lastUpdatedTime;
  String lastUpdatedBy;
  String priority;
  int caseSource;
  String customerName;
  List<int> userIds;
  List<int> roleIds;
  List<int> ouIds;
  List<int> userGroupIds;
  String slaColor;
  int NewStatusCount;
  int OpenStatusCount;
  int ClosedStatusCount;
  int EscaltedStatusCount;
  int WaitCustStatusCount;
  int ReopenedStatusCount;
  int NeedBudgetStatusCount;

  CaseModel(
      {this.complaintId,
      this.caseNumber,
      this.subject,
      this.submitDate,
      this.userName,
      this.complaintStatus,
      this.lastUpdatedTime,
      this.lastUpdatedBy,
      this.priority,
      this.caseSource,
      this.customerName,
      this.userIds,
      this.roleIds,
      this.ouIds,
      this.userGroupIds,
      this.slaColor,
      this.NewStatusCount,
      this.OpenStatusCount,
      this.ClosedStatusCount,
      this.EscaltedStatusCount,
      this.WaitCustStatusCount,
      this.ReopenedStatusCount,
      this.NeedBudgetStatusCount,



      });

  CaseModel.fromJson(Map<String, dynamic> json) {
    complaintId = json['ComplaintId'];
    caseNumber = json['CaseNumber'];
    subject = json['Subject'];
    submitDate = json['SubmitDate'];
    userName = json['UserName'];
    complaintStatus = json['ComplaintStatus'];
    lastUpdatedTime = json['LastUpdatedTime'];
    lastUpdatedBy = json['LastUpdatedBy'];
    priority = json['Priority'];
    caseSource = json['CaseSource'];
    customerName = json['CustomerName'];
    if (json['UserIds'] != null) {
      userIds = json['UserIds'].cast<int>();
    } else {
      userIds = [];
    }
    if (json['RoleIds'] != null) {
      roleIds = json['RoleIds'].cast<int>();
    } else {
      roleIds = [];
    }
    if (json['OuIds'] != null) {
      ouIds = json['OuIds'].cast<int>();
    } else {
      ouIds = [];
    }
    if (json['UserGroupIds'] != null) {
      userGroupIds = json['UserGroupIds'].cast<int>();
    } else {
      userGroupIds = [];
    }
    slaColor = json['SLAColor'];
    NewStatusCount = json['NewStatusCount'];
    OpenStatusCount = json['OpenStatusCount'];
    ClosedStatusCount = json['ClosedStatusCount'];
    EscaltedStatusCount = json['EscaltedStatusCount'];
    WaitCustStatusCount = json['WaitCustStatusCount'];
    ReopenedStatusCount = json['ReopenedStatusCount'];
    NeedBudgetStatusCount = json['NeedBudgetStatusCount'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ComplaintId'] = complaintId;
    data['CaseNumber'] = caseNumber;
    data['Subject'] = subject;
    data['SubmitDate'] = submitDate;
    data['UserName'] = userName;
    data['ComplaintStatus'] = complaintStatus;
    data['LastUpdatedTime'] = lastUpdatedTime;
    data['LastUpdatedBy'] = lastUpdatedBy;
    data['Priority'] = priority;
    data['CaseSource'] = caseSource;
    data['CustomerName'] = customerName;
    data['UserIds'] = userIds;
    data['RoleIds'] = roleIds;
    data['OuIds'] = ouIds;
    data['UserGroupIds'] = userGroupIds;
    data['SLAColor'] = slaColor;
    data['NewStatusCount'] = NewStatusCount;
    data['OpenStatusCount'] = OpenStatusCount;
    data['ClosedStatusCount'] = ClosedStatusCount;
    data['EscaltedStatusCount'] = EscaltedStatusCount;
    data['WaitCustStatusCount'] = WaitCustStatusCount;
    data['ReopenedStatusCount'] = ReopenedStatusCount;
    data['NeedBudgetStatusCount'] = NeedBudgetStatusCount;
    return data;
  }
}
