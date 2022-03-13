import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

enum RotatorAction { left, right, up, down, stop, setOrigin, gotoOrigin }

class RotatePanTiltCommand extends BaseCommand {
  bool run(RotatorAction direction) {
    SerialPort? serialPort = rotatorModel.connectedSerialPort;
    assert(serialPort != null && serialPort.isOpen);

    rotatorModel.setAction(direction);

    switch (direction) {
      case RotatorAction.left:
        return serialService.rotateLeft(serialPort!);
      case RotatorAction.right:
        return serialService.rotateRight(serialPort!);
      case RotatorAction.up:
        return serialService.rotateUp(serialPort!);
      case RotatorAction.down:
        return serialService.rotateDown(serialPort!);
      case RotatorAction.setOrigin:
        rotatorModel.setAsOrigin();
        return serialService.setOrigin(serialPort!);
      case RotatorAction.gotoOrigin:
        bool success = serialService.gotoOrigin(serialPort!);
        rotatorModel.setAsOrigin();
        return success;
      default: // Only the stop case
        return serialService.stop(serialPort!);
    }
  }

  // bool run(RotatorAction direction, int degress) {}
}
