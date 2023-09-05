import 'package:flutter/material.dart';

const appName = "Memory reminder";
const fontFamily = "Roboto";
const Color themeColor = Color(0xff002b36);
const Color secondarythemeColor = Color(0xfffbf6b5);
EdgeInsets leftRightPadding =
    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0);
InputBorder border = const OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(0.0),
  ),
  borderSide: BorderSide(
    color: Colors.white,
    width: 1.0,
  ),
);

InputBorder errorborder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(0.0),
  ),
  borderSide: BorderSide(
    color: secondarythemeColor,
    width: 1.0,
  ),
);

//String baseUrl = "http://192.168.1.41:5000";
String baseUrl = "https://memoryreminderengine.onrender.com";
