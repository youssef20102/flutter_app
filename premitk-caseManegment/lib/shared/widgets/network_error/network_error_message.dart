
import 'package:flutter/material.dart';

Widget errorMsg(String text, bool show) {
  //error message widget.
  if (show == true) {
    //if error is true then show error message box
    return Container(
      padding: const EdgeInsets.all(10.00),
      margin: const EdgeInsets.only(bottom: 10.00),
      color: Colors.red,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 6.00),
          child: const Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: const TextStyle(color: Colors.white)),
        //show error message text
      ]),
    );
  } else {
    return Container();
    //if error is false, return empty container.
  }
}