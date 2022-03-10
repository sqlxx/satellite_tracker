import 'package:flutter/cupertino.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

class ListSerialPortsCommand extends BaseCommand {
  void run() {
    List<SerialPort> serialPorts = serialService.getSerialPorts();
    debugPrint("Got ${serialPorts.length} serialPorts");
    rotatorModel.availableSerialPorts = serialPorts;
  }
}
