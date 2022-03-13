import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:satellite_tracker/commands/commands.dart';
import 'package:satellite_tracker/commands/rotate_pan_tilt_command.dart';

class SocketDataReceivedCommand extends BaseCommand {
  static const int threshold = 1;
  void run(Uint8List data) {
    String str = String.fromCharCodes(data).trim();
    tcpServerModel.statusText = 'Data Received: $str';
    if (rotatorModel.tracking && rotatorModel.isConnected) {
      var result = _parseCommand(str);
      var azimuth = result[0];
      var elevation = result[1];
      // TODO: only for debug

      if (elevation < 0) elevation = -elevation;
      if (azimuth < 0 || elevation < 0) {
        debugPrint("Do nothing");
      } else {
        if (!rotatorModel.moving) {
          _goTo(azimuth, elevation);
        }
      }
    }
  }

  List<double> _parseCommand(String command) {
    if (command.startsWith("\\set_pos")) {
      var parts = command.split('\n');
      parts = parts[0].split(' ');
      if (parts.length != 3) {
        debugPrint("invalid command $command $parts");
      }
      return [double.parse(parts[1]), double.parse(parts[2])];
    } else {
      debugPrint("Unknown command");
      return [-1, -1];
    }
  }

  void _goTo(double azimuth, double elevation) async {
    var intAzimuth = azimuth.toInt();
    var intElevation = elevation.toInt();

    if (intAzimuth < rotatorModel.azimuthBegin) {
      intAzimuth = rotatorModel.azimuthBegin;
    }
    if (intAzimuth > rotatorModel.azimuthEnd) {
      intAzimuth = rotatorModel.azimuthEnd;
    }
    if (intElevation < rotatorModel.elevationBegin) {
      intElevation = rotatorModel.elevationBegin;
    }
    if (intElevation > rotatorModel.elevationEnd) {
      intElevation = rotatorModel.elevationEnd;
    }

    var azimuthDiff = intAzimuth - rotatorModel.currentAzimuth.toInt();
    var elevationDiff = intElevation - rotatorModel.currentElevation.toInt();

    if (azimuthDiff >= threshold) {
      RotatePanTiltCommand().run(RotatorAction.right);
      await _waitTillAzimuth(intAzimuth);
      RotatePanTiltCommand().run(RotatorAction.stop);
      debugPrint("Move Azimuth to $intAzimuth");
    } else if (azimuthDiff <= -threshold) {
      RotatePanTiltCommand().run(RotatorAction.left);
      await _waitTillAzimuth(intAzimuth);
      RotatePanTiltCommand().run(RotatorAction.stop);
      debugPrint("Move Azimuth to $intAzimuth");
    }

    if (elevationDiff >= threshold) {
      RotatePanTiltCommand().run(RotatorAction.up);
      await _waitTillElevation(intElevation);
      RotatePanTiltCommand().run(RotatorAction.stop);
      debugPrint("Move Elevation to $intElevation");
    } else if (elevationDiff <= -threshold) {
      RotatePanTiltCommand().run(RotatorAction.down);
      await _waitTillElevation(intElevation);
      RotatePanTiltCommand().run(RotatorAction.stop);
      debugPrint("Move Elevation to $intElevation");
    }
  }

  Future<void> _waitTillAzimuth(int azimuth) async {
    while (rotatorModel.currentAzimuth.toInt() != azimuth) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }

  Future<void> _waitTillElevation(int elevation) async {
    while (rotatorModel.currentElevation.toInt() != elevation) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
