// @dart=2.9

class CustomerCasesHistory {
  int errorCode;
  String errorDescription;
  String technicalError;
  List<CustomerCasesHistoryData> data;
  String count;

  CustomerCasesHistory(
      {this.errorCode,
        this.errorDescription,
        this.technicalError,
        this.data,
        this.count});

  CustomerCasesHistory.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorDescription = json['errorDescription'];
    technicalError = json['technicalError'];
    if (json['data'] != null) {
      data = <CustomerCasesHistoryData>[];
      json['data'].forEach((v) {
        data.add(CustomerCasesHistoryData.fromJson(v));
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

class CustomerCasesHistoryData {
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
  String sLAColor;

  CustomerCasesHistoryData(
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
        this.sLAColor});

  CustomerCasesHistoryData.fromJson(Map<String, dynamic> json) {
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
    userIds = json['UserIds'].cast<int>();
    roleIds = json['RoleIds'].cast<int>();
    ouIds = json['OuIds'].cast<int>();
    userGroupIds = json['UserGroupIds'].cast<int>();
    sLAColor = json['SLAColor'];
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
    data['SLAColor'] = sLAColor;
    return data;
  }
}

