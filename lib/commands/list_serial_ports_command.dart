import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

class ListSerialPortsCommand extends BaseCommand {
  void run() {
    List<SerialPort> serialPorts = serialService.getSerialPorts();
    rotatorModel.availableSerialPorts = serialPorts;
  }
}
