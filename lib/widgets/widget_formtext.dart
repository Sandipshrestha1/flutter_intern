import 'package:flutter/material.dart';

Widget formtext({
  //required String
  labeltext,
  //required String
  hinttext,
  controller,
  validate,
  keyType,
  prefixIcon,
  suffixIcon,

  //String? Function(dynamic value) validator,
}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    keyboardType: keyType,
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labeltext,
        hintText: hinttext,
        disabledBorder: InputBorder.none,
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        border: const OutlineInputBorder()),
  );
}
