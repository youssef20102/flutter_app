// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/shared/widgets/customer_widget/customer_widget.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';
import 'package:primitk_crm/shared/widgets/text_form_field/text_form_field.dart';

class SelectCustomerScreen extends StatelessWidget {
  const SelectCustomerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search for customers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);

                }),
          ),
          body: NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                  cubit.homeSearchCustomerInAddCaseScreenScrollController
                      .position.maxScrollExtent) {
                debugPrint('Down');
                cubit.loadMoreSearchCases(context);
              }
              //List scroll position

              return true;
            },
            child: Column(
              children: [
                Container(
                  child:  errorMsg(
                      "No Internet Connection Available", cubit.isOffline),
                  //to show internet connection message on isoffline = true.
                ),
                Expanded(
                  child: Form(
                    key: cubit.searchCustomerInAddCaseScreenFormKey,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                                controller: cubit
                                    .txtAddCustomerSearchInAddCaseScreenController,
                                label: 'Search',
                                suffix: FlutterIcons.search_faw,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Type to search ';
                                  }
                                  return null;
                                },
                                hidden: () {
                                  if (cubit
                                      .searchCustomerInAddCaseScreenFormKey
                                      .currentState
                                      .validate()) {
                                    cubit
                                        .getCustomerBySearchInAddCaseScreen(
                                            context);
                                  }
                                },
                                onchange: (value) {
                                  cubit
                                      .getAllSearchCustomerInAddCaseScreenWhenNoDataInput(
                                          value);
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            cubit.CustomerBySearchInAddCaseScreen.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                        ),
                                        const Center(
                                          child: Text(
                                            'No Data!!',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 40,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: SingleChildScrollView(
                                      controller: cubit
                                          .homeSearchCustomerInAddCaseScreenScrollController,
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              cubit.selectCustomer(
                                                  cubit
                                                      .CustomerBySearchInAddCaseScreen[
                                                          index]
                                                      .name,
                                                  cubit
                                                      .CustomerBySearchInAddCaseScreen[
                                                          index]
                                                      .phone,
                                                  cubit
                                                      .CustomerBySearchInAddCaseScreen[
                                                          index]
                                                      .email,
                                                  cubit
                                                      .CustomerBySearchInAddCaseScreen[
                                                          index]
                                                      .customerType,
                                                  cubit
                                                      .CustomerBySearchInAddCaseScreen[
                                                          index]
                                                      .iD);
                                              Navigator.pop(context);
                                            },
                                            child: CustomerListItem(
                                                cubit.CustomerBySearchInAddCaseScreen[
                                                    index],
                                                context),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 0.0,
                                        ),
                                        itemCount: cubit
                                            .CustomerBySearchInAddCaseScreen
                                            .length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                                    ),
                                  ),

                            state is GetCustomersBySearchAddCassScreenLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const SizedBox(),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height / 15,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
