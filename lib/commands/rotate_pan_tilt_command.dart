import 'package:flutter/cupertino.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

import 'commands.dart';

enum RotatorAction { left, right, up, down, stop, setOrigin, gotoOrigin }

class RotatePanTiltCommand extends BaseCommand {
  Future<bool> run(RotatorAction rotatorAction, {double? degree}) async {
    SerialPort? serialPort = rotatorModel.connectedSerialPort;
    assert(serialPort != null && serialPort.isOpen);

    switch (rotatorAction) {
      case RotatorAction.left:
        var success = serialService.rotateLeft(serialPort!);
        rotatorModel.setAction(rotatorAction);
        await _futureStop(degree, rotatorModel.horizontalSpeed, serialPort);
        return success;
      case RotatorAction.right:
        var success = serialService.rotateRight(serialPort!);
        rotatorModel.setAction(rotatorAction);
        await _futureStop(degree, rotatorModel.horizontalSpeed, serialPort);
        return success;
      case RotatorAction.up:
        var success = serialService.rotateUp(serialPort!);
        rotatorModel.setAction(rotatorAction);
        await _futureStop(degree, rotatorModel.verticalSpeed, serialPort);
        return success;
      case RotatorAction.down:
        var success = serialService.rotateDown(serialPort!);
        rotatorModel.setAction(rotatorAction);
        await _futureStop(degree, rotatorModel.verticalSpeed, serialPort);
        return success;
      case RotatorAction.setOrigin:
        rotatorModel.setAsOrigin();
        return serialService.setOrigin(serialPort!);
      case RotatorAction.gotoOrigin:
        bool success = serialService.gotoOrigin(serialPort!);
        rotatorModel.setAsOrigin();
        return success;
      default: // Only the stop case
        rotatorModel.setAction(rotatorAction);
        return serialService.stop(serialPort!);
    }
  }

  Future<void> _futureStop(
      double? degree, int speed, SerialPort serialPort) async {
    if (degree != null && degree > 0) {
      debugPrint("Schedule stop after ${degree * speed} ms");
      await Future.delayed(
          Duration(microseconds: (degree * speed * 1000).toInt()), () {
        serialService.stop(serialPort);
        rotatorModel.setAction(RotatorAction.stop);
      });
      debugPrint("stop command sent");
    }
  }
}
