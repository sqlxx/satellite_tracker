import 'package:flutter/cupertino.dart';

mixin SerialConnectionMixin<T extends StatefulWidget> on State<T> {
  bool isSerialPortOpened = false;

  VoidCallback? whenConnected(VoidCallback function) {
    return isSerialPortOpened ? function : null;
  }
}
