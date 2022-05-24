import 'package:flutter/material.dart';

class ColorStyle {
  static final Color primaryWhite = Colors.white;
  static final Color secondryBlack = Colors.black;
  static final Color blue = Colors.blueAccent;
  static final Color grey = Colors.grey.withOpacity(0.6);

  static Color hex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

