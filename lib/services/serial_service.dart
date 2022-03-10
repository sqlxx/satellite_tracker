import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class SerialService {
  List<SerialPort> getSerialPorts() {
    return SerialPort.availablePorts.map((e) {
      SerialPort sp = SerialPort(e);
      debugPrint(
          'address: ${sp.address}, busNumber: ${sp.busNumber}, desc: ${sp.description}, deviceNum: ${sp.deviceNumber}, '
          'manufacturer: ${sp.manufacturer}, name: ${sp.name}');
      return sp;
    }).toList();
  }

  bool openWrite(SerialPort serialPort) {
    return serialPort.openWrite();
  }

  bool close(SerialPort serialPort) {
    return serialPort.close();
  }

  void reset() {}

  void rotateLeft() {}

  void rotateRight() {}

  void rotateUp() {}

  void rotateDown() {}
}
