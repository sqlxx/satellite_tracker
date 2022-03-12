import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

enum Direction { left, right, up, down, stop }

class RotatePanTiltCommand extends BaseCommand {
  bool run(Direction direction) {
    SerialPort? serialPort = rotatorModel.connectedSerialPort;
    assert(serialPort != null && serialPort.isOpen);

    // if (rotatorModel.moving && direction != Direction.stop) {
    //   debugPrint("Ignore command as it's moving");
    //   return false;
    // }

    switch (direction) {
      case Direction.left:
        rotatorModel.moving = true;
        return serialService.rotateLeft(serialPort!);
      case Direction.right:
        rotatorModel.moving = true;
        return serialService.rotateRight(serialPort!);
      case Direction.up:
        rotatorModel.moving = true;
        return serialService.rotateUp(serialPort!);
      case Direction.down:
        rotatorModel.moving = true;
        return serialService.rotateDown(serialPort!);
      default: // Only the stop case
        rotatorModel.moving = false;
        return serialService.stop(serialPort!);
    }

  }
}
