import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/_widgets/mixins/serial_connecion_mixin.dart';
import 'package:satellite_tracker/models/rotator_model.dart';

import '../generated/l10n.dart';
import 'calibration_dialog.dart';

class CommandPanel extends StatefulWidget {
  const CommandPanel({Key? key}) : super(key: key);

  @override
  State<CommandPanel> createState() => _CommandPanelState();
}

class _CommandPanelState extends State<CommandPanel> with SerialConnectionMixin {
  @override
  Widget build(BuildContext context) {
    RotatorModel rotatorModel = context.watch<RotatorModel>();
    isSerialPortOpened = rotatorModel.connectedSerialPort != null;

    return Column(
      children: [
        Text('${S.of(context).azimuth}: ${rotatorModel.currentAzimuth}'),
        const SizedBox(height: 8),
        Text('${S.of(context).elevation}: ${rotatorModel.currentElevation}'),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: whenConnected(() {
              rotatorModel.currentAzimuth = 0;
              rotatorModel.currentElevation = 0;
            }),
            child: Text(S.of(context).setZero)),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const CalibrationDialog();
                  });
              // Start the server
            },
            child: Text(S.of(context).calibrate)),
      ],
    );
  }
}
