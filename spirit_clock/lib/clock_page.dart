import 'package:flutter/material.dart';
import 'package:spirit_clock/flip_pannel.dart';

class Clock24Page extends StatelessWidget {
  Clock24Page(this.fontSize, this.format);
  final fontSize;
  final bool format;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: FlipClock.simple(
        startTime: DateTime.now(),
        digitColor: Colors.white,
        format: format,
        backgroundColor: Colors.black,
        digitSize: double.parse(fontSize.toStringAsFixed(2)),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
    );
  }
}

class Clock12Page extends StatelessWidget {
  Clock12Page(this.fontSize, this.format);
  final fontSize;
  final bool format;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.0,
      child: FlipClock.simple(
        startTime: DateTime.now(),
        digitColor: Colors.white,
        format: format,
        backgroundColor: Colors.black,
        digitSize: double.parse(fontSize.toStringAsFixed(2)),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
    );
  }
}