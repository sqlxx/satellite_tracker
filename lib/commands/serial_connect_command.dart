import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:satellite_tracker/commands/commands.dart';

class SerialConnectCommand extends BaseCommand {
  bool run(SerialPort serialPort) {
    bool success = serialService.openWrite(serialPort);
    if (success) {
      rotatorModel.connectedSerialPort = serialPort;
    } else {
      rotatorModel.connectedSerialPort = null;
    }

    return success;
  }
}
