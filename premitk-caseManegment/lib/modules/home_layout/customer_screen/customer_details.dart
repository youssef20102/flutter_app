// @dart=2.9

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/models/customer_details_model.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';

class CustomerDetailScreen extends StatelessWidget {
  final String customerType;
  CustomerDetailData customerDetailData;

  CustomerDetailScreen({Key key, this.customerDetailData, this.customerType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: selectedColor,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Customer Detail',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: selectedColor),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            elevation: 5,
                            color: Colors.blueGrey[50],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: selectedColor,
                                    child: Center(
                                      child: Text(
                                        customerDetailData.name == '' ||
                                                customerDetailData
                                                    .name.isEmpty ||
                                                customerDetailData.name == null
                                            ? 'N'
                                            : customerDetailData.name[0]
                                                .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    maxRadius: 50,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                      child: Text(
                                        customerDetailData.name == '' ||
                                                customerDetailData
                                                    .name.isEmpty ||
                                                customerDetailData.name == null
                                            ? 'Not Found'
                                            : customerDetailData.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: selectedColor,
                                            radius: 20,
                                            child: IconButton(
                                              onPressed: () {
                                                cubit.customerDetailsAddCase(
                                                    context,
                                                    customerDetailData.email,
                                                    customerDetailData.name,
                                                    customerDetailData.phone,
                                                    customerDetailData.mobile,
                                                    customerDetailData.iD,
                                                    customerType);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: selectedColor,
                                            radius: 20,
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () {
                                                  cubit.getAllCasesHistory(
                                                      context,
                                                      customerDetailData.iD,
                                                      customerType);
                                                },
                                                icon: const Icon(
                                                  FlutterIcons.ticket_alt_faw5s,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          customerDetailData.mobile != null &&
                                                  customerDetailData.mobile !=
                                                      ''
                                              ? SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09,
                                                )
                                              : const SizedBox(),
                                          customerDetailData.mobile != null &&
                                                  customerDetailData.mobile !=
                                                      ''
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      selectedColor,
                                                  radius: 20,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      cubit.callNumber(
                                                          customerDetailData
                                                              .mobile);
                                                    },
                                                    icon: const Icon(
                                                      FlutterIcons
                                                          .phone_outline_mco,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),

                                      Divider(
                                        thickness: 1,
                                        color: Colors.blueGrey[100],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),

                                      // Email Address
                                      Text(
                                        'Email Address: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.email,
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Mobile
                                      Text(
                                        'Mobile: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.mobile ?? '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Phone Number
                                      Text(
                                        'Phone: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.phone.toString() ??
                                            '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Address
                                      Text(
                                        ' Address: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.address ?? '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Record Number
                                      Text(
                                        ' Record No: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.recordNO
                                                .toString() ??
                                            '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Id type
                                      Text(
                                        ' Id type: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.idType ?? '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),

                                      //Id number
                                      Text(
                                        ' Id number: ',
                                        style: TextStyle(
                                            color: selectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        customerDetailData.idNumber ?? '',
                                        style: TextStyle(
                                            color: unselectedColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: errorMsg("No Internet Connection Available",
                              cubit.isOffline),
                          //to show internet connection message on isoffline = true.
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
