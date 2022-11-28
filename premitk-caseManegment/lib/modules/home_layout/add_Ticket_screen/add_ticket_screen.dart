// @dart=2.9

// ignore_for_file: missing_return, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:flutter_switch/flutter_switch.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_cubit.dart';
import 'package:primitk_crm/bloc/home_layout/home_layout_state.dart';

import 'package:primitk_crm/models/group_model.dart';
import 'package:primitk_crm/models/ou_model.dart';
import 'package:primitk_crm/models/user_model.dart';
import 'package:primitk_crm/modules/home_layout/add_Ticket_screen/select_customer_screen.dart';

import 'package:primitk_crm/shared/components/components.dart';

import 'package:primitk_crm/shared/style/color.dart';

import 'package:primitk_crm/shared/widgets/note_item/not_item.dart';
import 'package:primitk_crm/shared/widgets/text_form_field/text_form_field.dart';

class AddCase extends StatelessWidget {
  const AddCase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
      listener: (context, state) {
        if (state is HomeOnClickOnCasesLoadingState) {
          EasyLoading.show(status: 'loading...');
        }
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        var cubit = HomeLayoutCubit.get(context);

        final groups = cubit.groupItems
            .map((element) => MultiSelectItem<GroupData>(element, element.name))
            .toList();
        final OUs = cubit.OUItems.map(
                (element) => MultiSelectItem<OuData>(element, element.name))
            .toList();
        final users = cubit.userItems
            .map((element) => MultiSelectItem<UserData>(element, element.name))
            .toList();

        return WillPopScope(
          onWillPop: () => cubit.clean(context),
          child: Scaffold(
            appBar: AppBar(
              leading: cubit.isCaseDetail
                  ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: selectedColor,
                      ),
                      onPressed: () {
                        cubit.clean(context);
                      },
                    )
                  : null,
              title: Text(
                cubit.isCaseDetail ? 'Edit Case' : 'Add Case',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: selectedColor),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Form(
                      key: cubit.addCaseFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //select customer text and add customer
                          Card(
                            elevation: 8,
                            color: Colors.white70,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 22,
                                  top: MediaQuery.of(context).size.width / 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Choose a customer:',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: selectedColor),
                                        ),
                                      ),
                                    ],
                                  ),

                                  // search for customer

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: TextFormField(
                                            enabled: false,
                                            controller:
                                                cubit.txtUserNameController,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            navigateTo(
                                                context: context,
                                                widget:
                                                    const SelectCustomerScreen());
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: blueColor,
                                          )),
                                      // IconButton(
                                      //     onPressed: () {
                                      //       navigateTo(
                                      //           context: context,
                                      //           widget: const AddContact());
                                      //     },
                                      //     icon:   Icon(
                                      //       Icons.person_add_alt,
                                      //       color: blueColor,
                                      //     )),
                                    ],
                                  ),

                                  // Autocomplete<CustomerData>(
                                  //   initialValue:
                                  //       TextEditingValue(text: cubit.initialValue),
                                  //   displayStringForOption:
                                  //       cubit.displayStringForOption,
                                  //   optionsBuilder:
                                  //       (TextEditingValue textEditingValue) {
                                  //     if (textEditingValue.text == '') {
                                  //       return const Iterable<CustomerData>.empty();
                                  //     }
                                  //     return cubit.customerItems
                                  //         .where((CustomerData option) {
                                  //       return option.name
                                  //           .toString()
                                  //           .toLowerCase()
                                  //           .contains(
                                  //               textEditingValue.text.toLowerCase());
                                  //     });
                                  //   },
                                  //   onSelected: (CustomerData selection) {
                                  //     cubit.selectCustomer(
                                  //         selection.name,
                                  //         selection.phone,
                                  //         selection.email,
                                  //         selection.customerType,
                                  //         selection.iD);
                                  //   },
                                  // ),

                                  // SizedBox(height: size.height * 0.01),
                                  // if (cubit.selectCustomerName==false) Text(
                                  //   'Customer Name : ',
                                  //   style: TextStyle(
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.w500,
                                  //       color: selectedColor),
                                  // ) else const SizedBox(),
                                  // if (cubit.selectCustomerName==false) Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(50)),
                                  //   child: TextFormField(
                                  //     enabled: false,
                                  //     controller: cubit.txtUserNameController,
                                  //   ),
                                  // ) else const SizedBox(),

                                  SizedBox(height: size.height * 0.04),

                                  // SizedBox(height: size.height * 0.01),
                                  Text(
                                    'Customer Email Address : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: selectedColor),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: TextFormField(
                                      enabled: false,
                                      controller:
                                          cubit.txtCustomerEmailController,
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.04),

                                  Text(
                                    'Customer Phone : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: selectedColor),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: TextFormField(
                                      enabled: false,
                                      controller:
                                          cubit.txtCustomerPhoneController,
                                    ),
                                  ),

                                  SizedBox(height: size.height * 0.04),
                                ],
                              ),
                            ),
                          ),

                          // Case Number
                          cubit.isCaseDetail == true
                              ? Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    Row(
                                      children: [
                                        Text(
                                          'Case Number : ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: selectedColor),
                                        ),
                                        Text(
                                          '#${cubit.caseNumber.toString()}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: unselectedColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          // case Subject
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Case Subject:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            child: defaultTextFormField(
                              controller: cubit.txtCaseSubjectController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this box ';
                                }
                                return null;
                              },
                            ),
                          ),

                          // creation date
                          cubit.isCaseDetail == true
                              ? Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    Row(
                                      children: [
                                        Text(
                                          'Created on: ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: selectedColor),
                                        ),
                                        Text(
                                          cubit.creationDate,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: unselectedColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),

                          //SLA
                          cubit.isCaseDetail == true
                              ? SizedBox(height: size.height * 0.02)
                              : const SizedBox(),

                          cubit.isCaseDetail == true
                              ? Row(
                                  children: [
                                    Text(
                                      'SLA:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: selectedColor),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Icon(
                                      FlutterIcons.flag_mco,
                                      color:
                                          HomeLayoutCubit.get(context).slaColor,
                                    )
                                  ],
                                )
                              : const SizedBox(),

                          //Select date and time
                          // SizedBox(height: size.height * 0.02),
                          //
                          // Text(
                          //   'Target  Date :',
                          //   style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w500,
                          //       color: selectedColor),
                          // ),
                          // SizedBox(height: size.height / 200),
                          //
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Expanded(
                          //         child: Row(
                          //           children: [
                          //             Text(
                          //               '${cubit.selectedDate.toLocal()}'
                          //                   .split(' ')[0],
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.w500,
                          //                   color: selectedColor),
                          //             ),
                          //             const SizedBox(width: 10),
                          //             Text(
                          //               cubit.selectedTime.format(context),
                          //               style: TextStyle(
                          //                   fontSize: 16,
                          //                   fontWeight: FontWeight.bold,
                          //                   color: selectedColor),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         width: 5,
                          //       ),
                          //       IconButton(
                          //           onPressed: () {
                          //             cubit.selectDate(context);
                          //           },
                          //           icon: Icon(
                          //             Icons.date_range,
                          //             color: selectedColor,
                          //           )),
                          //       const SizedBox(
                          //         width: 5,
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          /*description*/
                          SizedBox(height: size.height * 0.02),

                          Text(
                            'Description:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),

                          Container(
                            child: defaultTextFormField(
                              maxLine: 15,
                              controller: cubit.txtDescriptionController,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this box ';
                                }
                                return null;
                              },
                              onSubmit: (value) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),

                          // Type
                          Text(
                            'Type:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),

                          cubit.TypesItemsString != null && cubit.Type != null
                              ? SizedBox(
                                  width: double.infinity,
                                  child: DropdownButton<String>(
                                    value: cubit.Type ??
                                        cubit.TypesItems.firstWhere((element) =>
                                            element.id ==
                                            cubit.getTypesModel.data
                                                .deaultTypeId).name,
                                    isExpanded: true,
                                    elevation: 16,
                                    style: TextStyle(color: selectedColor),
                                    items: cubit.TypesItemsString.map(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value ??
                                            cubit.TypesItems.firstWhere(
                                                (element) =>
                                                    element.id ==
                                                    cubit.getTypesModel.data
                                                        .deaultTypeId).name,
                                        child: Row(
                                          children: [
                                            Text(value ??
                                                cubit.TypesItems.firstWhere(
                                                        (element) =>
                                                            element.id ==
                                                            cubit
                                                                .getTypesModel
                                                                .data
                                                                .deaultTypeId)
                                                    .name),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      cubit.changeTypeValue(newValue, context);
                                    },
                                  ),
                                )
                              : const SizedBox(),

                          //Source
                          SizedBox(height: size.height * 0.02),

                          Text(
                            'Source:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),

                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.Source,
                              isExpanded: true,
                              items:
                                  cubit.SourcesItemsString.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        value,
                                        style: TextStyle(color: selectedColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changeSourceValue(newValue, context);
                              },
                            ),
                          ),

                          //Users
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Users:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          MultiSelectDialogField(
                            onConfirm: (val) {
                              cubit.selectUser(val, context);
                            },
                            buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
                            itemsTextStyle: TextStyle(
                                color: selectedColor,
                                fontWeight: FontWeight.w500),
                            dialogWidth:
                                MediaQuery.of(context).size.width * 0.7,
                            dialogHeight:
                                MediaQuery.of(context).size.height * 0.5,
                            backgroundColor: Colors.blueGrey[50],
                            cancelText: const Text(
                              'CANCEL',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: users,
                            initialValue: cubit.selectedUser,
                          ),

                          //OU
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'OU :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          MultiSelectDialogField(
                            onConfirm: (val) {
                              cubit.selectOU(val, context);
                            },
                            buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
                            itemsTextStyle: TextStyle(
                                color: selectedColor,
                                fontWeight: FontWeight.w500),
                            dialogWidth:
                                MediaQuery.of(context).size.width * 0.7,
                            dialogHeight:
                                MediaQuery.of(context).size.height * 0.5,
                            backgroundColor: Colors.blueGrey[50],
                            cancelText: const Text(
                              'CANCEL',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: OUs,
                            initialValue: cubit.selectedOU,
                          ),

                          //Group
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Group :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          MultiSelectDialogField(
                            onConfirm: (val) {
                              cubit.selectGroup(val, context);
                            },
                            buttonIcon: const Icon(Icons.arrow_drop_down_sharp),
                            itemsTextStyle: TextStyle(
                                color: selectedColor,
                                fontWeight: FontWeight.w500),
                            dialogWidth:
                                MediaQuery.of(context).size.width * 0.7,
                            dialogHeight:
                                MediaQuery.of(context).size.height * 0.5,
                            backgroundColor: Colors.blueGrey[50],
                            cancelText: const Text(
                              'CANCEL',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: groups,
                            initialValue: cubit.selectedGroups,
                          ),

                          //Product Group
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Product Group:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.ProductGroupValue,
                              isExpanded: true,
                              items:
                                  cubit.ProductGroupString.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Text(
                                        value,
                                        style: TextStyle(color: selectedColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changeProductGroupValue(
                                    newValue, context);
                              },
                            ),
                          ),

                          //Product
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Product :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            child: DropdownButton<String>(
                              value: cubit.ProductValue ?? '- - - Select - - -',
                              isExpanded: true,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                              items: cubit.ProductString.map((String value) {
                                return DropdownMenuItem<String>(
                                  enabled: cubit.enableProduct,
                                  value: value ?? '',
                                  child: Text(
                                    value ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: selectedColor),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changeProductValue(newValue, context);
                              },
                            ),
                          ),

                          // Category
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Category :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.CategoryValue ?? '',
                              isExpanded: true,
                              items: cubit.CategoryString.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value ?? '',
                                  child: Row(
                                    children: [
                                      Text(
                                        value ?? '',
                                        style: TextStyle(color: selectedColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changeCategoryValue(newValue, context);
                              },
                            ),
                          ),

                          //SubCategory
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'Sub Category :',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.SubCategoryValue,
                              isExpanded: true,
                              items:
                                  cubit.SubCategoryString.map((String value) {
                                return DropdownMenuItem<String>(
                                  enabled: cubit.enableSubCategory,
                                  value: value,
                                  child: Row(
                                    children: [
                                      Text(
                                        value,
                                        style: TextStyle(color: selectedColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changeSubCategoryValue(newValue, context);
                              },
                            ),
                          ),

                          // status
                          Text(
                            'Status:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),

                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.StateValue,
                              isExpanded: true,
                              elevation: 16,
                              style: TextStyle(color: selectedColor),
                              items:
                                  cubit.StatusItemsString.map((String value) {
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
                                cubit.changeStateValue(newValue);
                              },
                            ),
                          ),

                          //priority
                          SizedBox(height: size.height * 0.02),

                          Text(
                            'Priority:',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: selectedColor),
                          ),
                          SizedBox(height: size.height * 0.02),
                          SizedBox(
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: cubit.priorityValue,
                              isExpanded: true,
                              items: cubit.PrioritiesString.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              cubit.changePriorityColor(value)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        value,
                                        style: TextStyle(color: selectedColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                cubit.changePriorityValue(newValue);
                              },
                            ),
                          ),

                          //  Attachment
                          if (cubit.isCaseDetail &&
                              cubit.attachments.isNotEmpty)
                            SizedBox(height: size.height * 0.02)
                          else
                            const SizedBox(),

                          if (cubit.isCaseDetail)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Attachments:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: selectedColor),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.selectFile(cubit.caseId);
                                    },
                                    icon: Icon(
                                      FlutterIcons.attachment_ent,
                                      color: selectedColor,
                                      size: 20,
                                    ))
                              ],
                            )
                          else
                            const SizedBox(),
                          if (cubit.isCaseDetail &&
                              cubit.attachments.isNotEmpty)
                            SizedBox(height: size.height * 0.02)
                          else
                            const SizedBox(),

                          if (cubit.isCaseDetail &&
                              cubit.attachments.isNotEmpty)
                            SafeArea(
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit
                                                    .attachments[index].fileName
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.blue[800],
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.blue,
                                                child: Center(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cubit.downloadAttachment(
                                                              cubit
                                                                  .attachments[
                                                                      index]
                                                                  .filePath);
                                                        },
                                                        icon: const Icon(
                                                          Icons.cloud_download,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ))))
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          thickness: 0.5,
                                        );
                                      },
                                      itemCount: cubit.attachments.length),
                                ),
                              ),
                            )
                          else
                            const SizedBox(),

                          //  Notes
                          if (cubit.isCaseDetail && cubit.notes.isNotEmpty)
                            SizedBox(height: size.height * 0.02)
                          else
                            const SizedBox(),

                          if (cubit.isCaseDetail)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Notes:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: selectedColor),
                                ),
                                // Add Note
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                content: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: SingleChildScrollView(
                                                    child: Form(
                                                      key: cubit.addNoteFormKey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                'Add note:',
                                                                style: TextStyle(
                                                                    color:
                                                                        selectedColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    if (cubit
                                                                        .addNoteFormKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      cubit.addNote(
                                                                          context,
                                                                          cubit
                                                                              .caseId,
                                                                          cubit
                                                                              .txtAddNoteController
                                                                              .text
                                                                              .trim(),
                                                                          cubit
                                                                              .showToCustomer);
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: 15,
                                                                    child: const Center(
                                                                        child: Icon(
                                                                      Icons
                                                                          .send,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 15,
                                                                    )),
                                                                    backgroundColor:
                                                                        selectedColor,
                                                                  ))
                                                            ],
                                                          ),
                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                          //
                                                          // QuillToolbar.basic(
                                                          //     controller: cubit.txtAddNoteController,
                                                          //     showImageButton: false,
                                                          //
                                                          // showVideoButton: false,
                                                          //   showCameraButton: false,
                                                          //   showLink: false,
                                                          //   showRedo: false,
                                                          //
                                                          //   // showQuote: false,
                                                          //
                                                          //
                                                          //
                                                          //
                                                          // ),
                                                          // SizedBox(
                                                          //     height: MediaQuery.of(
                                                          //         context)
                                                          //         .size
                                                          //         .height /
                                                          //         30),
                                                          // Container(
                                                          //   padding: EdgeInsets.symmetric(value),
                                                          //   child: QuillEditor.basic(
                                                          //     controller: cubit.txtAddNoteController,
                                                          //
                                                          //     readOnly: false, // true for view only mode
                                                          //   ),
                                                          // ),

                                                          // HtmlEditor(
                                                          //   controller: null,
                                                          // ),
                                                          SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                TextFormField(
                                                              controller: cubit
                                                                  .txtAddNoteController,
                                                              validator:
                                                                  (value) {
                                                                if (value
                                                                    .isEmpty) {
                                                                  return 'Fill this box ';
                                                                }
                                                                return null;
                                                              },
                                                              maxLines: 10,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'write your note here...',
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            ),
                                                          ),

                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                          SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  30),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              FlutterSwitch(
                                                                height:
                                                                    size.height /
                                                                        30,
                                                                width:
                                                                    size.width /
                                                                        6,
                                                                value: cubit
                                                                    .showToCustomer,
                                                                onToggle:
                                                                    (value) {
                                                                  setState(() {
                                                                    cubit.changeCheekBox(
                                                                        value);
                                                                  });
                                                                },
                                                              ),
                                                              Text(
                                                                'Show to customer',
                                                                style: TextStyle(
                                                                    color: cubit.showToCustomer ==
                                                                            true
                                                                        ? selectedColor
                                                                        : Colors
                                                                            .grey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                elevation: 24,
                                                backgroundColor:
                                                    Colors.blueGrey[50],
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_comment_rounded,
                                      color: selectedColor,
                                      size: 20,
                                    ))
                              ],
                            )
                          else
                            const SizedBox(),
                          if (cubit.isCaseDetail && cubit.notes.isNotEmpty)
                            SizedBox(height: size.height * 0.02)
                          else
                            const SizedBox(),

                          if (cubit.isCaseDetail && cubit.notes.isNotEmpty)
                            SafeArea(
                              child: SizedBox(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return NoteItem(
                                          createdBy:
                                              cubit.notes[index].createdBy,
                                          id: cubit.notes[index].id,
                                          createdOn:
                                              cubit.notes[index].createdOn,
                                          note: cubit.notes[index].note,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        );
                                      },
                                      itemCount: cubit.notes.length),
                                ),
                              ),
                            )
                          else
                            const SizedBox(),

                          SizedBox(height: size.height * 0.02),

                          // button
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: double.infinity,
                            child: MaterialButton(
                              color: selectedColor,
                              onPressed: () {
                                if (cubit.addCaseFormKey.currentState
                                    .validate()) {
                                  cubit.isCaseDetail == true
                                      ? cubit.updateCase(cubit.caseId, context,
                                          cubit.selectedCustomerCustomerId)
                                      : cubit.addCase(context);
                                } else {
                                  return null;
                                }
                              },
                              child: Center(
                                child: Text(
                                  cubit.isCaseDetail == true
                                      ? 'Update'
                                      : 'Add Case',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.04),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
