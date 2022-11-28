// @dart=2.9

// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';

import 'package:primitk_crm/modules/home_layout/home_layout_screen/home_layout_screen.dart';
import 'package:primitk_crm/shared/components/components.dart';

import 'package:primitk_crm/shared/images/all_images.dart';
import 'package:primitk_crm/shared/style/color.dart';

class LoadingSplashScreen extends StatelessWidget {
  const LoadingSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {
        if (state is GetCustomersSuccessState) {
          Timer(const Duration(seconds: 3), () {
            navigateAndFinish(context: context, widget: const HomeLayout());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white70,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.2),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.07),
                      child: Image.asset(
                        splashScreenImg2,
                        fit: BoxFit.fill,
                      ),
                    ),

                    Text(
                      'Loading...',
                      style: TextStyle(
                          color: selectedColor,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: selectedColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// SplashScreen(
// seconds:startScreen.toString()== 'LoginWithUrlScreen' ?3: 15,
// navigateAfterSeconds: startScreen,
// title:startScreen.toString()== 'LoginWithUrlScreen'?   Text('Welcome In CRM_System',style: TextStyle(color: selectedColor,fontSize: 30,fontWeight: FontWeight.bold),):Text('Loading...',style: TextStyle(color: selectedColor,fontSize: 30,fontWeight: FontWeight.bold),),
// image: Image.asset(splashScreenImg),
// backgroundColor: Colors.white,
// styleTextUnderTheLoader: const TextStyle(),
// photoSize: 200.0,
// loaderColor: selectedColor)
