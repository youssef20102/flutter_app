// ignore_for_file: non_constant_identifier_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:primitk_crm/shared/style/color.dart';



Widget addTicket_customer(context, String imageUrl, String name, String email) {
  return GestureDetector(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundImage: NetworkImage(
          imageUrl,
        ),
        maxRadius: 30,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.02,
      ),
      Text(
        name,
        style: TextStyle(
            color: selectedColor,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis),
      )
    ],
  ));
}
