// @dart=2.9



// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';



class Notification_Screen extends StatelessWidget {
  const Notification_Screen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
       // var cubit = HomeLayoutCubit.get(context);
        return   Scaffold(
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coming Soon ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 40,color: Colors.grey[400]),),
              Icon(  Icons.notification_important_outlined,size: 180,color: Colors.grey[400],)
            ],
          ),),
        );
      },
    );
  }
}
