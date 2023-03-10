import 'package:flutter/material.dart';

import '../../configs/pallet.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: Pallet.darkPrimaryColor,
  scaffoldBackgroundColor: Pallet.darkPrimaryColor,
  fontFamily: 'Archivo',
  backgroundColor: Pallet.darkCardBGColor,
  canvasColor: Pallet.darkPrimaryColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Pallet.primarySwatch,
    brightness: Brightness.dark,
  ).copyWith(secondary: Pallet.darkSecondaryColor),
  textTheme: const TextTheme().apply(
      bodyColor: Pallet.darkSecondaryColor,
      displayColor: Pallet.darkSecondaryColor),
  focusColor: Pallet.darkSecondaryColor,
);
