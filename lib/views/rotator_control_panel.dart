import 'package:flutter/cupertino.dart';
import 'package:satellite_tracker/views/command_panel.dart';
import 'package:satellite_tracker/views/joystick_panel.dart';

class RotatorControlPanel extends StatelessWidget {
  const RotatorControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [JoystickPanel(), CommandPanel()],
    );
  }
}
