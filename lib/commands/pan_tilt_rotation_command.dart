import 'package:flutter/foundation.dart';

import 'commands.dart';

enum Direction { left, right, up, down }

class PanTiltRotationCommand extends BaseCommand {
  void run(Direction direction, double degree) {
    // TODO: control the pan tilt rotator to specific direction with degree
    debugPrint("Rotate to $direction");
  }
}
