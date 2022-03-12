import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

/* Pelco-D command
 Byte1: 0xFF,
 Byte2: Address,
 Byte3: Command 1, no use in our case
 Byte4: Command 2,
 Byte5: Pan speed 00 to 3F, FF for turbo (My pan tilt only support FF)
 Byte6: Tilt speed 00 to 3F, FF for turbo
 Byte7: Sum of byte2~6 and module 100
 */
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
    bool success = serialPort.openWrite();
    if (!success) {
      debugPrint(SerialPort.lastError.toString());
    } else {
      var config = SerialPortConfig();
      config.baudRate = 2400;
      config.bits = 8;
      config.parity = SerialPortParity.none;
      config.stopBits = 1;
      serialPort.config = config;
      config.dispose();
    }

    return success;
  }

  bool close(SerialPort? serialPort) {
    if (_isValidPort(serialPort)) {
      bool success = serialPort!.close();
      return success;
    } else {
      return true;
    }
  }

  void reset() {}

  bool rotateLeft(SerialPort serialPort) {
    return _sendCommand(serialPort, [0xFF, 0x01, 0x00, 0x04, 0x3F, 0x00, 0x04]);
  }

  bool rotateRight(SerialPort serialPort) {
    return _sendCommand(serialPort, [0xFF, 0x01, 0x00, 0x02, 0xff, 0x00, 0x02]);
  }

  bool rotateUp(SerialPort serialPort) {
    return _sendCommand(serialPort, [0xFF, 0x01, 0x00, 0x08, 0x00, 0xff, 0x08]);
  }

  bool rotateDown(SerialPort serialPort) {
    return _sendCommand(serialPort, [0xFF, 0x01, 0x00, 0x10, 0x00, 0xff, 0x10]);
  }

  bool stop(SerialPort serialPort) {
    return _sendCommand(serialPort, [0xff, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01]);
  }

  bool _sendCommand(SerialPort serialPort, List<int> commandBytes) {
    if (_isValidPort(serialPort)) {
      Uint8List command = Uint8List.fromList(commandBytes);
      int writeBytes = serialPort.write(command);
      debugPrint("Command sent");
      return writeBytes == commandBytes.length;
    } else {
      debugPrint("Invalid Port");
      return false;
    }
  }

  bool _isValidPort(SerialPort? serialPort) {
    return serialPort != null && serialPort.isOpen;
  }
}
