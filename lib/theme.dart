import "package:flutter/material.dart";

class AppTheme {
  static const colorRed = Color(0xffE4726C);
  static const colorDarkRed = Color(0xffdf564e);
  static const colorGreen = Color(0xff6BCCAB);
  static const colorBlue = Color(0xff6690DA);
  static const colorGrey = Color(0xffAAA8A8);
  static const colorWhite = Color(0xffEBE8E8);

  static const colorGoogleBlue = Color(0xff4885ed);

  static TextStyle get standardText {
    return const TextStyle(
      color: colorWhite,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle get largeText {
    return const TextStyle(
      color: colorWhite,
      fontFamily: 'Roboto',
      fontSize: 35,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle get smallText {
    return const TextStyle(
      color: colorWhite,
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle get cardText {
    return const TextStyle(
      color: colorGreen,
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get largeDarkText {
    return const TextStyle(
      color: colorGrey,
      fontFamily: 'Roboto',
      fontSize: 35,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle get recordCardText {
    return const TextStyle(
      color: colorWhite,
      fontFamily: 'Roboto',
      fontSize: 19,
      fontWeight: FontWeight.w400,
    );
  }

  static Color get transparantText {
    return colorWhite.withOpacity(.5);
  }

  static RoundedRectangleBorder get cardShape {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    );
  }
}
