// @dart=2.9
// ignore_for_file: missing_return, file_names

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primitk_crm/bloc/login_bloc/login_bloc.dart';

import 'package:primitk_crm/bloc/login_bloc/login_state.dart';

import 'package:primitk_crm/modules/splash_screen/splash_screen.dart';
import 'package:primitk_crm/shared/components/components.dart';
import 'package:primitk_crm/shared/images/all_images.dart';
import 'package:primitk_crm/shared/style/color.dart';

class LoginWithEmailAndPasswordScreen extends StatefulWidget {
  const LoginWithEmailAndPasswordScreen({Key key}) : super(key: key);

  @override
  _LoginWithEmailAndPasswordScreenState createState() =>
      _LoginWithEmailAndPasswordScreenState();
}

class _LoginWithEmailAndPasswordScreenState
    extends State<LoginWithEmailAndPasswordScreen>
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
      listener: (context, state) {
        if (state is LoginWithEmailAndPasswordSuccessState) {
          navigateAndFinish(context: context, widget: const LoadingSplashScreen());

          showToast(text: 'Success', state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              backgroundColor: blackColor,
              iconTheme: IconThemeData(color: whiteColor),
            ),
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
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: size.height * 0.3,
                      ),
                      // Login text
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      // EmailAddress and Password
                      Form(
                        key: cubit.loginWithEmailAndPasswordFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid User name';
                                }
                                return null;
                              },
                              controller: cubit.emailTextController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'username',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pink.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid Password';
                                }
                                return null;
                              },
                              controller: cubit.passwordTextController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: cubit.isPassword,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(cubit.isPassword==true?cubit.hiddenIco:cubit.notHiddenIco,color: Colors.white,),
                                  onPressed: (){cubit.hiddenPassword();},
                                ),
                                hintText: 'password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.pink.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      // Login Button
                      if (state is LoginWithEmailAndPasswordLoadingState)
                        Center(
                            child: CircularProgressIndicator(
                          color: Colors.pink.shade700,
                        ))
                      else
                        MaterialButton(
                          onPressed: () {
                            if (cubit
                                .loginWithEmailAndPasswordFormKey.currentState
                                .validate()) {
                              cubit.loginWithEmailAndPassword(context);
                              //    cubit.loginWithEmailAndPassword(context);

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
