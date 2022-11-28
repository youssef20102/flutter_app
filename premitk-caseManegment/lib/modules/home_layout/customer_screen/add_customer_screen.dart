// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';
import 'package:primitk_crm/shared/style/color.dart';
import 'package:primitk_crm/shared/widgets/network_error/network_error_message.dart';
import 'package:primitk_crm/shared/widgets/text_form_field/text_form_field.dart';

class AddContact extends StatelessWidget {
  const AddContact({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Register Personal Customer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          body: Form(
            key: cubit.addCustomerFormKey,
            child: Column(
              children: [
                Container(
                  child: errorMsg(
                      "No Internet Connection Available", cubit.isOffline),
                  //to show internet connection message on isoffline = true.
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // name
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Customer Name:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: defaultTextFormField(
                                  controller:
                                      cubit.txtContactFullNameController,
                                  prefix: Icons.person,
                                  label: 'Name:',
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Fill this box ';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              // email Address
                              const SizedBox(height: 10),
                              Text(
                                'Email Address:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                  type: TextInputType.emailAddress,
                                  controller: cubit.txtContactEmailController,
                                  prefix: FlutterIcons.email_mco,
                                  label: 'Email Address',
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Fill this box ';
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              // // user name
                              // const SizedBox(height: 10),
                              // Text(
                              //   'UserName',
                              //   style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              //       color: selectedColor),
                              // ),
                              // const SizedBox(height: 10),
                              // Container(
                              //   child: defaultTextFormField(
                              //     type: TextInputType.emailAddress,
                              //     controller: cubit.txtContactUserNameController,
                              //     prefix: Icons.person,
                              //     label: 'UserName',
                              //   ),
                              // ),
                              //
                              // // password
                              // const SizedBox(height: 10),
                              // Text(
                              //   'Password',
                              //   style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.w500,
                              //       color: selectedColor),
                              // ),
                              // const SizedBox(height: 10),
                              // Container(
                              //   child: defaultTextFormField(
                              //     type: TextInputType.emailAddress,
                              //     controller: cubit.txtContactPasswordController,
                              //     prefix: Icons.lock,
                              //     label: 'Password',
                              //   ),
                              // ),

                              // Mobile Phone
                              const SizedBox(height: 10),
                              Text(
                                'Mobile:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                  type: TextInputType.phone,
                                  controller:
                                      cubit.txtContactMobilePhoneController,
                                  prefix: FlutterIcons.phone_faw,
                                  label: 'Mobile Phone',
                                ),
                              ),

                              // Phone
                              const SizedBox(height: 10),
                              Text(
                                'Phone:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                  type: TextInputType.phone,
                                  controller: cubit.txtContactPhoneController,
                                  prefix: FlutterIcons.phone_faw,
                                  label: 'Phone',
                                ),
                              ),

                              // Address
                              const SizedBox(height: 10),
                              Text(
                                'Address:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                  controller: cubit.txtContactAddressController,
                                  prefix: FlutterIcons.home_account_mco,
                                  label: ' Address',
                                ),
                              ),

                              //Record No
                              const SizedBox(height: 10),
                              Text(
                                'Record No:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                    prefix: FlutterIcons.folder_account_mco,
                                    controller:
                                        cubit.txtContactRecordNoController,
                                    label: 'Record number'),
                              ),
                              const SizedBox(height: 30),

                              // IDType

                              const SizedBox(height: 10),
                              Text(
                                'Id type:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownButton<String>(
                                  value: cubit.IdType,
                                  elevation: 16,
                                  style: TextStyle(color: selectedColor),
                                  items: cubit.IdTypesItemsString.map(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    cubit.changeIdTypeValue(newValue);
                                  },
                                ),
                              ),

                              //ID No
                              const SizedBox(height: 10),
                              Text(
                                'Id number:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                child: defaultTextFormField(
                                    controller: cubit.txtContactIDNoController,
                                    prefix: FlutterIcons.folder_account_mco,
                                    label: 'Id number'),
                              ),
                              const SizedBox(height: 30),

                              // button
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: double.infinity,
                                child: MaterialButton(
                                  color: selectedColor,
                                  onPressed: () {
                                    if (cubit.addCustomerFormKey.currentState
                                        .validate()) {
                                      cubit.addCustomer(context);
                                    } else {
                                      return null;
                                    }
                                  },
                                  child: const Text(
                                    'Add Customer',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
