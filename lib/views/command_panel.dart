import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/_widgets/mixins/serial_connection_mixin.dart';
import 'package:satellite_tracker/commands/rotate_pan_tilt_command.dart';
import 'package:satellite_tracker/models/rotator_model.dart';

import '../generated/l10n.dart';
import 'calibration_dialog.dart';

class CommandPanel extends StatefulWidget {
  const CommandPanel({Key? key}) : super(key: key);

  @override
  State<CommandPanel> createState() => _CommandPanelState();
}

class _CommandPanelState extends State<CommandPanel>
    with SerialConnectionMixin {
  @override
  Widget build(BuildContext context) {
    RotatorModel rotatorModel = context.watch<RotatorModel>();
    isSerialPortOpened = rotatorModel.connectedSerialPort != null;

    final elevationTextController = TextEditingController();
    final azimuthTextController = TextEditingController();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                  '${S.of(context).azimuth}: ${rotatorModel.currentAzimuth.toStringAsFixed(1)}',
                  style: const TextStyle(
                      fontFeatures: [FontFeature.tabularFigures()])),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 40,
              child: TextField(
                controller: azimuthTextController,
                decoration: InputDecoration(
                    labelText: S.of(context).correction,
                    labelStyle: const TextStyle(fontSize: 10)),
                onSubmitted: (value) {
                  rotatorModel.currentAzimuth += int.tryParse(value) ?? 0;
                  azimuthTextController.clear();
                },
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                  '    ${S.of(context).elevation}: ${rotatorModel.currentElevation.toStringAsFixed(1)}',
                  style: const TextStyle(
                      fontFeatures: [FontFeature.tabularFigures()])),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 40,
              child: TextField(
                controller: elevationTextController,
                decoration: InputDecoration(
                    labelText: S.of(context).correction,
                    labelStyle: const TextStyle(fontSize: 10)),
                onSubmitted: (value) {
                  rotatorModel.currentElevation += int.tryParse(value) ?? 0;
                  elevationTextController.clear();
                },
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 100,
          child: ElevatedButton(
              onPressed: whenConnected(() {
                RotatePanTiltCommand().run(RotatorAction.setOrigin);
              }),
              child: Text(S.of(context).setOrigin)),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 100,
          child: ElevatedButton(
              onPressed: whenConnected(() {
                RotatePanTiltCommand().run(RotatorAction.gotoOrigin);
              }),
              child: Text(S.of(context).gotoOrigin)),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 100,
          child: ElevatedButton(
              onPressed: whenConnected(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CalibrationDialog();
                    });
                // Start the server
              }),
              child: Text(S.of(context).calibrate)),
        ),
      ],
    );
  }
}
