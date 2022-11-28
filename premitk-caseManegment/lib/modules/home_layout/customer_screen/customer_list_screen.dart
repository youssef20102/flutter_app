// @dart=2.9

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/modules/home_layout/customer_screen/add_customer_screen.dart';
import 'package:primitk_crm/modules/home_layout/customer_screen/customer_search_screen.dart';
import 'package:primitk_crm/shared/components/components.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/customer_widget/customer_widget.dart';
import 'package:primitk_crm/shared/widgets/no_data/no_data.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "Customers",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: selectedColor),
            ),
            titleSpacing: 5.0,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context: context,
                            widget: const CustomerSearchScreen());
                      },
                      icon: const Icon(
                        FlutterIcons.search_faw,
                        color: Colors.blue,
                        size: 20,
                      )),
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context: context, widget: const AddContact());
                      },
                      icon: const Icon(
                        Icons.person_add_alt,
                        color: Colors.blue,
                        size: 25,
                      )),
                ],
              )
            ],
          ),
          body: NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                  cubit.customersScrollController.position.maxScrollExtent) {
                debugPrint('Down');
                cubit.getMoreCustomers();
              }
              //List scroll position

              return true;
            },
            child: cubit.customerItems.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: NoData(context),
                    ),
                  )
                : RefreshIndicator(
                    color: selectedColor,
                    onRefresh: () async => cubit.getCustomers(true),
                    child: SingleChildScrollView(
                      controller: cubit.customersScrollController,
                      physics: const BouncingScrollPhysics(),
                      child: SafeArea(
                          child: Column(
                        children: [
                          ListView.builder(
                            itemCount: cubit.customerItems.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 16),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  cubit.getCustomerDetails(
                                      cubit.customerItems[index].iD,
                                      context,
                                      cubit.customerItems[index]
                                          .customerType[0]);
                                },
                                child: CustomerListItem(
                                    cubit.customerItems[index], context),
                              );
                            },
                          ),
                          state is GetMoreCustomersLoadingState
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          )
                        ],
                      )),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
