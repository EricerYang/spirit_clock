import 'dart:io';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spirit_clock/spirit_clock.dart';

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(ClockCustomizer((ClockModel model) => SpiritClock(model)));
}
