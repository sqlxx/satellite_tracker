import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:satellite_tracker/commands/commands.dart';
import 'package:satellite_tracker/commands/rotate_pan_tilt_command.dart';

class SocketDataReceivedCommand extends BaseCommand {
  static const int threshold = 4;
  void run(Uint8List data) {
    String str = String.fromCharCodes(data).trim();
    str = str.split("\n")[0]; // Only process the first command by now
    tcpServerModel.statusText = 'Data Received: $str';
    if (rotatorModel.tracking && rotatorModel.isConnected) {
      var result = _parseCommand(str);
      var azimuth = result[0];
      var elevation = result[1];

      // TODO: only for debug
      // if (elevation < 0) elevation = -elevation;

      if (azimuth < 0 || elevation <= 10) {
        debugPrint("Do nothing");
      } else {
        if (!rotatorModel.moving) {
          _goTo(azimuth.toInt(), elevation.toInt());
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

  void _goTo(int azimuth, int elevation) async {
    if (azimuth < rotatorModel.azimuthBegin) {
      azimuth = rotatorModel.azimuthBegin;
    }
    if (azimuth > rotatorModel.azimuthEnd) {
      azimuth = rotatorModel.azimuthEnd;
    }
    if (elevation < rotatorModel.elevationBegin) {
      elevation = rotatorModel.elevationBegin;
    }
    if (elevation > rotatorModel.elevationEnd) {
      elevation = rotatorModel.elevationEnd;
    }

    var azimuthDiff = azimuth - rotatorModel.currentAzimuth;
    var elevationDiff = elevation - rotatorModel.currentElevation;

    if (azimuthDiff >= threshold) {
      await RotatePanTiltCommand().run(RotatorAction.right, degree: azimuthDiff);
      debugPrint("Moved azimuth right $azimuthDiff to ${rotatorModel.currentAzimuth}, expected $azimuth");
    } else if (azimuthDiff <= -threshold) {
      await RotatePanTiltCommand().run(RotatorAction.left, degree: -azimuthDiff);
      debugPrint("Moved azimuth left ${-azimuthDiff} to ${rotatorModel.currentAzimuth}, expected $azimuth");
    }

    if (elevationDiff >= threshold) {
      await RotatePanTiltCommand().run(RotatorAction.up, degree: elevationDiff);
      debugPrint("Moved elevation up $elevationDiff to ${rotatorModel.currentElevation}, expected $elevation");
    } else if (elevationDiff <= -threshold) {
      await RotatePanTiltCommand().run(RotatorAction.down, degree: -elevationDiff);
      debugPrint("Moved elevation down ${-elevationDiff} to ${rotatorModel.currentElevation}, expected $elevation");
    }
  }
}
