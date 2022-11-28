// @dart=2.9

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/modules/home_layout/home_screen/search_tickets_screen.dart';
import 'package:primitk_crm/shared/components/components.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/no_data/no_data.dart';
import 'package:primitk_crm/shared/widgets/ticket_item/ticket_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return Scaffold(
            drawer: Drawer(
                backgroundColor: Colors.blueGrey[50], child: drawer(context)),
            appBar: AppBar(
              title: Text(
                '${cubit.appBarTitle}(${cubit.caseItemsHome.length.toString()})',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: selectedColor),
              ),
              titleSpacing: 0.0,
              actions: [
                // IconButton(
                //     onPressed: () {
                //       cubit.getAllCases(context);
                //     },
                //     icon: Icon(
                //       FlutterIcons.refresh_ccw_fea,
                //       color: selectedColor,
                //     )),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Sort by:',
                                              style: TextStyle(
                                                  color: selectedColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      cubit.changeUpperSort();
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    child: const Icon(
                                                      Icons.arrow_downward,
                                                      color: Colors.white,
                                                      size: 17,
                                                    ),
                                                    backgroundColor:
                                                        cubit.LowerColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.03,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      cubit.changeLowerSort();
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    child: const Icon(
                                                      Icons.arrow_upward,
                                                      color: Colors.white,
                                                      size: 17,
                                                    ),
                                                    backgroundColor:
                                                        cubit.upperColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              25,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.sortByDate(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sort by date',
                                                style: TextStyle(
                                                    color: selectedColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(Icons.sort)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              33,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.sortByNum(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sort by case number',
                                                style: TextStyle(
                                                    color: selectedColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(Icons.sort)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              33,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            cubit.noSorting(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Without sorting',
                                                style: TextStyle(
                                                    color: selectedColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const Icon(Icons.sort)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                elevation: 24,
                                backgroundColor: Colors.blueGrey[50],
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(
                      FlutterIcons.sort_mco,
                      color: selectedColor,
                    )),
                IconButton(
                    onPressed: () {
                      navigateAndFinish(
                          context: context, widget: const SearchScreen());
                    },
                    icon: Icon(
                      FlutterIcons.search1_ant,
                      color: selectedColor,
                    )),
              ],
            ),
            body: NotificationListener<ScrollUpdateNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels ==
                          cubit.scrollHomeController.position.maxScrollExtent &&
                      state is! HomeAllCasesLoadingState) {
                    debugPrint('Down');
                    cubit.loadMoreCases(context);
                  }
                  //List scroll position

                  return true;
                },
                child: RefreshIndicator(
                  color: selectedColor,
                  onRefresh: () async =>
                      await cubit.getAllCases(context, 0, true),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, left: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 25,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              controller: cubit.scrollFiltersController,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'All',
                                        num: cubit.allCases ?? '0',
                                        color: Colors.grey,
                                        onTap: () {
                                          // HomeLayoutCubit.get(context)
                                          //     .getAllHomeCase(context);
                                        }),
                                  ),
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'Open',
                                        num: cubit.openCase.toString(),
                                        color: HexColor('#337AB7'),
                                        onTap: () {
                                          // cubit.getFilterCase(context, 'Open');
                                        }),
                                  ),
                                  // SizedBox(
                                  //   child: filterItemHome(
                                  //       context: context,
                                  //       txt: 'Closed',
                                  //       num: cubit.closedCase.toString(),
                                  //       color: Colors.blue,
                                  //       onTap: () {
                                  //         cubit.getFilterCase(context, 'closed');
                                  //       }),
                                  // ),
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'Escalated',
                                        num: cubit.escalatedCase
                                            .toString(),
                                        color: Colors.red.shade400,
                                        onTap: () {
                                          // cubit.getFilterCase(context, 'Escalated');
                                        }),
                                  ),
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'Waiting for customer ',
                                        num: cubit.waitingForCustomerCase
                                            .toString(),
                                        color: HexColor('#808080'),
                                        onTap: () {
                                          // cubit.getFilterCase(
                                          //     context, 'Waiting for customer ');
                                        }),
                                  ),
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'Need Budget ',
                                        num: cubit.needBudgetCase
                                            .toString(),
                                        color: HexColor('#6FBBD3'),
                                        onTap: () {
                                          // cubit.getFilterCase(
                                          //     context, 'Need Budget ');
                                        }),
                                  ),
                                  SizedBox(
                                    child: filterItemHome(
                                        context: context,
                                        txt: 'New',
                                        num: cubit.newCase.toString(),
                                        color: HexColor('#228B22'),
                                        onTap: () {
                                          // cubit.getFilterCase(context, 'New');
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (cubit.notData == true &&
                              cubit.caseItemsHome.isEmpty)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: NoData(context),
                                  ),
                                ],
                              ),
                            )
                          else
                            Expanded(
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                controller: cubit.scrollHomeController,
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            cubit.onClickCase(
                                                context: context,
                                                id: cubit.caseItemsHome[index]
                                                    .complaintId);
                                          },
                                          child: ticketItem(
                                              context: context,
                                              caseModel:
                                                  cubit.caseItemsHome[index]),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 0.0,
                                      ),
                                      itemCount: cubit.caseItemsHome.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              22,
                                    ),
                                    state is HomeGetMoreAllCasesLoadingState
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                )));
      },
    );
  }

  Widget filterType(
    String txt,
    Function onTap,
    Color color,
    String num,
    context,
  ) {
    return ListTile(
      title: Row(
        children: [
          Text(
            txt,
            style: TextStyle(
                color: selectedColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.height / 25,
          ),
          CircleAvatar(
            backgroundColor: color,
            radius: 15,
            child: Text(
              num.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget drawer(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 50,
            horizontal: MediaQuery.of(context).size.width / 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter By',
              style: TextStyle(
                  color: selectedColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic),
            ),
            Divider(
              thickness: 2.0,
              color: Colors.blueGrey[60],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      HomeLayoutCubit.get(context)
                          .getAllCases(context, 0, true);
                    },
                    child: Text(
                      'All Cases',
                      style: TextStyle(
                          color: selectedColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      HomeLayoutCubit.get(context)
                          .getAssignedToMeCases(context);
                    },
                    child: Text(
                      'My Assigned Cases',
                      style: TextStyle(
                          color: selectedColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.separated(
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             HomeLayoutCubit.get(context).onTapDrawerFilter(
            //                 HomeLayoutCubit.get(context)
            //                     .filterItem[index]
            //                     .name);
            //             // debugPrint('all');
            //           },
            //           child: filterItemDrawer(context: context, index: index),
            //         );
            //       },
            //       separatorBuilder: (context, index) => const SizedBox(
            //             height: 10,
            //           ),
            //       itemCount: HomeLayoutCubit.get(context).filterItem.length),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget filterItemDrawer({context, index}) {
  //   return Row(
  //     children: [
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: MediaQuery.of(context).size.width * 0.05,
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(
  //                 vertical: MediaQuery.of(context).size.height * 0.02),
  //             child: Text(
  //               HomeLayoutCubit.get(context).filterItem[index].name,
  //               style: TextStyle(
  //                   color: selectedColor,
  //                   fontSize: 17,
  //                   fontWeight: FontWeight.bold,
  //                   fontStyle: FontStyle.italic),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(
  //         width: MediaQuery.of(context).size.width / 70,
  //       )
  //     ],
  //   );
  // }

  Widget filterItemHome(
      {context, String txt, String num, Color color, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Card(
            elevation: 3,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 45,
                ),
                Text(
                  txt,
                  style: TextStyle(
                      color: selectedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    num.toString() ?? '',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 70,
          )
        ],
      ),
    );
  }
}
