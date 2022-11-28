// @dart=2.9


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';
import 'package:primitk_crm/shared/widgets/no_data/no_data.dart';
import 'package:primitk_crm/shared/widgets/text_form_field/text_form_field.dart';
import 'package:primitk_crm/shared/widgets/ticket_item/ticket_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return WillPopScope(
          onWillPop:  () async =>await cubit.backToHome(context),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Search for cases',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    cubit.backToHome(context);
                  }),
            ),
            body: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels ==
                    cubit.homeSearchScrollController.position.maxScrollExtent) {
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
                      key: cubit.searchCasesFormKey,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              defaultTextFormField(
                                  controller: cubit.txtSearchController,
                                  label: 'Search',
                                  suffix: FlutterIcons.search_faw,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Type to search ';
                                    }
                                    return null;
                                  },
                                  hidden: () {
                                    if (cubit.searchCasesFormKey.currentState
                                        .validate()) {
                                      cubit.getAllSearchCases(context);
                                    }
                                  },
                                  onchange: (value) {
                                    cubit.getAllSearchCasesWhenNoDataInput(
                                        value);
                                  },
                                  onSubmit: (value){
                                    if (cubit.searchCasesFormKey.currentState
                                        .validate()) {
                                      cubit.getAllSearchCases(context);
                                    }

                                  },
                                  type: TextInputType.text





                                  ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              cubit.caseItemsSearch.isEmpty &&
                                      cubit.notSearchData == true
                                  ? Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.of(context).size.width * 0.1),
                                    child: NoData(context),
                                  ),
                                ),
                              )
                                  : Expanded(
                                      child: SingleChildScrollView(
                                        controller:
                                            cubit.homeSearchScrollController,
                                        physics: const BouncingScrollPhysics(),
                                        child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                cubit.onClickCase(
                                                    context: context,
                                                    id: cubit
                                                        .caseItemsSearch[index]
                                                        .complaintId);
                                              },
                                              child: ticketItem(
                                                  context: context,
                                                  caseModel: cubit
                                                      .caseItemsSearch[index]),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 0.0,
                                          ),
                                          itemCount: cubit.caseItemsSearch.length,
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
          ),
        );
      },
    );
  }
}
