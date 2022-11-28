// @dart=2.9
// ignore_for_file: invalid_use_of_protected_member, prefer_const_constructors

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/login_bloc/login_state.dart';
import 'package:primitk_crm/models/admin_model.dart';
import 'package:primitk_crm/modules/auth/login_with_email&password.dart';

import 'package:primitk_crm/shared/components/components.dart';
import 'package:primitk_crm/shared/constants/constatnt.dart';
import 'package:primitk_crm/shared/network/remote/dio_helper.dart';
import 'package:primitk_crm/shared/network/remote/end_points.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Definitions

  // TextEditingController

  final TextEditingController urlTextController =
      TextEditingController(text: '');

  final TextEditingController emailTextController =
      TextEditingController(text: '');
  final TextEditingController passwordTextController =
      TextEditingController(text: '');

  //cheek connection

  StreamSubscription loginInternetConnection;
  bool loginIsOffline;

  Future cheekNetWork(context) async {
    loginInternetConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection

        loginIsOffline = true;
        emit(LoginInitialCheckConnectionNoInternetState());
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network

        loginIsOffline = false;
        emit(LoginInitialCheckConnectionNoInternetMobileDataState());
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi

        loginIsOffline = false;
        emit(LoginInitialCheckConnectionNoInternetWifiState());
      }
    }); // using this listiner, you can get the medium of connection as well.
  }

// FormKeys
  final loginWithUrlFormKey = GlobalKey<FormState>();
  final loginWithEmailAndPasswordFormKey = GlobalKey<FormState>();

  // login with url and go to login with email and password screen

  Future<void> submitFormOnLoginWithUrl(context) async {
    emit(LoginWithUrlLoadingState());
    debugPrint('1');
    if (urlTextController.text.contains('.') &&
        urlTextController.text.contains('.com') &&
        !urlTextController.text.contains('.qa.') &&
        !urlTextController.text.contains('http') &&
        !urlTextController.text.contains('https') &&
        !urlTextController.text.contains('www.')) {
      debugPrint('2');
      debugPrint(TOKEN.toString());

      // 1 - Get Url
      // 2 -  Split  This Url To Get client Name And Domain
      // 3 - navigateAndFinish To Login With Email And Password

      // 1
      String url = urlTextController.text.trim();

      //2
      ClientName = url.split('.')[0];
      dOMAiN = url.split('.')[1];

      // await prefs.setString('ClientName', url.split('.')[0]);
      // await prefs.setString('domain', url.split('.')[1].toString());

      debugPrint('--------------------------------------------------');
      debugPrint(ClientName);
      debugPrint(dOMAiN);
      debugPrint(BASE_URL.toString());
      debugPrint('--------------------------------------------------');

      //3
      navigateTo(
          context: context, widget: const LoginWithEmailAndPasswordScreen());

      emit(LoginWithUrlSuccessState());
    } else {
      debugPrint('3');

      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 6.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.pink,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error',
                      style: TextStyle(
                          color: selectedColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text('Please enter a valid url !!!',
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

  // login with email and password by api

  AdminModel adminModel;

  void loginWithEmailAndPassword(context) async {
    debugPrint('4');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    cheekNetWork(context).then((value) async {
      TOKEN = '';
      if (ClientName == null && dOMAiN == null ||
          ClientName == '' && dOMAiN == '') {
        dOMAiN = prefs.getString('domain');
        ClientName = prefs.getString('ClientName');
      }
      debugPrint(BASE_URL.toString());
      BASE_URL = 'http://$dOMAiN.qa.$dOMAiN.com/api/';
      DioHelper.init();

      debugPrint('++++++++++++++++++++++++++++++++++++++');
      debugPrint(BASE_URL.toString());
      debugPrint('++++++++++++++++++++++++++++++++++++++');
      debugPrint(ClientName);

      var data = {
        'userName': emailTextController.text.trim().toString(),
        'password': passwordTextController.text.trim().toString(),
        'clientName': ClientName,
        'deviceId': '',
        'ForceLogout': true,
        'languageId': 2
      };

      emit(LoginWithEmailAndPasswordLoadingState());

      await DioHelper.postData(
        url: SignIn,
        data: data,
      ).then((value) async {
        debugPrint(value.data.toString());

        adminModel = AdminModel.fromJson(value.data);

        if (adminModel.errorCode.toString() == '0') {
          debugPrint(
              '1111111111111111111111111111111111111111111111111111111111111111111');

          await prefs.setString('token', adminModel.data.apitoken.toString());
          await prefs.setString(
              'ClientName', adminModel.data.clientName.toString());
          await prefs.setString('domain', dOMAiN);

          await prefs.setString(
              'UserName', adminModel.data.userName.toString());
          await prefs.setString('Name', adminModel.data.name.toString());
          await prefs.setString('Email', adminModel.data.email.toString());
          await prefs.setString('Phone', adminModel.data.phone.toString());
          await prefs.setString(
              'OrganizationUnit', adminModel.data.organizationUnit.toString());
          await prefs.setString(
              'DefaultFilter', adminModel.data.defaultFilter.toString());
          await prefs.setBool(
              'EnableNotifications', adminModel.data.enableNotifications);
          UserName = adminModel.data.userName.toString();

          Name = adminModel.data.name;
          Email = adminModel.data.email;
          Phone = adminModel.data.phone;
          OrganizationUnit = adminModel.data.organizationUnit;
          DefaultFilter = adminModel.data.defaultFilter;
          EnableNotifications = adminModel.data.enableNotifications;
          debugPrint('12');
          TOKEN = adminModel.data.apitoken.toString();

          emailTextController.text = '';
          passwordTextController.text = '';
          HomeLayoutCubit.get(context).adminModel = adminModel;
          await HomeLayoutCubit.get(context).getAdminData();
          await HomeLayoutCubit.get(context).getAllCases(context, 0, false);
          await HomeLayoutCubit.get(context).getSubCategory('', false);
          await HomeLayoutCubit.get(context).getType(false);
          await HomeLayoutCubit.get(context).getUsers(false);
          await HomeLayoutCubit.get(context).getOus(false);
          await HomeLayoutCubit.get(context).getGroups(false);
          await HomeLayoutCubit.get(context).getSources(false);
          // await HomeLayoutCubit.get(context).getFilters();
          await HomeLayoutCubit.get(context).getStatus(false);
          await HomeLayoutCubit.get(context).getProductGroup(false);
          await HomeLayoutCubit.get(context).getProduct('', false);
          await HomeLayoutCubit.get(context).getCategory(false);
          await HomeLayoutCubit.get(context).getPriorities(false);
          await HomeLayoutCubit.get(context).getCustomers(false);
          await HomeLayoutCubit.get(context).getIdType(false);

          emit(LoginWithEmailAndPasswordSuccessState());
        } else if (adminModel.errorCode.toString() == '1') {
          // dOMAiN = prefs.getString('domain');
          // ClientName = prefs.getString('ClientName');

          UserName = '';
          debugPrint('8');
          debugPrint('kkkkkkkkkkkkkkkkkkk');
          debugPrint(ClientName.toString());
          debugPrint(dOMAiN.toString());
          debugPrint('kkkkkkkkkkkkkkkkkkk');

          showToast(
              text: adminModel.errorDescription.toString(),
              state: ToastState.ERROR);
          emit(LoginWithEmailAndPasswordErrorState());
        } else if (adminModel.errorCode.toString() == '31') {
          debugPrint('zazzazazazazaa');
          prefs.remove("token");

          prefs.remove("domain");
          prefs.remove("baseUrl");
          prefs.remove("baseUrl");
          prefs.remove("UserName");
          prefs.remove("ClientName");
          ClientName = '';
          dOMAiN = '';
          TOKEN = '';
          UserName = '';
          Name = '';
          showToast(text: adminModel.errorDescription, state: ToastState.ERROR);
          Navigator.pop(context);

          emit(ClintNameErrorState());
        } else {
          debugPrint('9');

          emailTextController.clear();
          passwordTextController.clear();
          debugPrint(adminModel.errorCode.toString());
          showToast(text: adminModel.errorDescription, state: ToastState.ERROR);

          debugPrint(adminModel.errorDescription.toString());
          emit(LoginWithEmailAndPasswordErrorState());
        }
      }).catchError((e) {
        debugPrint(e.toString());
        showToast(
            text: 'Domain name or something wrong', state: ToastState.ERROR);

        emit(LoginWithEmailAndPasswordErrorState());
      });
    }).catchError((error) async {
      cheekNetWork(context).then((value) {
        debugPrint('10');

        if (loginIsOffline == true ||
            adminModel.errorCode == 1 && loginIsOffline == true) {
          loginInternetConnection.cancel();
          prefs.remove("UserName");
          UserName = '';
          Name = '';
          showToast(
              text: 'No Internet Connection Available',
              state: ToastState.ERROR);
        } else {
          prefs.remove("token");

          prefs.remove("domain");

          prefs.remove("baseUrl");
          prefs.remove("UserName");

          prefs.remove("ClientName");
          ClientName = '';
          dOMAiN = '';
          TOKEN = '';
          UserName = '';
          Name = '';

          Navigator.pop(context);

          showToast(
              text: 'Domain name or something wrong', state: ToastState.ERROR);
        }

        //debugPrint(adminModel.errorDescription.toString());

        debugPrint(BASE_URL.toString());
        debugPrint(error.toString());

        emit(LoginWithEmailAndPasswordErrorState());
      });
    });
  }

  bool isPassword = true;
  IconData notHiddenIco = Icons.remove_red_eye_outlined;
  IconData hiddenIco = Icons.remove_red_eye;

  void hiddenPassword() {
    isPassword = !isPassword;
    emit(LoginWithEmailAndPasswordHiddenPassState());
  }
}
