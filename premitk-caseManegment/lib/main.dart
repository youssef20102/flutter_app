// @dart=2.9
// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/login_bloc/login_bloc.dart';
import 'package:primitk_crm/modules/auth/login_with_email&password.dart';

import 'package:primitk_crm/modules/splash_screen/splash_screen.dart';
import 'package:primitk_crm/modules/splash_screen/start_screen.dart';

import 'package:primitk_crm/shared/bloc_observer/bloc_observer.dart';
import 'package:primitk_crm/shared/network/remote/dio_helper.dart';

import 'package:primitk_crm/shared/network/remote/end_points.dart';
import 'package:primitk_crm/shared/style/theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'shared/constants/constatnt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  UserName = prefs.getString('UserName');

  TOKEN = prefs.getString('token');
  dOMAiN = prefs.getString('domain');

  ClientName = prefs.getString('ClientName');
  Email = prefs.getString('Email');
  Phone = prefs.getString('Phone');
  OrganizationUnit = prefs.getString('OrganizationUnit');
  DefaultFilter = prefs.getString('DefaultFilter');
  EnableNotifications = prefs.getBool('EnableNotifications');

  debugPrint('baseUrl ============');
  debugPrint(BASE_URL.toString());
  debugPrint('baseUrl ============');

  debugPrint('dOMAiN ============');
  debugPrint(dOMAiN.toString());
  debugPrint('dOMAiN ============');

  debugPrint('ClintName ============');
  debugPrint(ClientName.toString());
  debugPrint('ClintName ============');

  Widget startWidget;

  if (UserName != null &&
      UserName != '' &&
      ClientName != null &&
      ClientName != '' &&
      dOMAiN != null &&
      dOMAiN != '') {
    startWidget = const LoadingSplashScreen();
  } else if (ClientName != null &&
          ClientName != '' &&
          dOMAiN != null &&
          dOMAiN != '' &&
          UserName == null &&
          TOKEN == null ||
      ClientName != null &&
          ClientName != '' &&
          dOMAiN != null &&
          dOMAiN != '' &&
          UserName == '' &&
          TOKEN == '') {
    startWidget = const LoginWithEmailAndPasswordScreen();
  } else {
    startWidget = const StartSplashScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(startWidget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                HomeLayoutCubit()..cheekNetWork(context)),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: LightTheme.lightTheme,
        home: startWidget,
        builder: EasyLoading.init(),
      ),
    );
  }
}
