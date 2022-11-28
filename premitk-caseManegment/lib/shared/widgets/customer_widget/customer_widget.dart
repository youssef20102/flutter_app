// @dart=2.9

// ignore_for_file: must_be_immutable, no_logic_in_create_state, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:primitk_crm/models/customer_model.dart';
import 'package:primitk_crm/shared/images/all_images.dart';

import 'package:primitk_crm/shared/style/color.dart';








Widget CustomerListItem(   CustomerData customerData,context, ){
  return Container(
    padding:
    const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor:selectedColor,
                backgroundImage:const AssetImage(UserInfoScreen) ,
                maxRadius: 25,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        customerData.name==''||customerData.name.isEmpty||customerData.name==null?'not found':customerData.name,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: selectedColor),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                      Text(
                        customerData.customerType,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

}

