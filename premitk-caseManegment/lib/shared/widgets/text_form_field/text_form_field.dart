

// @dart=2.9
import 'package:flutter/material.dart';

Widget defaultTextFormField(
    {
      TextEditingController controller,
      TextInputType type,
      String label,
      IconData prefix,
      Function validate,
      IconData suffix,
      bool isPassword = false,
      Function onchange,
      Function onSubmit,
      Function hidden,
      Function onTap,
      int maxLine,
      bool enabled}) {
  return TextFormField(
    onChanged: onchange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: validate,
    controller: controller,
    keyboardType: type,
    maxLines: maxLine,
    enabled: enabled,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
        icon: Icon(suffix),
        onPressed: hidden,
      )
          : null,
    ),
  );
}