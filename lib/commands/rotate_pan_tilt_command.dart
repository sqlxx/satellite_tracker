import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

enum RotatorAction { left, right, up, down, stop }

class RotatePanTiltCommand extends BaseCommand {
  bool run(RotatorAction direction) {
    SerialPort? serialPort = rotatorModel.connectedSerialPort;
    assert(serialPort != null && serialPort.isOpen);

    // if (rotatorModel.moving && direction != Direction.stop) {
    //   debugPrint("Ignore command as it's moving");
    //   return false;
    // }

    switch (direction) {
      case RotatorAction.left:
        rotatorModel.moving = true;
        return serialService.rotateLeft(serialPort!);
      case RotatorAction.right:
        rotatorModel.moving = true;
        return serialService.rotateRight(serialPort!);
      case RotatorAction.up:
        rotatorModel.moving = true;
        return serialService.rotateUp(serialPort!);
      case RotatorAction.down:
        rotatorModel.moving = true;
        return serialService.rotateDown(serialPort!);
      default: // Only the stop case
        rotatorModel.moving = false;
        return serialService.stop(serialPort!);
    }

  }
}
