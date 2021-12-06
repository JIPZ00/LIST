import 'package:flutter/material.dart';

const Color primary = Color(0xffF9F8F8);
const Color secondary = Color(0xff7E7F9A);
const Color blanco = Color(0xffF9F8F8);
const Color amarillo = Color(0xffF3DE8A);
const Color rojo = Color(0xffEB9486);
const Color primaryBlueColor = Color(0xff3F8CFF);
const Color primaryWhite = Color(0xffFFFFFF);
const Color backgroundPageColor = Color(0xffF4F6FC);
const Color unselectedOptionColor = Color(0xffD1D1D1);
ThemeData miTema(BuildContext context) {
  return ThemeData(
      primaryColor: primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.grey,
      ).copyWith(
        secondary: Colors.amber,
      ));
}
