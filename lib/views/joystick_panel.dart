import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/_widgets/mixins/serial_connection_mixin.dart';
import 'package:satellite_tracker/commands/pan_tilt_rotation_command.dart';

import '../generated/l10n.dart';
import '../models/rotator_model.dart';

class JoystickPanel extends StatefulWidget {
  const JoystickPanel({Key? key}) : super(key: key);

  @override
  State<JoystickPanel> createState() => _JoystickPanelState();
}

class _JoystickPanelState extends State<JoystickPanel> with SerialConnectionMixin {
  @override
  Widget build(BuildContext context) {
    RotatorModel rotatorModel = context.watch<RotatorModel>();
    isSerialPortOpened = rotatorModel.connectedSerialPort != null;

    return SizedBox(
      height: 380,
      width: 380,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [
          const SizedBox(width: 10),
          ElevatedButton(onPressed: whenConnected(() => {_rotatePanTilt(Direction.up)}), child: Text(S.of(context).up)),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: whenConnected(() => {_rotatePanTilt(Direction.left)}), child: Text(S.of(context).left)),
          ElevatedButton(onPressed: whenConnected(() => {_stopPanTilt()}), child: Text(S.of(context).stop)),
          ElevatedButton(
              onPressed: whenConnected(() => {_rotatePanTilt(Direction.right)}), child: Text(S.of(context).right)),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: whenConnected(() => {_rotatePanTilt(Direction.down)}), child: Text(S.of(context).down)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  void _rotatePanTilt(Direction direction) {
    PanTiltRotationCommand().run(direction, 1);
  }

  void _stopPanTilt() {
    PanTiltRotationCommand().run(Direction.left, context.read<RotatorModel>().currentAzimuth);
    PanTiltRotationCommand().run(Direction.down, context.read<RotatorModel>().currentElevation);
  }
}
