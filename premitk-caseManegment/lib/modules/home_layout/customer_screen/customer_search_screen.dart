// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/shared/widgets/customer_widget/customer_widget.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';
import 'package:primitk_crm/shared/widgets/no_data/no_data.dart';
import 'package:primitk_crm/shared/widgets/text_form_field/text_form_field.dart';

class CustomerSearchScreen extends StatelessWidget {
  const CustomerSearchScreen({Key key}) : super(key: key);

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
            titleSpacing: 5.0,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  cubit.backToCustomerHome(context);
                }),
          ),
          body: NotificationListener<ScrollUpdateNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels ==
                  cubit.homeSearchCustomerScrollController.position
                      .maxScrollExtent) {
                debugPrint('Down');
                cubit.loadMoreSearchCases(context);
              }
              //List scroll position

              return true;
            },
            child: Column(
              children: [
                Container(
                  child: errorMsg(
                      "No Internet Connection Available", cubit.isOffline),
                  //to show internet connection message on isoffline = true.
                ),
                Expanded(
                  child: Form(
                    key: cubit.searchCustomerScreenFormKey,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            defaultTextFormField(
                                controller: cubit.txtCustomerSearchController,
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
                                      .searchCustomerScreenFormKey.currentState
                                      .validate()) {
                                    cubit.getCustomerBySearch(context);
                                  }
                                },
                                onchange: (value) {
                                  cubit.getAllSearchCustomerWhenNoDataInput(
                                      value);
                                },
                                onSubmit: (value) {
                                  if (cubit
                                      .searchCustomerScreenFormKey.currentState
                                      .validate()) {
                                    cubit.getCustomerBySearch(context);
                                  }
                                },
                                type: TextInputType.text),
                            const SizedBox(
                              height: 10,
                            ),
                            cubit.customerItemsSearch.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: NoData(context),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: SingleChildScrollView(
                                      controller: cubit
                                          .homeSearchCustomerScrollController,
                                      physics: const BouncingScrollPhysics(),
                                      child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              cubit.getCustomerDetails(
                                                  cubit
                                                      .customerItemsSearch[
                                                          index]
                                                      .iD,
                                                  context,
                                                  cubit
                                                      .customerItemsSearch[
                                                          index]
                                                      .customerType[0]);
                                            },
                                            child: CustomerListItem(
                                                cubit
                                                    .customerItemsSearch[index],
                                                context),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 0.0,
                                        ),
                                        itemCount:
                                            cubit.customerItemsSearch.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                                    ),
                                  ),

                            state is HomeGetMoreAllSearchCasesLoadingState
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
