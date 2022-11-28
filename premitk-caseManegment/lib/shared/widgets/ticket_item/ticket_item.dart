// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/models/all_cases_model.dart';
import 'package:primitk_crm/shared/images/all_images.dart';

import 'package:primitk_crm/shared/style/color.dart';

// Ticket item widget to show in home and search screen

Widget ticketItem({context, CaseModel caseModel}) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Card(
        color: Colors.white,
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                      color: HomeLayoutCubit.get(context)
                          .changePriorityColor(caseModel.priority),
                      borderRadius: BorderRadius.circular(10)),
                  width: 3,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: selectedColor,
                              backgroundImage: const AssetImage(UserInfoScreen),

                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(
                              caseModel.caseSource!= null?

                              HomeLayoutCubit.get(context).changeSourceIcon(
                                      HomeLayoutCubit.get(context)
                                          .SourcesItems
                                          .firstWhere((element) =>
                                              element.id ==
                                              caseModel.caseSource)
                                          .name) :
                                  FlutterIcons.institution_faw,
                              size: 18,
                              color: unselectedColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  caseModel.customerName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(

                                      color: unselectedColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '#${caseModel.caseNumber.toString()}',
                              style: TextStyle(
                                  color: unselectedColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                caseModel.subject.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              caseModel.submitDate.toString(),
                              // HomeLayoutCubit.get(context).convertFullDateformate2(caseModel.submitDate),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: unselectedColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Icon(FlutterIcons.flag_mco,color: HomeLayoutCubit.get(context).changeStateColor(caseModel.data.status),)
                            Icon(FlutterIcons.flag_mco,
                                color: caseModel.slaColor != null
                                    ? HexColor(caseModel.slaColor)
                                    : Colors.grey),
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                color: Colors.grey[100],
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              HomeLayoutCubit.get(context)
                                                  .changePriorityColor(
                                                      caseModel.priority)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        caseModel.priority != null ||
                                                caseModel.priority ==
                                                    "- - - Select - - -"
                                            ? caseModel.priority.toString()
                                            : 'Normal',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: selectedColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 25,
                              ),
                              if (
                                  caseModel.userIds.isNotEmpty && HomeLayoutCubit.get(context).userItems.any((element) => element.id==caseModel.userIds[0] ||
                                      caseModel.userGroupIds.isNotEmpty && HomeLayoutCubit.get(context).groupItems.any((element) => element.id==caseModel.userGroupIds[0] ||
                                  caseModel.ouIds.isNotEmpty&& HomeLayoutCubit.get(context).OUItems.any((element) => element.id==caseModel.ouIds[0]
                                  ))))
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Card(
                                    color: Colors.grey[100],
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.group,
                                            size: 15,
                                            color: selectedColor,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                100,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *0.2,
                                            height: 20,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  HomeLayoutCubit.get(context)
                                                      .displayMultiSelect(
                                                          context,
                                                          index,
                                                          caseModel),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Text('/'),
                                              itemCount: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (
                              caseModel.userIds.isNotEmpty && HomeLayoutCubit.get(context).userItems.any((element) => element.id==caseModel.userIds[0] ||
                                  caseModel.userGroupIds.isNotEmpty && HomeLayoutCubit.get(context).groupItems.any((element) => element.id==caseModel.userGroupIds[0] ||
                                      caseModel.ouIds.isNotEmpty&& HomeLayoutCubit.get(context).OUItems.any((element) => element.id==caseModel.ouIds[0]
                                      )))
                              )
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 25,
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Card(
                                  color: Colors.grey[100],
                                  // color: HomeLayoutCubit.get(context).changeStateColor(caseModel.complaintStatus),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          child: Text(
                                            caseModel.complaintStatus,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 13,
                                                overflow: TextOverflow.ellipsis,
                                                color: HomeLayoutCubit.get(context).changeStateColor(caseModel.complaintStatus),
                                                // color: whiteColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
