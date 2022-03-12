import 'commands.dart';

class SerialDisconnectCommand extends BaseCommand {
  void run() {
    serialService.close(rotatorModel.connectedSerialPort);
    rotatorModel.connectedSerialPort = null;
  }
}
