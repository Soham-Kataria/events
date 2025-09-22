import 'package:flutter/material.dart';

/// Main color palette
const kPrimaryColor = Color(0xff008080);
const kSecondaryColor = Color(0xff30be82);
const kTertiaryColor = Color(0xffa862ea);
const kDarkColor = Color(0xff272626);
const kLightColor = Color(0xffd9e1e1);
const kGrayColor = Color(0xff6e6e6e);
const kWhiteColor = Color(0xffffffff);
const kLightBackgroundColor = Color(0xfff9eeff);
const kDarkBackgroundColor = Color(0xff171313);

// Button colors
const kButtonBackgroundColor = kPrimaryColor; // same as primary
const kButtonTextColor = kWhiteColor;


/// Light Theme Colors
final lightColorScheme = ColorScheme.light(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  tertiary: kTertiaryColor,
  surface: kLightBackgroundColor,
  onSurface: kDarkColor,
  outline: kGrayColor,
);

/// Dark Theme Colors
final darkColorScheme = ColorScheme.dark(
  primary: kPrimaryColor,
  secondary: kSecondaryColor,
  tertiary: kTertiaryColor,
  surface: kDarkBackgroundColor,
  onSurface: kLightColor,
  outline: kGrayColor,
);
