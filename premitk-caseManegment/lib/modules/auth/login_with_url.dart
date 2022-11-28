// @dart=2.9
// ignore_for_file: missing_return

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primitk_crm/bloc/login_bloc/login_bloc.dart';

import 'package:primitk_crm/bloc/login_bloc/login_state.dart';
import 'package:primitk_crm/shared/images/all_images.dart';

class LoginWithUrlScreen extends StatefulWidget {
  const LoginWithUrlScreen({Key key}) : super(key: key);

  @override
  _LoginWithUrlScreenState createState() => _LoginWithUrlScreenState();
}

class _LoginWithUrlScreenState extends State<LoginWithUrlScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    // LoginCubit.get(context).urlTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LoginCubit.get(context);

        return Scaffold(
            body: Stack(
          children: [
            Image.asset(
              loginImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: FractionalOffset(animation.value, 0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  // Login text
                  const Text(
                    'Help desk domain url',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  // TextFormField to input the url
                  Form(
                    key: cubit.loginWithUrlFormKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a valid Url';
                        }
                        return null;
                      },
                      controller: cubit.urlTextController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Help desk url',
                        hintStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink.shade700),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // Login Button

                  MaterialButton(
                    onPressed: () {
                      if (cubit.loginWithUrlFormKey.currentState.validate()) {
                        return cubit.submitFormOnLoginWithUrl(context);
                      }
                    },
                    color: Colors.pink.shade700,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide.none),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.login,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}
