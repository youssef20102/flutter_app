// ignore_for_file: import_of_legacy_library_into_null_safe, non_constant_identifier_names, prefer_const_constructors, missing_return, deprecated_member_use
// @dart=2.9

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/models/admin_model.dart';
import 'package:primitk_crm/models/all_cases_model.dart';
import 'package:primitk_crm/models/case_details.dart';
import 'package:primitk_crm/models/category_model.dart';

import 'package:primitk_crm/models/customer_details_model.dart';
import 'package:primitk_crm/models/customer_model.dart';

import 'package:primitk_crm/models/group_model.dart';
import 'package:primitk_crm/models/id_type_model.dart';
import 'package:primitk_crm/models/notes_model.dart';

import 'package:primitk_crm/models/ou_model.dart';
import 'package:primitk_crm/models/priority_model.dart';
import 'package:primitk_crm/models/product_group_model.dart';
import 'package:primitk_crm/models/product_model.dart';
import 'package:primitk_crm/models/source_model.dart';
import 'package:primitk_crm/models/status_model.dart';
import 'package:primitk_crm/models/sub_category_model.dart';
import 'package:primitk_crm/models/type_model.dart';
import 'package:primitk_crm/models/user_model.dart';
import 'package:primitk_crm/modules/auth/login_with_email&password.dart';

import 'package:primitk_crm/modules/auth/login_with_url.dart';

import 'package:primitk_crm/modules/home_layout/add_Ticket_screen/add_ticket_screen.dart';
import 'package:primitk_crm/modules/home_layout/customer_screen/customer_cases.dart';
import 'package:primitk_crm/modules/home_layout/customer_screen/customer_details.dart';
import 'package:primitk_crm/modules/home_layout/customer_screen/customer_list_screen.dart';
import 'package:primitk_crm/modules/home_layout/home_layout_screen/home_layout_screen.dart';
import 'package:primitk_crm/modules/home_layout/home_screen/home_screen.dart';
import 'package:primitk_crm/modules/home_layout/notification_screen/notification_screen.dart';
import 'package:primitk_crm/modules/home_layout/user_info/user_info.dart';
import 'package:primitk_crm/shared/components/components.dart';
import 'package:primitk_crm/shared/constants/constatnt.dart';
import 'package:primitk_crm/shared/network/remote/dio_helper.dart';
import 'package:primitk_crm/shared/network/remote/end_points.dart';
import 'package:primitk_crm/shared/style/color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitialState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  //cheek connection

  StreamSubscription internetConnection;
  bool isOffline;

  bool succesGetData = false;

// Get data if connection successfuly
  Future cheekNetWork(context) async {
    internetConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection

        isOffline = true;

        emit(HomeCheckConnectionNoInternetState());
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network

        await getAdminData();
        await getAllCases(context, 0, false);

        await getSubCategory('', false);
        await getProductGroup(false);
        await getProduct('', false);
        await getCategory(false);
        await getType(false);
        await getUsers(false);
        await getOus(false);
        await getGroups(false);
        await getSources(false);
        // await getFilters();
        await getStatus(false);
        await getPriorities(false);
        await getCustomers(false);
        await getIdType(false);
        succesGetData = true;
        isOffline = false;
        emit(HomeCheckConnectionMobileDataInterNetState());
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        await getAdminData();
        await getAllCases(context, 0, false);

        await getSubCategory('', false);
        await getProductGroup(false);
        await getProduct('', false);
        await getCategory(false);
        await getType(false);
        await getUsers(false);
        await getOus(false);
        await getGroups(false);
        await getSources(false);
        // await getFilters();
        await getStatus(false);
        await getPriorities(false);
        await getCustomers(false);
        await getIdType(false);

        isOffline = false;
        emit(HomeCheckConnectionWifiInterNetState());
      }
    }); // using this listiner, you can get the medium of connection as well.
  }

  void noInternetConnection() {
    if (isOffline == true) {
      showToast(text: 'No internet connection', state: ToastState.ERROR);
    } else {
      showToast(text: 'some thing wrong', state: ToastState.ERROR);
    }
  }

// Void to print any string
  void print(String txt) {
    debugPrint(txt.toString());
  }

  ///////////////////////// Home Layout ////////////////////////////////

  // integer to select one of screen in the bottomNavScreen

  int bottomNavCurrentIndex = 0;

  // List of screens displayed in homeLayout body
  List bottomNavScreens = [
    const HomeScreen(),
    const ChatScreen(),
    const AddCase(),
    const Notification_Screen(),
    UserInfo_Screen()
  ];

  // Void to change Bottom NavigationBar CurrentIndex

  void changeBottomNavCurrentIndex(int value) {
    bottomNavCurrentIndex = value;
    emit(HomeChangeBottomNavState());
  }

  ////////// Home Screen  /////////////

  ScrollController scrollFiltersController = ScrollController();
  ScrollController scrollHomeController = ScrollController();
  ScrollController homeSearchScrollController = ScrollController();

  final searchCasesFormKey = GlobalKey<FormState>();
  final getMoreCaseKey = GlobalKey<FormState>();
  final refreshCaseKey = GlobalKey<FormState>();

  Future getAdminData() async {
    print(Name);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserName = prefs.getString('UserName');
    Name = prefs.getString('Name');
    ClientName = prefs.getString('ClientName');
    Email = prefs.getString('Email');
    Phone = prefs.getString('Phone');
    OrganizationUnit = prefs.getString('OrganizationUnit');
    DefaultFilter = prefs.getString('DefaultFilter');
    EnableNotifications = prefs.getBool('EnableNotifications');
    print('sososososososososos');

    emit(UserInfoGetAdminDataState());
  }

  ///// Sort

  Color upperColor = selectedColor;

  Color LowerColor = Colors.grey;

  bool descending;

  bool progressive;

  bool sortByCaseNum;

  bool sortByDateCheck;

  void changeLowerSort() {
    descending = true;
    progressive = false;
    upperColor = selectedColor;
    LowerColor = Colors.grey;

    emit(HomeChangeSortState());
  }

  void changeUpperSort() {
    descending = false;
    progressive = true;

    LowerColor = selectedColor;
    upperColor = Colors.grey;
    print(descending.toString());
    print(progressive.toString());
    emit(HomeChangeUpperSortState());
  }

  void sortByDate(context) {
    if (descending == true) {
      caseItemsHome.sort((b, a) {
        var aDate = a.submitDate;
        var bDate = b.submitDate;
        return bDate.compareTo(aDate);
      });

      sortByDateCheck = true;
      sortByCaseNum = false;
    } else {
      caseItemsHome.sort((b, a) {
        var aDate = a.submitDate;
        var bDate = b.submitDate;
        return aDate.compareTo(bDate);
      });
      sortByDateCheck = true;
      sortByCaseNum = false;
    }
    Navigator.pop(context);
    emit(HomeSortingByDateState());
  }

  void sortByNum(context) {
    if (progressive == true) {
      caseItemsHome.sort((b, a) {
        var aDate = a.complaintId;
        var bDate = b.complaintId;
        return aDate.compareTo(bDate);
      });
      sortByDateCheck = false;
      sortByCaseNum = true;
    } else {
      caseItemsHome.sort((b, a) {
        var aDate = a.complaintId;
        var bDate = b.complaintId;
        return bDate.compareTo(aDate);
      });
      sortByDateCheck = false;
      sortByCaseNum = true;
    }

    Navigator.pop(context);
    emit(HomeSortingByCaseNumState());
  }

  void noSorting(context) {
    // sortByDateCheck=null;
    // sortByCaseNum==null;
    getAllCases(context, 0, true);
    Navigator.pop(context);
    emit(HomeNoSortingState());
  }

  // List to display in home screen body
  List<CaseModel> caseItemsHome = [];

  //Filter Methods
  String appBarTitle = 'ALL Cases';

  // Void to get only Closed Case
  void getFilterCase(context, String state) {
    emit(HomeGetCaseLoadingState());
    caseItemsHome = [];
    if (state == 'Waiting for customer ') {
      appBarTitle = 'waiting..'.toUpperCase();
    } else {
      appBarTitle = state.toUpperCase();
    }
    for (var element in caseItems) {
      if (element.complaintStatus.toLowerCase().trim() ==
          state.toLowerCase().trim()) {
        caseItemsHome.add(element);
      }
    }

    emit(HomeGetCaseSuccessState());
  }

  //
  // void getAllData(context) async {
  //   await getAllCases(context);
  // }

  // List to fill model data
  List<CaseModel> caseItems = [];

  int newCase = 0;
  int openCase = 0;
  int closedCase = 0;
  int escalatedCase = 0;
  int waitingForCustomerCase = 0;
  int needBudgetCase = 0;
  AllCasesModel allCasesModel;
  bool notData;
  bool assignedToMe;

// Void to get All  Case and Customer when start

  Future getAssignedToMeCases(context) {
    assignedToMe = true;
    emit(HomeGetAllAssignedToMeCasesState());

    EasyLoading.show(
      status: 'loading...',
    );

    appBarTitle = 'My Assigned Cases';

    caseItems = [];
    caseItemsHome = [];

    emit(HomeAllCasesLoadingState());
    BASE_URL = 'http://$dOMAiN.qa.$dOMAiN.com/api/v2/';
    DioHelper.init();

    DioHelper.getData(url: GetCases, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseItems.length,
      'RequestedRowCount': 20,
      'ViewId': 1,
      'languageId': 2,
      'SearchText': '',
    }).then((value) {
      print('55555555555555555555555');
      allCasesModel = AllCasesModel.fromJson(value.data);

      if (allCasesModel.errorCode == 0) {
        caseItems = allCasesModel.caseModel;
        caseItemsHome = caseItems;
        // caseItemsSearch = caseItems;

        emit(HomeAllCasesSuccessState());
        newCase = caseItems[0].NewStatusCount;
        openCase = caseItems[0].OpenStatusCount;
        closedCase = caseItems[0].ClosedStatusCount;
        escalatedCase = caseItems[0].EscaltedStatusCount;
        waitingForCustomerCase = caseItems[0].WaitCustStatusCount;
        needBudgetCase = caseItems[0].NeedBudgetStatusCount;

        if (caseItemsHome.isEmpty) {
          notData = true;
        } else {
          notData = false;
        }
        EasyLoading.dismiss();

        emit(HomeAllCasesSuccessState());
      } else {
        showToast(
            text: allCasesModel.errorDescription.toString(),
            state: ToastState.ERROR);
        EasyLoading.dismiss();
        notData = true;
      }
    }).catchError((e) {
      // showToast(text: allCasesModel.errorDescription.toString(), state: ToastState.ERROR);
      print(e.toString());
      notData = true;

      EasyLoading.dismiss();

      emit(HomeAllCasesErrorState());
    });
  }

  String allCases = '0';

  Future getAllCases(context, int type, bool showErr) {
    // EasyLoading.show(
    //   status: 'loading...',
    // );
    emit(HomeAllCasesLoadingState());

    bottomNavCurrentIndex = 0;
    appBarTitle = 'ALL Cases';

    caseItems = [];
    caseItemsHome = [];
    assignedToMe = false;

    BASE_URL = 'http://$dOMAiN.qa.$dOMAiN.com/api/v2/';
    DioHelper.init();

    DioHelper.getData(url: GetCases, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseItems.length,
      'RequestedRowCount': 20,
      'ViewId': type,
      'languageId': 2,
      'SearchText': '',
    }).then((value) {
      print(TOKEN.toString());
      print('55555555555555555555555');
      allCasesModel = AllCasesModel.fromJson(value.data);
      print(value.data.toString());
      if (allCasesModel.errorCode == 0) {
        allCases = allCasesModel.count ?? '0';
        caseItems = allCasesModel.caseModel;
        caseItemsHome = caseItems;
        caseItemsSearch = caseItems;

        emit(HomeAllCasesSuccessState());
        newCase = caseItems[0].NewStatusCount ?? '0';
        openCase = caseItems[0].OpenStatusCount ?? '0';
        closedCase = caseItems[0].ClosedStatusCount ?? '0';
        escalatedCase = caseItems[0].EscaltedStatusCount ?? '0';
        waitingForCustomerCase = caseItems[0].WaitCustStatusCount ?? '0';
        needBudgetCase = caseItems[0].NeedBudgetStatusCount ?? '0';

        if (caseItemsHome.isEmpty) {
          notData = true;
        } else {
          notData = false;
        }
        EasyLoading.dismiss();

        emit(HomeAllCasesSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: allCasesModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }
        EasyLoading.dismiss();
        notData = true;
        print(TOKEN.toString());
      }
    }).catchError((e) {
      // showToast(text: allCasesModel.errorDescription.toString(), state: ToastState.ERROR);
      print(e.toString());
      notData = true;
      print(TOKEN.toString());

      EasyLoading.dismiss();

      emit(HomeAllCasesErrorState());
    });
  }

  AllCasesModel allCasesModelMore;

  Future loadMoreCases(context) {
    // EasyLoading.show(
    //   status: 'loading...',
    // );
    emit(HomeGetMoreAllCasesLoadingState());
    DioHelper.getData(url: GetCases, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseItems.length,
      'RequestedRowCount': 10,
      'ViewId': assignedToMe == true ? 1 : 0,
      'languageId': 2,
      'SearchText': '',
    }).then((value) {
      allCasesModelMore = AllCasesModel.fromJson(value.data);
      if (allCasesModelMore.errorCode == 0) {
        if (assignedToMe == true) {
          print('////////////////////////////////////////////////////');

          print('assignedToMe');
          print('////////////////////////////////////////////////////');
        } else {
          print('////////////////////////////////////////////////////');

          print('All case');
          print('////////////////////////////////////////////////////');
        }

        if (allCasesModelMore.caseModel.isNotEmpty) {
          for (var element in allCasesModelMore.caseModel) {
            caseItems.add(element);
          }

          caseItemsHome = [];

          caseItemsHome = caseItems;

          newCase = newCase + allCasesModelMore.caseModel[0].NewStatusCount;
          openCase = openCase + allCasesModelMore.caseModel[0].OpenStatusCount;
          closedCase =
              closedCase + allCasesModelMore.caseModel[0].ClosedStatusCount;
          escalatedCase =
              escalatedCase + allCasesModelMore.caseModel[0].EscaltedStatusCount;
          waitingForCustomerCase =
              waitingForCustomerCase + allCasesModelMore.caseModel[0].WaitCustStatusCount;
          needBudgetCase = needBudgetCase + allCasesModelMore.caseModel[0].NeedBudgetStatusCount;
          emit(HomeGetMoreAllCasesSuccessState());

          // if(sortByDateCheck==true){
          //
          //
          //   if (descending == true) {
          //     caseItemsHome.sort((b, a) {
          //       var aDate = a.submitDate;
          //       var bDate = b.submitDate;
          //       return bDate.compareTo(aDate);
          //     });
          //
          //   } else {
          //     caseItemsHome.sort((b, a) {
          //       var aDate = a.submitDate;
          //       var bDate = b.submitDate;
          //       return aDate.compareTo(bDate);
          //     });
          //
          //
          //
          //   }
          //
          //
          //
          //
          // }else if(sortByCaseNum==false){
          //
          //   if (progressive == true) {
          //     caseItemsHome.sort((b, a) {
          //       var aDate = a.complaintId;
          //       var bDate = b.complaintId;
          //       return aDate.compareTo(bDate);
          //     });
          //
          //   } else {
          //     caseItemsHome.sort((b, a) {
          //       var aDate = a.complaintId;
          //       var bDate = b.complaintId;
          //       return bDate.compareTo(aDate);
          //     });
          //
          //   }
          //
          //
          //
          //
          //
          // }else{
          //
          // }

        }
        // EasyLoading.dismiss();
        emit(HomeGetMoreAllCasesSuccessState());
      } else {
        // showToast(
        //     text: allCasesModelMore.errorDescription.toString(),
        //     state: ToastState.ERROR);
        emit(HomeGetMoreAllCasesErrorState());

        // EasyLoading.dismiss();
      }
    }).catchError((e) {
      noInternetConnection();

      print(e.toString());
      // EasyLoading.dismiss();

      emit(HomeGetMoreAllCasesErrorState());
    });
  }

  var txtSearchController = TextEditingController();

  // List to display Case in search screen body
  List<CaseModel> caseItemsSearch = [];
  bool notSearchData = true;
  AllCasesModel allCasesSearchModel;

  // Home Search Screen

  Future backToHome(context) {
    EasyLoading.show(status: 'loading...');

    caseItemsSearch =[];
    txtSearchController.text = '';
    bottomNavCurrentIndex = 0;
    navigateAndFinish(context: context, widget: HomeLayout());
    EasyLoading.dismiss();
    notSearchData = true;
    emit(HomeBackSearchState());
  }

  // Void to get All  Case search when start
  Future getAllSearchCases(context) {
    caseItemsSearch = [];

    EasyLoading.show(
      status: 'loading...',
    );

    emit(HomeAllCasesSearchLoadingState());

    DioHelper.getData(url: GetCases, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseItemsSearch.length,
      'RequestedRowCount': 15,
      'ViewId': 2,
      'languageId': 2,
      'SearchText': txtSearchController.text.trim().toString(),
    }).then((value) {
      print('66666666666666666666');
      allCasesSearchModel = AllCasesModel.fromJson(value.data);
      if (allCasesSearchModel.errorCode == 0) {
        print(value.data.toString());
        print(allCasesSearchModel.caseModel.toString());

        caseItemsSearch = allCasesSearchModel.caseModel;

        emit(HomeAllCasesSearchSuccessState());

        if (caseItemsSearch.isEmpty) {
          notSearchData = true;
        } else {
          notSearchData = false;
        }
        EasyLoading.dismiss();

        emit(HomeAllCasesSearchSuccessState());
      } else {
        showToast(
            text: allCasesSearchModel.errorDescription.toString(),
            state: ToastState.ERROR);
        notSearchData = true;

        EasyLoading.dismiss();

        emit(HomeAllCasesSearchErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      notSearchData = true;

      EasyLoading.dismiss();

      emit(HomeAllCasesSearchErrorState());
    });
  }

  Future getAllSearchCasesWhenNoDataInput(String txt) {
    if (txt.isEmpty || txt == null || txt == '') {
      caseItemsSearch = [];
      emit(HomeAllCasesSearchSuccessState());
    }
  }

  AllCasesModel allCasesSearchModelMore;

  Future loadMoreSearchCases(context) {
    emit(HomeGetMoreAllSearchCasesLoadingState());
    DioHelper.getData(url: GetCases, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseItemsSearch.length,
      'RequestedRowCount': 20,
      'ViewId': 2,
      'languageId': 2,
      'SearchText': txtSearchController.text.toString().trim(),
    }).then((value) {
      allCasesSearchModelMore = AllCasesModel.fromJson(value.data);
      if (allCasesSearchModelMore.errorCode == 0) {
        if (allCasesSearchModelMore.caseModel.isNotEmpty) {
          for (var element in allCasesSearchModelMore.caseModel) {
            caseItemsSearch.add(element);
          }

          emit(HomeGetMoreAllSearchCasesSuccessState());
        }

        emit(HomeGetMoreAllSearchCasesSuccessState());
      } else {
        showToast(
            text: allCasesSearchModelMore.errorDescription.toString(),
            state: ToastState.ERROR);
        emit(HomeGetMoreAllSearchCasesErrorState());
      }
    }).catchError((e) {
      noInternetConnection();

      print(e.toString());

      emit(HomeGetMoreAllSearchCasesErrorState());
    });
  }

  // // Filter Drawer
  //
  // UserFilters userFilters;
  //
  // Future getFilters() {
  //   emit(HomeGetFiltersLoadingState());
  //
  //   DioHelper.getData(url: GetUserViews, token: TOKEN, query: {
  //     'clientName': ClientName,
  //     'UserName': UserName,
  //     'deviceId': '',
  //     'languageId': 2,
  //   }).then((value) {
  //     filterItem = [];
  //     userFilters = UserFilters.fromJson(value.data);
  //     if (userFilters.errorCode == 0) {
  //       filterItem = userFilters.data;
  //
  //       emit(HomeGetFiltersSuccessState());
  //     } else {
  //       showToast(
  //           text: userFilters.errorDescription.toString(),
  //           state: ToastState.ERROR);
  //       emit(HomeGetFiltersErrorState());
  //     }
  //   }).catchError((e) {
  //     emit(HomeGetFiltersErrorState());
  //     print(e.toString());
  //   });
  // }
  //
  // List<FilterData> filterItem = [];
  //
  // void onTapDrawerFilter(String filterType) {
  //   print(filterType);
  // }

  // get status

  StatusModel statusModel;

  Future getStatus(bool shoeErr) {
    emit(HomeGetStatusLoadingState());

    DioHelper.getData(url: GetStatuses, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      StatusItems = [];
      StatusItemsString = [];
      statusModel = StatusModel.fromJson(value.data);
      if (statusModel.errorCode == 0) {
        StatusItems = statusModel.data;

        for (var element in statusModel.data) {
          StatusItemsString.add(element.name);
        }

        emit(HomeGetStatusSuccessState());
      } else {
        emit(HomeGetStatusErrorState());
        if (shoeErr == true) {
          showToast(
              text: statusModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }
      }
    }).catchError((e) {
      emit(HomeGetStatusErrorState());

      print(e.toString());
    });
  }

  List<StatusData> StatusItems = [];
  List<String> StatusItemsString = [];

  // get types

  GetTypesModel getTypesModel;

  List<TypeList> TypesItems = [];
  List<String> TypesItemsString = [];

  Future getType(bool showErr) {
    emit(HomeGetTypesLoadingState());

    DioHelper.getData(url: GetTypes, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      TypesItems = [];
      TypesItemsString = [];
      print('manamanamnamnamanamanamanamanamana');
      print(value.data.toString());
      print('manamanamnamnamanamanamanamanamana');

      getTypesModel = GetTypesModel.fromJson(value.data);

      if (getTypesModel.errorCode == 0) {
        TypesItems = getTypesModel.data.typeList;

        for (var element in getTypesModel.data.typeList) {
          TypesItemsString.add(element.name);
        }
        Type = TypesItems.firstWhere(
            (element) => element.id == getTypesModel.data.deaultTypeId).name;
        emit(HomeGetTypesSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: getTypesModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetTypesErrorState());
      }
    }).catchError((e) {
      emit(HomeGetTypesErrorState());
      print(e.toString());
    });
  }

  // get IdTypes

  IdTypeModel idTypeModel;

  Future getIdType(bool showErr) {
    emit(HomeGetIdTypesLoadingState());

    DioHelper.getData(
        url: GetIDTypes,
        token: TOKEN,
        query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      IdTypesItems = [];
      IdTypesItemsString = [];
      idTypeModel = IdTypeModel.fromJson(value.data);
      if (idTypeModel.errorCode == 0) {
        IdTypesItems = idTypeModel.data;

        for (var element in idTypeModel.data) {
          IdTypesItemsString.add(element.name);
        }

        emit(HomeGetIdTypesSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: idTypeModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetIdTypesErrorState());
      }
    }).catchError((e) {
      emit(HomeGetIdTypesErrorState());
      print(e.toString());
    });
  }

  List<IdTypeData> IdTypesItems = [];
  List<String> IdTypesItemsString = [];

  // get Priority

  PrioritiesModel prioritiesModel;

  Future getPriorities(bool showErr) {
    emit(HomeGetPrioritiesLoadingState());

    DioHelper.getData(url: GetPriorities, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      print('++++++++++++++++++++++++++++++++++++++++++++');
      print(BASE_URL.toString());
      print('++++++++++++++++++++++++++++++++++++++++++++');

      PrioritiesItems = [];
      PrioritiesString = [];
      prioritiesModel = PrioritiesModel.fromJson(value.data);
      if (prioritiesModel.errorCode == 0) {
        PrioritiesItems = prioritiesModel.data;

        for (var element in prioritiesModel.data) {
          PrioritiesString.add(element.name);
        }

        emit(HomeGetPrioritiesSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: prioritiesModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetPrioritiesErrorState());
      }
    }).catchError((e) {
      emit(HomeGetPrioritiesErrorState());
      print(e.toString());
    });
  }

  List<PriorityData> PrioritiesItems = [];
  List<String> PrioritiesString = [];

  // get Sources

  GetSourcesModel getSourcesModel;

  Future getSources(bool showErr) {
    emit(HomeGetSourcesLoadingState());

    DioHelper.getData(url: GetSources, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      SourcesItems = [];
      SourcesItemsString = [];
      getSourcesModel = GetSourcesModel.fromJson(value.data);
      if (getSourcesModel.errorCode == 0) {
        SourcesItems = getSourcesModel.data;

        for (var element in getSourcesModel.data) {
          SourcesItemsString.add(element.name);
        }
        emit(HomeGetSourcesSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: getSourcesModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetSourcesErrorState());
      }
    }).catchError((e) {
      emit(HomeGetSourcesErrorState());
      print(e.toString());
    });
  }

  List<SourceData> SourcesItems = [];
  List<String> SourcesItemsString = [];

  // Get ProductGroups

  GetProductGroupsModel getProductGroupsModel;

  Future getProductGroup(bool showErr) {
    emit(HomeGetProductGroupsLoadingState());

    DioHelper.getData(url: GetProductGroups, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      ProductGroupItems = [];
      ProductGroupString = [];
      getProductGroupsModel = GetProductGroupsModel.fromJson(value.data);

      if (getProductGroupsModel.errorCode == 0) {
        ProductGroupItems = getProductGroupsModel.data;

        for (var element in getProductGroupsModel.data) {
          ProductGroupString.add(element.name);
        }

        emit(HomeGetProductGroupsSuccessState());
      } else {
        emit(HomeGetProductGroupsErrorState());
        if (showErr == true) {
          showToast(
              text: getProductGroupsModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }
      }
    }).catchError((e) {
      emit(HomeGetProductGroupsErrorState());

      print(e.toString());
    });
  }

  List<ProductGroupData> ProductGroupItems = [];
  List<String> ProductGroupString = [];

  // Get Product

  ProductModel productModel;

  Future getProduct(ProductGroupID, bool showErr) {
    // EasyLoading.show(
    //   status: 'loading...',
    // );
    emit(HomeGetProductLoadingState());

    DioHelper.getData(url: GetProducts, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'ProductGroupID': ProductGroupID,
      'languageId': 2,
    }).then((value) {
      ProductItems = [];
      ProductString = [];
      productModel = ProductModel.fromJson(value.data);
      if (productModel.errorCode == 0) {
        ProductItems = productModel.data;

        for (var element in productModel.data) {
          ProductString.add(element.name);
        }
        EasyLoading.dismiss();
        enableProduct = true;

        emit(HomeGetProductSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: productModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        EasyLoading.dismiss();
        enableProduct = true;

        emit(HomeGetProductErrorState());
      }
    }).catchError((e) {
      emit(HomeGetProductErrorState());
      enableProduct = true;

      EasyLoading.dismiss();

      print(e.toString());
    });
  }

  List<ProductData> ProductItems = [];
  List<String> ProductString = [];

  // Get Category

  CategoryModel categoryModel;

  Future getCategory(bool showErr) {
    emit(HomeGetCategoryLoadingState());

    DioHelper.getData(url: GetCategories, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'languageId': 2,
    }).then((value) {
      CategoryItems = [];
      CategoryString = [];
      categoryModel = CategoryModel.fromJson(value.data);
      if (categoryModel.errorCode == 0) {
        CategoryItems = categoryModel.data;

        for (var element in categoryModel.data) {
          CategoryString.add(element.name);
        }

        emit(HomeGetCategorySuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: categoryModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }
        emit(HomeGetCategoryErrorState());
      }
    }).catchError((e) {
      emit(HomeGetCategoryErrorState());
      print(e.toString());
    });
  }

  List<CategoryData> CategoryItems = [];
  List<String> CategoryString = [];

  // Get SubCategory

  SubCategoryModel subCategoryModel;

  Future getSubCategory(MainCategoryID, bool shoeErr) {
    // EasyLoading.show(
    //   status: 'loading...',
    // );
    emit(HomeGetSubCategoryLoadingState());

    DioHelper.getData(url: GetSubCategories, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'MainCategoryID': MainCategoryID,
      'languageId': 2,
    }).then((value) {
      subCategoryModel = SubCategoryModel.fromJson(value.data);

      if (subCategoryModel.errorCode == 0) {
        SubCategoryItems = [];
        SubCategoryString = [];
        SubCategoryItems = subCategoryModel.data;

        for (var element in subCategoryModel.data) {
          SubCategoryString.add(element.name);
        }
        EasyLoading.dismiss();
        emit(HomeGetSubCategorySuccessState());
      } else {
        if (shoeErr == true) {
          showToast(
              text: subCategoryModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }
        EasyLoading.dismiss();

        emit(HomeGetSubCategoryErrorState());
      }
      enableSubCategory = true;
    }).catchError((e) {
      enableSubCategory = true;
      emit(HomeGetSubCategoryErrorState());
      EasyLoading.dismiss();

      print(e.toString());
    });
  }

  List<SubCategoryData> SubCategoryItems = [];
  List<String> SubCategoryString = [];

  String initialValue = '';

  bool isCaseDetail = false;

  CaseDetailsModel caseDetailsModel;

  void onClickCase({context, int id}) {
    emit(HomeOnClickOnCasesLoadingState());
    EasyLoading.show(status: 'loading...');
    selectedCustomerCustomerId = 0;

    DioHelper.getData(
      url: GetCaseDetails,
      token: TOKEN,
      query: {
        'clientName': ClientName,
        'userName': UserName,
        'deviceId': '',
        'caseId': id,
        'languageId': 2
      },
    ).then((value) async {
      caseDetailsModel = CaseDetailsModel.fromJson(value.data);
      if (caseDetailsModel.errorCode == 0) {
        print('777777777777');
        print(value.data.toString());
        isCaseDetail = true;
        caseNumber = caseDetailsModel.data.caseNumber;
        caseId = caseDetailsModel.data.id;
        selectedCustomerCustomerId = caseDetailsModel.data.customerID;
        txtCaseSubjectController.text = caseDetailsModel.data.subject ?? '';

        txtDescriptionController.text = caseDetailsModel.data.description ?? '';
        // txtDescriptionHtmlController.editorController( ).;
        txtUserNameController.text = caseDetailsModel.data.customerName ?? '';
        initialValue = caseDetailsModel.data.customerName ?? '';
        txtCustomerEmailController.text =
            caseDetailsModel.data.customerEmail ?? '';
        txtCustomerPhoneController.text =
            caseDetailsModel.data.customerMobile ?? '';
        attachments = [];
        attachments = caseDetailsModel.data.attachments.attachments ?? [];
        notes = [];
        notes = caseDetailsModel.data.notes ?? [];
        creationDate = caseDetailsModel.data.createdOn.toString() ?? '';
        slaColor = caseDetailsModel.data.sLAColor != null &&
                caseDetailsModel.data.sLAColor != ''
            ? HexColor(caseDetailsModel.data.sLAColor)
            : Colors.white;

        Type = TypesItems.firstWhere((element) =>
                element.id == caseDetailsModel.data.caseTypeValue).name ??
            TypesItems.firstWhere(
                    (element) => element.id == getTypesModel.data.deaultTypeId)
                .name;

        StateValue = StatusItems.firstWhere(
                (element) => element.id == caseDetailsModel.data.status).name ??
            StatusItems.firstWhere((element) => element.id == -1).name;

        priorityValue = PrioritiesItems.firstWhere((element) =>
                element.id == caseDetailsModel.data.casePriorityValue).name ??
            PrioritiesItems.firstWhere((element) => element.id == -1).name;

        CategoryValue = CategoryItems.firstWhere((element) =>
                element.id == caseDetailsModel.data.caseCategoryValue).name ??
            CategoryItems.firstWhere((element) => element.id == -1).name;

        if (caseDetailsModel.data.caseCategoryValue > 0) {
          await getSubCategory(caseDetailsModel.data.caseCategoryValue, true);

          SubCategoryValue = SubCategoryItems.firstWhere((element) =>
                      element.id == caseDetailsModel.data.caseSubCategoryValue)
                  .name ??
              SubCategoryItems.firstWhere((element) => element.id == -1).name;
        } else {
          getSubCategory('', true);
          SubCategoryValue = SubCategoryItems.firstWhere((element) =>
                      element.id == caseDetailsModel.data.caseSubCategoryValue)
                  .name ??
              SubCategoryItems.firstWhere((element) => element.id == -1).name;
        }

        ProductGroupValue = ProductGroupItems.firstWhere((element) =>
                    element.id == caseDetailsModel.data.caseProductGroupValue)
                .name ??
            ProductGroupItems.firstWhere((element) => element.id == -1).name;

        if (caseDetailsModel.data.caseProductGroupValue > 0) {
          await getProduct(caseDetailsModel.data.caseProductGroupValue, true);
          if (ProductItems.any((element) =>
              element.id == caseDetailsModel.data.caseProductValue)) {
            ProductValue = ProductItems.firstWhere((element) =>
                        element.id == caseDetailsModel.data.caseProductValue)
                    .name ??
                ProductItems.firstWhere((element) => element.id == -1).name;
          } else {
            ProductValue =
                ProductItems.firstWhere((element) => element.id == -1).name;
          }
        } else {
          await getProduct('', true);
          ProductValue = ProductItems.firstWhere((element) =>
                  element.id == caseDetailsModel.data.caseProductValue).name ??
              ProductItems.firstWhere((element) => element.id == -1).name;
        }

        selectedUser = [];
        for (var element in caseDetailsModel.data.userIds) {
          var user = userItems.firstWhere((element2) => element2.id == element);
          if (user != null) {
            selectedUser.add(user);
          } else {
            selectedUser = [];
          }
        }
        selectedOU = [];
        for (var element in caseDetailsModel.data.ouIds) {
          var ou = OUItems.firstWhere((element2) => element2.id == element);
          if (ou != null) {
            selectedOU.add(ou);
          } else {
            selectedOU = [];
          }
        }

        selectedGroups = [];
        for (var element in caseDetailsModel.data.userGroupIds) {
          var group =
              groupItems.firstWhere((element2) => element2.id == element);
          if (group != null) {
            selectedGroups.add(group);
          } else {
            selectedGroups = [];
          }
        }

        Source = SourcesItems.firstWhere((element) =>
                element.id == caseDetailsModel.data.caseSourceValue).name ??
            SourcesItems.firstWhere((element) => element.id == 9).name;
        emit(HomeOnClickOnCasesSuccessState());
        Timer(const Duration(seconds: 2), () {
          EasyLoading.dismiss();
          navigateTo(context: context, widget: AddCase());
        });
      } else {
        isCaseDetail = false;

        EasyLoading.dismiss();
        showToast(
            text: caseDetailsModel.errorDescription.toString(),
            state: ToastState.ERROR);
      }
    }).catchError((e) {
      print('3333333333333333');
      isCaseDetail = false;
      EasyLoading.dismiss();
      print(e.toString());
      noInternetConnection();
      clean(context);
      emit(HomeOnClickOnCasesErrorState());
    });

    // selectedDate.toString()=endDate;
  }

  Widget displayMultiSelect(context, index, CaseModel caseModel) {
    if (caseModel.userIds.isNotEmpty &&
        userItems.any((element) => element.id == caseModel.userIds[0])) {
      return Text(
        userItems
                .firstWhere((element) => element.id == caseModel.userIds[0])
                .name ??
            '',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 13,
          color: selectedColor,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (caseModel.ouIds.isNotEmpty) {
      return Text(
        OUItems[index].name ?? '',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 13,
          color: selectedColor,
          fontWeight: FontWeight.w500,
        ),
      );
    } else if (caseModel.userGroupIds.isNotEmpty &&
        groupItems.any((element) => element.id == caseModel.userGroupIds[0])) {
      return Text(
        groupItems[index].name ?? '',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 13,
          color: selectedColor,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  List<Notes> caseNotes = [];

  void getCaseNotes() {}

  //////////////////////////// Add Case Screen  //////////////////////////

  // TextEditingControllers in add ticket screen
  var txtUserNameController = TextEditingController();
  var txtCustomerEmailController = TextEditingController();
  var txtCustomerPhoneController = TextEditingController();
  var txtCaseSubjectController = TextEditingController();
  TextEditingController fieldTextEditingController = TextEditingController();
  var txtCaseDateController = TextEditingController();
  var txtDescriptionController = TextEditingController();

  int caseNumber;
  int caseId;
  String creationDate;
  var addCaseFormKey = GlobalKey<FormState>();

  // Drop Down Button Values in add ticket screen
  String priorityValue = "- - - Select - - -";
  String StateValue = "- - - Select - - -";
  String ProductGroupValue = "- - - Select - - -";
  String ProductValue = "- - - Select - - -";
  String CategoryValue = "- - - Select - - -";
  String SubCategoryValue = "- - - Select - - -";
  String Type = '';
  String Source = "1StopDesk";
  Color slaColor;

  String displayStringForOption(CustomerData option) => option.name;

  String customerName;

  void getCustomerName() {}

  Future clean(context) {
    EasyLoading.show(
      status: 'loading...',
    );
    //bottomNavCurrentIndex = 0;
    if (isOffline == false) {
      getProduct('', true);
      getSubCategory('', true);
    }

    isCaseDetail = false;
    initialValue = '';
    ProductGroupValue =
        ProductGroupItems.firstWhere((element) => element.id == -1).name;
    CategoryValue =
        CategoryItems.firstWhere((element) => element.id == -1).name;

    txtUserNameController.clear();
    txtCaseSubjectController.clear();
    // txtCaseDateController.clear();
    txtDescriptionController.clear();
    txtCustomerPhoneController.clear();
    txtCustomerEmailController.clear();
    selectedGroups = [];
    selectedOU = [];
    selectedUser = [];

    caseNumber = 0;
    creationDate = '';
    ProductGroupValue =
        ProductGroupItems.firstWhere((element) => element.id == -1).name;
    ProductValue = ProductItems.firstWhere((element) => element.id == -1).name;
    CategoryValue =
        CategoryItems.firstWhere((element) => element.id == -1).name;
    SubCategoryValue =
        SubCategoryItems.firstWhere((element) => element.id == -1).name;
    priorityValue =
        PrioritiesItems.firstWhere((element) => element.id == -1).name;
    Source = SourcesItems.firstWhere((element) => element.id == 9).name;
    Type = TypesItems.firstWhere(
        (element) => element.id == getTypesModel.data.deaultTypeId).name;
    StateValue = StatusItems.firstWhere((element) => element.id == -1).name;

    if (inCaseHistory == true) {
      Navigator.pop(context);
      EasyLoading.dismiss();
      inCaseHistory = false;
      emit(HomeAddCaseCleanState());
    } else {
      navigateAndFinish(context: context, widget: HomeLayout());
      bottomNavCurrentIndex = 0;
      emit(HomeAddCaseCleanState());
      EasyLoading.dismiss();
    }
  }

  CustomersModel customersBySearchInAddCaseScreenModel;
  List<CustomerData> CustomerBySearchInAddCaseScreen = [];

  Future getCustomerBySearchInAddCaseScreen(
    context,
  ) {
    EasyLoading.show(
      status: 'loading...',
    );

    CustomerBySearchInAddCaseScreen = [];

    emit(GetCustomersBySearchAddCassScreenLoadingState());

    DioHelper.getData(url: GetCustomersBySearch, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'StartingRowNo': CustomerBySearchInAddCaseScreen.length,
      'RequestedRowCount': 100,
      'deviceId': '',
      'psearchword':
          txtAddCustomerSearchInAddCaseScreenController.text.trim().toString(),
      'languageId': 2,
    }).then((value) {
      customersBySearchInAddCaseScreenModel =
          CustomersModel.fromJson(value.data);
      print(customersBySearchInAddCaseScreenModel.customerData.toString());

      if (customersBySearchInAddCaseScreenModel.errorCode == 0) {
        CustomerBySearchInAddCaseScreen = [];
        CustomerBySearchInAddCaseScreen =
            customersBySearchInAddCaseScreenModel.customerData;

        EasyLoading.dismiss();

        emit(GetCustomersBySearchAddCassScreenSuccessState());
      } else {
        showToast(
            text: customersBySearchInAddCaseScreenModel.errorDescription
                .toString(),
            state: ToastState.ERROR);
        EasyLoading.dismiss();

        emit(GetCustomersBySearchAddCassScreenErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      EasyLoading.dismiss();

      emit(GetCustomersBySearchAddCassScreenErrorState());
    });
  }

  // List to display priority items in drop down button

// Void to change priority value when pressed on it

  void changePriorityValue(String newValue) {
    priorityValue = newValue;
    emit(HomePriorityValueState());
  }

  // List to display state items in drop down button

  Color changeStateColor(String value) {
    if (value == 'Open') {
      return HexColor('#337AB7');
    } else if (value == 'Closed ') {
      return HexColor('#36C6D3');
    } else if (value == 'Escalated') {
      return Colors.red.shade400;
    } else if (value == 'Waiting for customer') {
      return HexColor('#808080');
    } else if (value == 'Reopened') {
      return HexColor('#93BDA8');
    } else if (value == 'Need Budget') {
      return HexColor('#6FBBD3');
    } else if (value == 'Referred to external Entity') {
      return HexColor('#6FBBD3');
    } else if (value == 'In Progress') {
      return HexColor('#6FBBD3');
    } else if (value == 'Solved') {
      return HexColor('#6FBBD3');
    } else if (value == 'Deferred') {
      return HexColor('#6FBBD3');
    } else if (value == 'Temporary Fix') {
      return HexColor('#6FBBD3');
    } else if (value == 'Implemented') {
      return HexColor('#08C7C7');
    } else if (value == 'Assessment Compeleted') {
      return HexColor('#08C7C7');
    } else if (value == 'Due Today') {
      return HexColor('#ED6B75');
    } else if (value == 'New') {
      return HexColor('#228B22');
    } else {
      return Colors.blueGrey;
    }
  }

// Void to change state value when pressed on it

  void changeStateValue(String newValue) {
    StateValue = newValue;
    emit(HomeStateValueState());
  }

  // List to display type items in drop down button

// Void to change type value when pressed on it

  void changeTypeValue(String newValue, context) {
    Type = newValue;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeChangeValueState());
  }

  // List to display Source items in drop down button

// Void to change Source value when pressed on it

  void changeSourceValue(String newValue, context) {
    Source = newValue;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeSourceValueState());
  }

  // List to display group items in drop down button
  bool enableProduct = true;

// Void to change group value when pressed on it
  void changeProductGroupValue(String newValue, context) {
    ProductValue = ProductItems.firstWhere((element) => element.id == -1).name;

    ProductGroupValue = newValue;
    enableProduct = false;

    getProduct(
        ProductGroupItems.firstWhere((element) => element.name == newValue).id,
        true);
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeChangeProductGroupValueState());
  }

// Void to change group value when pressed on it
  void changeProductValue(String newValue, context) {
    ProductValue = newValue;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeChangeProductValueState());
  }

  bool enableSubCategory = true;

  // Upload Attachment

  File selectedFile;

  Future selectFile(int caseId) async {
    await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    ).then((value) async {
      print(value.names.toString());
      if (value != null) {
        selectedFile = File(value.files.single.path);
        await uploadFile(caseId);
      } else {
        print('notFound ----------------');
        showToast(text: 'No files selected', state: ToastState.ERROR);
      }
    });

    emit(HomeChooseAttachmentState());
    // setState((){}); //update the UI so that file name is shown
  }

  Future uploadFile(int caseId) async {
    EasyLoading.show(status: 'loading...');

    emit(HomeUploadAttachmentLoadingState());

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(selectedFile.path,
          filename: basename(selectedFile.path)
          //show only filename from path
          ),
      'clientName': ClientName,
      'userName': UserName,
      'deviceId': '',
      'caseId': caseId,
      'languageId': 2
    });

    DioHelper.uploadData(
      token: TOKEN,
      data: formData,
      url: UploadAttachment,
    ).then((value) {
      print(value.data.toString());
      print(value.statusMessage.toString());
      attachments.add(AttachmentData(
        clientId: value.data['data']['ClientId'],
        fileName: value.data['data']['fileName'],
        filePath: value.data['data']['filePath'],
      ));

      showToast(text: 'Success', state: ToastState.SUCCESS);
      emit(HomeUploadAttachmentSuccessState());
      EasyLoading.dismiss();
    }).catchError((e) {
      EasyLoading.dismiss();

      print(e.toString());

      showToast(text: 'Some thing wrong', state: ToastState.ERROR);
      emit(HomeUploadAttachmentErrorState());
    });
  }

// Void to change group value when pressed on it
  void changeCategoryValue(String newValue, context) {
    enableSubCategory = false;

    SubCategoryValue =
        SubCategoryItems.firstWhere((element) => element.id == -1).name;
    CategoryValue = newValue;

    getSubCategory(
        CategoryItems.firstWhere((element) => element.name == newValue).id,
        true);
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeChangeCategoryValueState());
  }

// Void to change group value when pressed on it
  void changeSubCategoryValue(String newValue, context) {
    SubCategoryValue = newValue;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeChangeSubCategoryValueState());
  }

  // Void to change color in drop down button
  Color changePriorityColor(String value) {
    if (value == 'Normal') {
      return Colors.grey;
    } else if (value == 'High') {
      return Colors.red;
    } else if (value == 'Medium') {
      return Colors.yellow;
    } else if (value == 'Low') {
      return Colors.green;
    } else if (value == '- - - Select - - -') {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  IconData changeSourceIcon(String value) {
    if (value == 'Email') {
      return FlutterIcons.email_outline_mco;
    } else if (value == '1StopDesk') {
      return Icons.phone_android;
    } else if (value == 'Web Forms') {
      return Feather.globe;
    } else if (value == 'Customer Portal') {
      return FlutterIcons.laptop_faw;
    } else if (value == 'Call Center') {
      return Feather.phone;
    } else if (value == 'Facebook') {
      return Feather.facebook;
    } else if (value == 'Twitter') {
      return Feather.twitter;
    } else if (value == 'Fax') {
      return Icons.fax_outlined;
    } else if (value == 'Internally Reported') {
      return FlutterIcons.institution_faw;
    } else if (value == null) {
      return FlutterIcons.institution_faw;
    } else if (value == null) {
      return FlutterIcons.institution_faw;
    } else {
      return Icons.phone_android;
    }
  }

  // Date of selected
  DateTime selectedDate = DateTime.now();

  // Date of now

  DateTime now = DateTime.now();

  // Void to select date
  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     txtCaseDateController.text = picked.toString();
  //     selectedDate = picked;
  //   }
  //   selectTime(context);
  //   emit(HomeAddCaseSelectedDateState());
  // }

  // Time of selected
  TimeOfDay selectedTime = TimeOfDay.now();

  // Time of now
  TimeOfDay timeNow = TimeOfDay.now();

  // Void to select time
  void selectTime(context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (newTime != null) {
      selectedTime = newTime;
      emit(HomeAddCaseSelectedDateState());
    }
    emit(HomeAddCaseSelectedDateState());
  }

  // Void to fill ticket model and add new ticket in ticketItemsHome
  void addCase(context) {
    EasyLoading.show(status: 'loading...');

    emit(HomeAddCaseLoadingState());
    if (txtCustomerEmailController.text != null &&
        txtCustomerEmailController.text != '') {
      print(ClientName);
      print(UserName);

      List<int> users = [];

      for (var element in selectedUser) {
        users.add(element.id);
      }

      List<int> groups = [];
      for (var element in selectedGroups) {
        groups.add(element.id);
      }
      List<int> ous = [];
      for (var element in selectedOU) {
        ous.add(element.id);
      }
      // List<int> role = [];

      DioHelper.postData(data: {
        'clientName': ClientName,
        'name': txtUserNameController.text.trim(),
        'email': txtCustomerEmailController.text.trim() ?? '',
        'subject': txtCaseSubjectController.text.trim(),
        'description': txtDescriptionController.text.trim(),
        'TypeId': TypesItems.firstWhere((element) => element.name == Type).id ??
            getTypesModel.data.deaultTypeId,
        'productGroupId': ProductGroupItems.firstWhere(
                (element) => element.name == ProductGroupValue).id ??
            -1,
        'productId':
            ProductItems.firstWhere((element) => element.name == ProductValue)
                    .id ??
                -1,
        'categoryId':
            CategoryItems.firstWhere((element) => element.name == CategoryValue)
                    .id ??
                -1,
        'SubcategoryId': SubCategoryItems.firstWhere(
                (element) => element.name == SubCategoryValue).id ??
            -1,
        'StatusId':
            StatusItems.firstWhere((element) => element.name == StateValue)
                    .id ??
                -1,
        'PriorityId': PrioritiesItems.firstWhere(
                (element) => element.name == priorityValue).id ??
            -1,
        'assignedUserIds': users.join(','),
        'UserGroupids': groups.join(','),
        'OuiIds': ous.join(','),
        // 'RoleIds': '',
        'sourceid':
            SourcesItems.firstWhere((element) => element.name == Source).id ??
                9,
        'customerid': selectedCustomerCustomerId,
        'customertype': selectedCustomerCustomerType,
      }, url: SubmitNewCase, token: TOKEN)
          .then((value) async {
        print(value.data.toString());
        print('8888888888888888888888888');

        await getAllCases(context, 0, true);

        clean(context);

        EasyLoading.dismiss();
        showToast(
            text: 'Operation completed successfully',
            state: ToastState.SUCCESS);
        emit(HomeAddCaseSuccessState());
      }).catchError((e) {
        EasyLoading.dismiss();

        noInternetConnection();
        print(e.toString());
        print('999999999999999999999999');

        emit(HomeAddCaseErrorState());
      });
    } else {
      EasyLoading.dismiss();

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Error',
                      style: TextStyle(
                          color: selectedColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text('Please choose a customer!!!',
                  style: TextStyle(
                      color: selectedColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              ],
            );
          });
    }
  }

  void updateCase(int id, context, int customerId) {
    EasyLoading.show(status: 'loading...');

    emit(HomeUpdateCaseLoadingState());
    if (StateValue != "- - - Select - - -") {
      List<int> users = [];

      for (var element in selectedUser) {
        users.add(element.id);
      }

      List<int> groups = [];
      for (var element in selectedGroups) {
        groups.add(element.id);
      }
      List<int> ous = [];
      for (var element in selectedOU) {
        ous.add(element.id);
      }
      // List<int> role = [];

      DioHelper.postData(
        token: TOKEN,
        url: UpdateCase,
        data: {
          'clientName': ClientName,
          'UserName': UserName,
          'deviceId': '',
          'ComplaintId': id,
          'subject': txtCaseSubjectController.text.trim() ?? '',
          'description': txtDescriptionController.text.trim() ?? '',
          'statusid':
              StatusItems.firstWhere((element) => element.name == StateValue)
                      .id ??
                  -1,
          'typeid':
              TypesItems.firstWhere((element) => element.name == Type).id ??
                  getTypesModel.data.deaultTypeId,
          'priorityid': PrioritiesItems.firstWhere(
                  (element) => element.name == priorityValue).id ??
              -1,
          'ProductGroupID': ProductGroupItems.firstWhere(
                  (element) => element.name == ProductGroupValue).id ??
              -1,
          'ProductID':
              ProductItems.firstWhere((element) => element.name == ProductValue)
                      .id ??
                  -1,
          'CategoryID': CategoryItems.firstWhere(
                  (element) => element.name == CategoryValue).id ??
              -1,
          'SubCategoryID': SubCategoryItems.firstWhere(
                  (element) => element.name == SubCategoryValue).id ??
              -1,
          'customerid': customerId ??
              customerItems
                  .firstWhere((element) =>
                      element.email == txtCustomerEmailController.text)
                  .iD,
          'assignedUserIds': users.join(',') ?? 0,
          'UserGroupids': groups.join(',') ?? 0,
          'OuiIds': ous.join(',') ?? 0,
          // 'RoleIds': 6502,
          'languageId': 2,
          'sourceid':
              SourcesItems.firstWhere((element) => element.name == Source).id ??
                  -1,
        },
      ).then((value) async {
        print('sososososososososos');

        await getAllCases(context, 0, true);
        clean(context);

        showToast(
            text: 'Operation completed successfully',
            state: ToastState.SUCCESS);

        emit(HomeUpdateCaseSuccessState());
      }).catchError((e) {
        print('333333333333333');
        noInternetConnection();
        EasyLoading.dismiss();

        print(e.toString());
        emit(HomeUpdateCaseErrorState());
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Error',
                      style: TextStyle(
                          color: selectedColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text('Please choose a status !!!',
                  style: TextStyle(
                      color: selectedColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              ],
            );
          });

      EasyLoading.dismiss();
    }
  }

  bool customerShow = true;
  String selectedCustomerName;
  String selectedCustomerPhone;
  String selectedCustomerEmail;
  String selectedCustomerCustomerType;
  int selectedCustomerCustomerId;

  void selectCustomer(
      String name, String phone, String email, String type, int id) {
    selectedCustomerName = name;
    selectedCustomerPhone = phone;
    selectedCustomerEmail = email;
    selectedCustomerCustomerType = type;
    selectedCustomerCustomerId = id;
    txtUserNameController.text = name;

    txtCustomerEmailController.text = email;
    txtCustomerPhoneController.text = phone;

    emit(HomeAddCaseSelectedCustomerState());
  }

// select users

  UserModel userModel;

  Future getUsers(bool showErr) {
    emit(HomeGetUsersLoadingState());
    DioHelper.getData(url: GetAssignments, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'AssignmentType': 'user',
      'languageId': 2,
    }).then((value) {
      debugPrint('----------------------------------');

      debugPrint(value.data.toString());
      debugPrint('----------------------------------');
      userItems = [];

      selectedUser = [];
      userModel = UserModel.fromJson(value.data);

      if (userModel.errorCode == 0) {
        userItems = userModel.data;

        emit(HomeGetUsersSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: userModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetUsersErrorState());
      }
    }).catchError((e) {
      emit(HomeGetUsersErrorState());
      print(e.toString());
    });
  }

  List<UserData> userItems = [];

  List<UserData> selectedUser = [];

  void selectUser(val, context) {
    FocusScope.of(context).requestFocus(FocusNode());

    selectedUser = val;
    print(val.runtimeType.toString());
    emit(HomeAddCaseSelectedUserState());
  }

  // select OU
  OUModel ouModel;

  Future getOus(bool showErr) {
    emit(HomeGetOuLoadingState());
    DioHelper.getData(url: GetAssignments, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'AssignmentType': 'ou',
      'languageId': 2,
    }).then((value) {
      OUItems = [];
      selectedOU = [];
      ouModel = OUModel.fromJson(value.data);

      if (ouModel.errorCode == 0) {
        OUItems = ouModel.data;

        emit(HomeGetOuSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: ouModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetOuErrorState());
      }
    }).catchError((e) {
      emit(HomeGetOuErrorState());
      print(e.toString());
    });
  }

  List<OuData> OUItems = [];
  List<OuData> selectedOU = [];

  void selectOU(val, context) {
    selectedOU = val;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeAddCaseSelectedOUState());
  }

  // select Group

  GroupModel groupModel;

  Future getGroups(bool showErr) {
    emit(HomeGetGroupsLoadingState());
    DioHelper.getData(url: GetAssignments, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'AssignmentType': 'usergroup',
      'languageId': 2,
    }).then((value) {
      groupItems = [];

      selectedGroups = [];
      groupModel = GroupModel.fromJson(value.data);
      if (groupModel.errorCode == 0) {
        groupItems = groupModel.data;

        emit(HomeGetGroupsSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: groupModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(HomeGetGroupsErrorState());
      }
    }).catchError((e) {
      emit(HomeGetGroupsErrorState());
      print(e.toString());
    });
  }

  List<GroupData> groupItems = [];

  List<GroupData> selectedGroups = [];

  void selectGroup(val, context) {
    selectedGroups = val;
    FocusScope.of(context).requestFocus(FocusNode());

    emit(HomeAddCaseSelectedGroupState());
  }

  // Display attachment

  List<AttachmentData> attachments = [];

  void downloadAttachment(String url) {
    String downloadUrl = 'http://$dOMAiN.qa.$dOMAiN.com/$url';

    launch(downloadUrl);
  }

  // Display notes

  List<Notes> notes = [];

  // var txtAddNoteController = HtmlEditorController();
  var txtAddNoteController = TextEditingController();
  final addNoteFormKey = GlobalKey<FormState>();

  bool showToCustomer = false;

  void changeCheekBox(bool value) {
    showToCustomer = value;
    emit(HomeAddNoteChangeCustomerShowState());
  }

  NotesModel notesModel;

  Future addNote(
    context,
    int CaseId,
    String textNote,
    bool showToCustomer,
  ) async {
    emit(HomeAddNoteLoadingState());
    print('/////////////////////////////////////');

    print(CaseId.toString());
    // print(textNote.toString());

    print(showToCustomer.toString());
    print('/////////////////////////////////////');

    DioHelper.postData(
      token: TOKEN,
      url: AddNote,
      data: {
        'clientName': ClientName,
        'UserName': UserName,
        'DeviceId': '',
        'NoteDescription': textNote,
        'ComplaintId': CaseId,
        'ShowToCustomer': showToCustomer,
      },
    ).then((value) {
      notesModel = NotesModel.fromJson(value.data);
      if (notesModel.errorCode == 0) {
        Notes c = Notes(
          note: notesModel.data.noteDescription,
          createdBy: Name,
          id: CaseId,
        );

        notes.add(c);

        print(value.data.toString());
        txtAddNoteController.clear();

        Navigator.pop(context);

        emit(HomeAddNoteSuccessState());
      } else {
        showToast(
            text: notesModel.errorDescription.toString(),
            state: ToastState.ERROR);
        emit(HomeAddNoteErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      emit(HomeAddNoteErrorState());
    });
  }

////////////////////////// Customers Screen  ////////////////////////////

  CustomersModel customersModel;
  ScrollController customersScrollController = ScrollController();

  Future getCustomers(bool showErr) {
    emit(GetCustomersLoadingState());
    customerItems = [];
    customerItemsSearch = [];

    DioHelper.getData(url: GetCustomers, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': customerItems.length,
      'RequestedRowCount': 20,
      'languageId': 2
    }).then((value) {
      customersModel = CustomersModel.fromJson(value.data);
      if (customersModel.errorCode == 0) {
        customerItems = customersModel.customerData;

        customerItemsSearch = customerItems;
        CustomerBySearchInAddCaseScreen = customerItems;

        // CustomerBySearch=customerItems;

        emit(GetCustomersSuccessState());
      } else {
        if (showErr == true) {
          showToast(
              text: customersModel.errorDescription.toString(),
              state: ToastState.ERROR);
        }

        emit(GetCustomersErrorState());
      }
    }).catchError((e) {
      print(e.toString());
      emit(GetCustomersErrorState());
    });
  }

  CustomersModel moreCustomersModel;

  void getMoreCustomers() {
    emit(GetMoreCustomersLoadingState());

    DioHelper.getData(url: GetCustomers, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': customerItems.length,
      'RequestedRowCount': customerItems.length + 25,
      'languageId': 2
    }).then((value) {
      moreCustomersModel = CustomersModel.fromJson(value.data);
      if (moreCustomersModel.errorCode == 0) {
        if (moreCustomersModel.customerData.isNotEmpty) {
          for (var element in moreCustomersModel.customerData) {
            customerItems.add(element);
          }
        }

        customerItemsSearch = customerItems;

        emit(GetMoreCustomersSuccessState());
      } else {
        showToast(
            text: moreCustomersModel.errorDescription.toString(),
            state: ToastState.ERROR);
        emit(GetMoreCustomersErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      emit(GetMoreCustomersErrorState());
    });
  }

  CustomersModel moreSearchCustomersModel;

  void getMoreSearchCustomers() {
    emit(GetMoreSearchCustomersLoadingState());

    DioHelper.getData(url: GetCustomers, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': customerItems.length,
      'RequestedRowCount': customerItems.length + 25,
      'languageId': 2
    }).then((value) {
      moreCustomersModel = CustomersModel.fromJson(value.data);
      if (moreCustomersModel.customerData.isNotEmpty) {
        for (var element in moreCustomersModel.customerData) {
          customerItems.add(element);
        }
      }

      customerItemsSearch = customerItems;

      emit(GetMoreSearchCustomersSuccessState());
    }).catchError((e) {
      showToast(text: e.toString(), state: ToastState.ERROR);
      print(e.toString());
      emit(GetMoreSearchCustomersErrorState());
    });
  }

  CustomersModel moreSearchCustomersInAddCaseScreenModel;
  List<CustomerData> customerItemsInAddCaseScreen = [];

  void getMoreSearchInCaseScreenCustomers() {
    emit(GetMoreSearchCustomersInAddCaseScreenLoadingState());

    DioHelper.getData(url: GetCustomers, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'psearchword':
          txtAddCustomerSearchInAddCaseScreenController.text.trim().toString(),
      'StartingRowNo': CustomerBySearchInAddCaseScreen.length,
      'RequestedRowCount': CustomerBySearchInAddCaseScreen.length + 100,
      'languageId': 2
    }).then((value) {
      moreSearchCustomersInAddCaseScreenModel =
          CustomersModel.fromJson(value.data);
      if (moreSearchCustomersInAddCaseScreenModel.customerData.isNotEmpty) {
        for (var element
            in moreSearchCustomersInAddCaseScreenModel.customerData) {
          customerItemsInAddCaseScreen.add(element);
        }
      }

      CustomerBySearchInAddCaseScreen = customerItemsInAddCaseScreen;

      emit(GetMoreSearchCustomersInAddCaseScreenSuccessState());
    }).catchError((e) {
      showToast(text: e.toString(), state: ToastState.ERROR);
      print(e.toString());
      emit(GetMoreSearchCustomersInAddCaseScreenErrorState());
    });
  }

  List<CustomerData> customerItems = [];

  var txtCustomerSearchController = TextEditingController();
  var txtAddCustomerSearchInAddCaseScreenController = TextEditingController();
  final searchCustomerScreenFormKey = GlobalKey<FormState>();
  final searchCustomerInAddCaseScreenFormKey = GlobalKey<FormState>();
  ScrollController homeSearchCustomerScrollController = ScrollController();
  ScrollController homeSearchCustomerInAddCaseScreenScrollController =
      ScrollController();

  List<CustomerData> customerItemsSearch = [];

  CustomersDetailsModel customersDetailsModel;
  CustomerDetailData customerDetailData;

  void getCustomerDetails(int CustomerId, context, String type) {
    EasyLoading.show(
      status: 'loading...',
    );

    emit(GetCustomerDetailsLoadingState());

    DioHelper.getData(url: GetCustomerDetails, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'CustomerType': type,
      'CustomerId': CustomerId,
      'languageId': 2
    }).then((value) {
      print('00000000000');
      print(value.data.toString());
      customersDetailsModel = CustomersDetailsModel.fromJson(value.data);
      customerDetailData = customersDetailsModel.data;
      EasyLoading.dismiss();
      navigateTo(
          context: context,
          widget: CustomerDetailScreen(
            customerDetailData: customerDetailData,
            customerType: type,
          ));

      emit(GetCustomerDetailsSuccessState());
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      EasyLoading.dismiss();

      emit(GetCustomerDetailsErrorState());
    });
  }

  void backToCustomerHome(context) {
    customerItemsSearch = [];
    EasyLoading.show(status: 'loading...');
    txtCustomerSearchController.clear();
    customerItemsSearch = customerItems;

    bottomNavCurrentIndex = 1;
    navigateAndFinish(context: context, widget: HomeLayout());
    EasyLoading.dismiss();

    emit(HomeBackSearchCustomerState());
  }

  AllCasesModel allCasesHistoryModel;
  List<CaseModel> caseHistoryItems = [];
  bool inCaseHistory = false;

  Future getAllCasesHistory(context, int id, String customerType) {
    inCaseHistory = true;
    EasyLoading.show(
      status: 'loading...',
    );

    caseHistoryItems = [];

    emit(CustomerDetailsGetCaseLoadingState());

    DioHelper.getData(url: GetCasesHistoryForCustomer, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'deviceId': '',
      'StartingRowNo': caseHistoryItems.length,
      'RequestedRowCount': 15,
      'CustomerId': id,
      'CustomerType': customerType[0],
      'languageId': 2,
    }).then((value) {
      print('77777777777777777777777');

      print(value.data.toString());
      print('77777777777777777777777');
      allCasesHistoryModel = AllCasesModel.fromJson(value.data);

      if (allCasesHistoryModel.errorCode == 0) {
        caseHistoryItems = [];

        caseHistoryItems = allCasesHistoryModel.caseModel;

        EasyLoading.dismiss();
        navigateTo(context: context, widget: CustomerCasesScreen());
        emit(CustomerDetailsGetCaseSuccessState());
      } else {
        showToast(
            text: allCasesHistoryModel.errorCode.toString(),
            state: ToastState.ERROR);
        emit(CustomerDetailsGetCaseErrorState());
        EasyLoading.dismiss();
      }
    }).catchError((e) {
      noInternetConnection();
      print('5555555555555555555555555555555');
      print(e.toString());
      print('5555555555555555555555555555555');
      caseHistoryItems = [];
      EasyLoading.dismiss();

      emit(CustomerDetailsGetCaseErrorState());
    });
  }

  CustomersModel customersBySearchModel;
  List<CustomerData> CustomerBySearch = [];

  Future getCustomerBySearch(
    context,
  ) {
    EasyLoading.show(
      status: 'loading...',
    );

    customerItemsSearch = [];

    emit(GetCustomersBySearchLoadingState());

    DioHelper.getData(url: GetCustomersBySearch, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'StartingRowNo': customerItemsSearch.length,
      'RequestedRowCount': 20,
      'deviceId': '',
      'psearchword': txtCustomerSearchController.text.trim().toString(),
      'languageId': 2,
    }).then((value) {
      customersBySearchModel = CustomersModel.fromJson(value.data);

      if (customersBySearchModel.errorCode == 0) {
        customerItemsSearch = [];

        customerItemsSearch = customersBySearchModel.customerData;

        EasyLoading.dismiss();

        emit(GetCustomersBySearchSuccessState());
      } else {
        showToast(
            text: customersBySearchModel.errorDescription.toString(),
            state: ToastState.ERROR);
        EasyLoading.dismiss();

        emit(GetCustomersBySearchErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      EasyLoading.dismiss();

      emit(GetCustomersBySearchErrorState());
    });
  }

  CustomersModel loadMoreCustomersBySearchModel;

  Future getLoadMoreCustomerBySearch(
    context,
  ) {
    EasyLoading.show(
      status: 'loading...',
    );

    emit(GetLoadMoreCustomersBySearchLoadingState());

    DioHelper.getData(url: GetCustomersBySearch, token: TOKEN, query: {
      'clientName': ClientName,
      'UserName': UserName,
      'StartingRowNo': customerItemsSearch.length,
      'RequestedRowCount': 50,
      'deviceId': '',
      'psearchword': txtCustomerSearchController.text.toString(),
      'languageId': 2,
    }).then((value) {
      loadMoreCustomersBySearchModel = CustomersModel.fromJson(value.data);
      if (loadMoreCustomersBySearchModel.errorCode == 0) {
        for (var element in loadMoreCustomersBySearchModel.customerData) {
          customerItemsSearch.add(element);
        }

        EasyLoading.dismiss();

        emit(GetLoadMoreCustomersBySearchSuccessState());
      } else {
        showToast(
            text: loadMoreCustomersBySearchModel.errorDescription.toString(),
            state: ToastState.ERROR);
        EasyLoading.dismiss();

        emit(GetLoadMoreCustomersBySearchErrorState());
      }
    }).catchError((e) {
      noInternetConnection();
      print(e.toString());
      EasyLoading.dismiss();

      emit(GetLoadMoreCustomersBySearchErrorState());
    });
  }

  Future getAllSearchCustomerWhenNoDataInput(String txt) {
    if (txt.isEmpty || txt == null || txt == '') {
      customerItemsSearch = [];
      customerItemsSearch = customerItems;
      emit(CustomerDetailsGetCaseSuccessState());
    }
  }

  Future getAllSearchCustomerInAddCaseScreenWhenNoDataInput(String txt) {
    if (txt.isEmpty || txt == null || txt == '') {
      CustomerBySearchInAddCaseScreen = [];
      CustomerBySearchInAddCaseScreen = customerItems;
      emit(CustomerDetailsGetCaseSuccessState());
    }
  }

  void callNumber(String phone) async {
    launch('tel://$phone');

    await FlutterPhoneDirectCaller.callNumber(phone);
  }

  //////////////////////////// Add new Customer screen  ////////////////////////////

  var txtContactFullNameController = TextEditingController();
  var txtContactEmailController = TextEditingController();
  var txtContactUserNameController = TextEditingController();
  var txtContactPasswordController = TextEditingController();
  var txtContactMobilePhoneController = TextEditingController();
  var txtContactPhoneController = TextEditingController();
  var txtContactAddressController = TextEditingController();
  final addCustomerFormKey = GlobalKey<FormState>();

  var txtContactRecordNoController = TextEditingController();
  var txtContactIDNoController = TextEditingController();

  String IdType = 'Passport';

  void changeIdTypeValue(String newValue) {
    IdType = newValue;
    emit(HomeChangeIdTypeValueState());
  }

  void addCustomer(
    context,
  ) {
    EasyLoading.show(
      status: 'loading...',
    );

    emit(HomeAddCustomersLoadingState());

    DioHelper.postData(data: {
      'clientName': ClientName,
      'fullname': txtContactFullNameController.text.trim().toString(),
      // 'username': 'user',
      'email': txtContactEmailController.text.trim().toString(),
      'accountId': txtContactIDNoController.text.trim().toString(),
      // 'password': 'pass',
      'address': txtContactAddressController.text.trim().toString(),
      'mobile': txtContactMobilePhoneController.text.trim().toString(),
      'phone': txtContactPhoneController.text.trim().toString(),
      'RecordNO': txtContactRecordNoController.text.trim().toString(),
      'IdType': IdTypesItems.firstWhere((element) => element.name == IdType).id,
      'IdNumber': txtContactIDNoController.text.trim().toString(),
      'languageID': 2
    }, url: RegisterNewCustomer, token: TOKEN)
        .then((value) async {
      print(value.data.toString());

      await getCustomers(true);
      // showToast(text: value.statusMessage, state: ToastState.SUCCESS);
      txtContactFullNameController.text = '';
      txtContactUserNameController.text = '';
      txtContactEmailController.text = '';
      txtContactIDNoController.text = '';
      txtContactPasswordController.text = '';
      txtContactAddressController.text = '';
      txtContactMobilePhoneController.text = '';
      txtContactPhoneController.text = '';
      txtContactRecordNoController.text = '';
      txtContactIDNoController.text = '';

      bottomNavCurrentIndex = 1;
      EasyLoading.dismiss();
      navigateAndFinish(context: context, widget: HomeLayout());
      showToast(
          text: 'Operation completed successfully', state: ToastState.SUCCESS);

      emit(HomeAddCustomersSuccessState());
    }).catchError((e) {
      noInternetConnection();
      EasyLoading.dismiss();

      emit(HomeAddCustomersErrorState());
    });
  }

////////////////////////////  Customer Details screen  ////////////////////////////

  void customerDetailsAddCase(context, String email, String name, String phone,
      String mobile, int id, String customerType) {
    selectedCustomerCustomerId = 0;
    txtUserNameController.text = name;
    selectedCustomerName = name;
    selectedCustomerCustomerId = id;
    txtCustomerEmailController.text = email;
    txtCustomerPhoneController.text = phone;
    selectedCustomerCustomerType = customerType;

    navigateTo(context: context, widget: const AddCase());
    emit(CustomerDetailsAddCaseState());
  }

  /////////sort
  convertFullDateformate2(String date) {
    try {
      DateTime now = DateTime.parse(date);
      var todayDate = DateFormat("dd-MM-yyyy hh:mm").format(now);
      return todayDate;
    } catch (e) {
      return null;
    }

// return format;
  }

  convertDateFormat1(String date) {
    if (date != null) {
      try {
        String dateAfterFormat =
            DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
        String today = DateFormat("dd-MM-yyyy").format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
        String yesterday = DateFormat("dd-MM-yyyy").format(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));

        if (dateAfterFormat == yesterday) {
          return 'Yesterday';
        } else if (dateAfterFormat == today) {
          return 'Today';
        } else {
          return dateAfterFormat;
        }
      } catch (e) {
        return '';
      }
    } else {
      return '';
    }
  }

  /////////////////////////////////////// User Information screen ///////////////////////////

  void signOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("token");
    //
    // prefs.remove("domain");
    // prefs.remove("baseUrl");
    //
    prefs.remove("UserName");
    // prefs.remove("ClientName");
    // ClientName='';
    // dOMAiN = '';
    // TOKEN = '';
    UserName = '';
    TOKEN = '';
    // Name = '';
    //
    // dOMAiN = '';
    print('**********************************************');
    debugPrint(UserName.toString());
    debugPrint(ClientName.toString());
    debugPrint(TOKEN.toString());
    debugPrint(dOMAiN.toString());

    print('**********************************************');

    emit(UserInfoSignOutState());

    // await prefs.setString('domain', '');

    navigateAndFinish(
        context: context, widget: LoginWithEmailAndPasswordScreen());
  }

  void changeUrl(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("token");
    prefs.remove("domain");
    prefs.remove("UserName");
    prefs.remove("ClientName");
    prefs.remove("Name");
    prefs.remove("Email");
    prefs.remove("Phone");
    prefs.remove("OrganizationUnit");
    prefs.remove("DefaultFilter");
    prefs.remove("EnableNotifications");

    TOKEN = '';
    dOMAiN = '';
    UserName = '';
    ClientName = '';
    Name = '';
    Email = '';
    Phone = '';
    OrganizationUnit = '';
    DefaultFilter = '';

    print('**********************************************');
    debugPrint(UserName.toString());
    debugPrint(ClientName.toString());
    debugPrint(TOKEN.toString());
    debugPrint(dOMAiN.toString());

    print('**********************************************');

    emit(UserInfoChangeUrlState());

    navigateAndFinish(context: context, widget: LoginWithUrlScreen());
  }

  // void to dark and light theme

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
    emit(UserInfoChangeModeState());
  }

  AdminModel adminModel;

  void changeNotificationState() {
    EnableNotifications = !EnableNotifications;
    emit(UserInfoChangeNotificationState());
  }
}
