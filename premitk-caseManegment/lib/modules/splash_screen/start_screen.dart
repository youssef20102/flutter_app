// @dart=2.9

// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';

import 'package:primitk_crm/bloc/login_bloc/login_bloc.dart';
import 'package:primitk_crm/bloc/login_bloc/login_state.dart';
import 'package:primitk_crm/modules/auth/login_with_url.dart';

class StartSplashScreen extends StatelessWidget {
  const StartSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OnbordingData> list = [
      OnbordingData(

        imagePath: "images/caseManagement.png",
        title: "Case management",
        desc:
            "Access Wowdesk from your smart mobile devices, submit new cases, and track cases.",
      ),
      OnbordingData(
        imagePath: "images/chat.png",
        title: "Add Public and private notes",
        desc:
            "Add Public and private notes to cases, To track your case and to communicate with the customer support",
      ),
      OnbordingData(
        imagePath: "images/customerManagment.png",
        title: "Manage your customers",
        desc:
            "You can search for a customer in more than one way (such as name, mobile number, ID number, etc..), you can add or modify a customer, contact him directly, and you can retrieve old cases for the customer or create a new case for him.",
      ),
    ];

    // LoginWithUrlScreen

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return IntroScreen(

          list,

          MaterialPageRoute(builder: (context) => const LoginWithUrlScreen()),
        );
      },
    );
  }
}
