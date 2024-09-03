import 'package:flutter/material.dart';
import 'package:task_management_app/constants/colors.dart';

var inputPrimaryButton = ButtonStyle(
  fixedSize: MaterialStateProperty.all(
    const Size(400, 50),
  ),
  backgroundColor: MaterialStateProperty.all(primaryColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

var inputTextField = InputDecoration(
  contentPadding: const EdgeInsets.all(20),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: greyTextColor,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(
      color: primaryColor,
      width: 2,
    ),
  ),
);
