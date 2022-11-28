// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';
import 'package:primitk_crm/shared/widgets/no_data/no_data.dart';
import 'package:primitk_crm/shared/widgets/ticket_item/ticket_item.dart';




class CustomerCasesScreen extends StatelessWidget {
  const CustomerCasesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              title: Text(
                'Customer Cases',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: selectedColor),
              ),
              titleSpacing: 0.0,
              // actions: [
              //   // IconButton(
              //   //     onPressed: () {
              //   //       navigateTo(context: context, widget: const SearchScreen());
              //   //     },
              //   //     icon: Icon(
              //   //       FlutterIcons.sort_mco,
              //   //       color: selectedColor,
              //   //     )),
              //   IconButton(
              //       onPressed: () {
              //         navigateTo(context: context, widget: const SearchScreen());
              //       },
              //       icon: Icon(
              //         FlutterIcons.search1_ant,
              //         color: selectedColor,
              //       )),
              //
              // ],
            ),
            body: cubit.caseHistoryItems.isNotEmpty
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child:  errorMsg("No Internet Connection Available", cubit.isOffline),
                              //to show internet connection message on isoffline = true.
                            ),
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    cubit.onClickCase(
                                      context: context,
                                        id: cubit.caseHistoryItems[index].complaintId,

                                    );
                                  },
                                  child: ticketItem(
                                    context: context,
                                   caseModel: cubit.caseHistoryItems[index]
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 0.0,
                              ),
                              itemCount: cubit.caseHistoryItems.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                :     Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                      child:NoData(context)
                    ),
                )
        );
      },
    );
  }
//
//   Widget filterType(
//     String txt,
//     Function onTap,
//     Color color,
//     String num,
//     context,
//   ) {
//     return ListTile(
//       title: Row(
//         children: [
//           Text(
//             txt,
//             style: TextStyle(
//                 color: selectedColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.height / 25,
//           ),
//           CircleAvatar(
//             backgroundColor: color,
//             radius: 15,
//             child: Text(
//               num.toString(),
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.w500),
//             ),
//           )
//         ],
//       ),
//       onTap: onTap,
//     );
//   }
//
//   Widget drawer(context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height / 50,
//             horizontal: MediaQuery.of(context).size.width / 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Filter By',
//               style: TextStyle(
//                   color: selectedColor,
//                   fontSize: 40,
//                   fontWeight: FontWeight.w700,
//                   fontStyle: FontStyle.italic),
//             ),
//             Divider(
//               thickness: 2.0,
//               color: Colors.blueGrey[60],
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 40,
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   // all
//                   Container(
//                     child: filterType('All', () {
//                       HomeLayoutCubit.get(context).getAllHomeCase(context);
//                     }, Colors.grey,
//                         HomeLayoutCubit().caseItems.length.toString(), context),
//                   ),
//
// // open
//                   Container(
//                     child: filterType('Open', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'Open');
//                     },
//                         indigoColor,
//                         HomeLayoutCubit.get(context).openCase.length.toString(),
//                         context),
//                   ),
//
//                   // closed
//                   Container(
//                     child: filterType('Closed', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'closed');
//                     },
//                         Colors.blue,
//                         HomeLayoutCubit.get(context)
//                             .closedCase
//                             .length
//                             .toString(),
//                         context),
//                   ),
//                   //Escalated
//                   Container(
//                     child: filterType('Escalated', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'Escalated');
//                     },
//                         Colors.red,
//                         HomeLayoutCubit.get(context)
//                             .escalatedCase
//                             .length
//                             .toString(),
//                         context),
//                   ),
//
//                   //Waiting for customer
//                   Container(
//                     child: filterType('Waiting for customer ', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'Waiting for customer ');
//                     },
//                         Colors.grey,
//                         HomeLayoutCubit.get(context)
//                             .waitingForCustomerCase
//                             .length
//                             .toString(),
//                         context),
//                   ),
//                   //Need Budget
//                   Container(
//                     child: filterType('Need Budget ', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'Need Budget ');
//                     },
//                         Colors.teal,
//                         HomeLayoutCubit.get(context)
//                             .needBudgetCase
//                             .length
//                             .toString(),
//                         context),
//                   ),
//
//                   //New
//                   Container(
//                     child: filterType('New', () {
//                       HomeLayoutCubit.get(context)
//                           .getFilterCase(context, 'New');
//                     },
//                         Colors.green,
//                         HomeLayoutCubit.get(context)
//                             .needBudgetCase
//                             .length
//                             .toString(),
//                         context),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget filterItem(
//       {context, String txt, int num, Color color, Function onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Card(
//             elevation: 3,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 45,
//                 ),
//                 Text(
//                   txt,
//                   style: TextStyle(
//                       color: selectedColor,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       fontStyle: FontStyle.italic),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 20,
//                 ),
//                 CircleAvatar(
//                   backgroundColor: color,
//                   radius: 10,
//                   child: Text(
//                     num.toString(),
//                     style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width / 70,
//           )
//         ],
//       ),
//     );
//   }
}
