

import 'package:availablity/Styles/ColorStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchButtonCustom {
  static switchButton(bool value, Function(bool) onToggle) {
    return FlutterSwitch(
        width: 60.0,
        height: 36.0,
        // valueFontSize: 25.0,
        toggleSize: 26.0,
        value: value,
        // borderRadius: 30.0,
        // padding: 8.0,
        // showOnOff: true,
        inactiveColor: ColorStyle.grey,
        onToggle: onToggle
    );
  }
}