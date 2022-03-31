import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/commands/rotate_pan_tilt_command.dart';
import 'package:satellite_tracker/commands/save_preference_command.dart';

import '../_widgets/message_box.dart';
import '../generated/l10n.dart';
import '../models/rotator_model.dart';

enum Mode { azimuth, elevation }

class CalibrationForm extends StatefulWidget {
  final Mode _mode;

  const CalibrationForm(this._mode, {Key? key}) : super(key: key);

  @override
  State<CalibrationForm> createState() => _CalibrationFormState();
}

class _CalibrationFormState extends State<CalibrationForm> {
  late TextEditingController _rangeBeginController;
  late TextEditingController _rangeEndController;
  late TextEditingController _speedController;
  late GlobalKey<FormState> _formKey;
  bool _resetInProgress = false;

  @override
  void initState() {
    super.initState();

    _rangeBeginController = TextEditingController();
    _rangeEndController = TextEditingController();
    _speedController = TextEditingController();
    _formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final RotatorModel rotatorModel = context.watch<RotatorModel>();
    _setValue(rotatorModel);

    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        children: [
          const Text('校准前请先重置，校准后请点击保存数据.'),
          const SizedBox(height: 20),
          Row(
            children: [
              SizedBox(
                  width: 110,
                  child: Text(isAzimuth ? S.of(context).azimuthRange : S.of(context).elevationRange,
                      style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  height: 75,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: S.of(context).begin),
                    textAlign: TextAlign.right,
                    controller: _rangeBeginController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                    validator: _rangeValidator,
                  )),
              const SizedBox(height: 40, child: Text("°")),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  height: 75,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: S.of(context).end),
                    textAlign: TextAlign.right,
                    controller: _rangeEndController,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                    validator: _rangeValidator,
                  )),
              const SizedBox(height: 40, child: Text("°")),
              const SizedBox(width: 10),
              SizedBox(
                  width: 120,
                  child: Text(isAzimuth ? S.of(context).horizontalSpeed : S.of(context).verticalSpeed,
                      style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  height: 75,
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(labelText: 'ms/°'),
                      controller: _speedController,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return S.of(context).fillIn;
                        }

                        int? intValue = int.tryParse(value);
                        if (intValue == null || intValue <= 0) {
                          return S.of(context).invalidValue;
                        }
                        return null;
                      })),
            ],
          ),
          Row(
            children: [
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: rotatorModel.isConnected ? _onReset : null,
                      child: Text(isAzimuth ? S.of(context).horizontalReset : S.of(context).verticalReset))),
              const SizedBox(width: 10),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: rotatorModel.isConnected ? _onCalibrate : null,
                      child: Text(S.of(context).startCalibrate))),
              const SizedBox(width: 10),
              SizedBox(width: 200, child: ElevatedButton(onPressed: _onSave, child: Text(S.of(context).save))),
            ],
          )
        ],
      ),
    );
  }

  bool get isAzimuth => widget._mode == Mode.azimuth;

  void _onCalibrate() {
    if (isAzimuth) {
      RotatePanTiltCommand().run(RotatorAction.right);
    } else {
      RotatePanTiltCommand().run(RotatorAction.up);
    }
    MessageBox.show(context, '当云台达到另一端时按下确定', _calibrateFinish);
  }

  void _calibrateFinish() {
    RotatorModel rotatorModel = context.read();
    int duration = DateTime.now().difference(rotatorModel.moveStartTime).inMilliseconds;

    if (isAzimuth) {
      rotatorModel.horizontalSpeed = duration ~/ rotatorModel.azimuthRange;
    } else {
      rotatorModel.verticalSpeed = duration ~/ rotatorModel.elevationRange;
    }
  }

  void _onReset() {
    _onSave();

    setState(() => _resetInProgress = true);

    if (isAzimuth) {
      RotatePanTiltCommand().run(RotatorAction.left);
    } else {
      RotatePanTiltCommand().run(RotatorAction.down);
    }
    MessageBox.show(context, S.of(context).isInOrigin, _onResetFinish);
  }

  void _onResetFinish() {
    RotatePanTiltCommand().run(RotatorAction.stop);
    RotatorModel model = context.read();
    isAzimuth ? model.currentAzimuth = model.azimuthBegin : model.currentElevation = model.elevationBegin;
    setState(() => _resetInProgress = false);
  }

  void _setValue(RotatorModel rotatorModel) {
    if (isAzimuth) {
      _speedController.text = rotatorModel.horizontalSpeed.toString();
      _rangeBeginController.text = rotatorModel.azimuthBegin.toString();
      _rangeEndController.text = rotatorModel.azimuthEnd.toString();
    } else {
      _speedController.text = rotatorModel.verticalSpeed.toString();
      _rangeBeginController.text = rotatorModel.elevationBegin.toString();
      _rangeEndController.text = rotatorModel.elevationEnd.toString();
    }
  }

  void _onSave() {
    RotatorModel rotatorModel = context.read();
    if (_formKey.currentState!.validate()) {
      int beginValue = int.parse(_rangeBeginController.text);
      int endValue = int.parse(_rangeEndController.text);
      int speed = int.parse(_speedController.text);

      if (endValue < beginValue) {
        debugPrint("Data invalid");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data Invalid")),
        );
      } else {
        Function saveFunc = isAzimuth ? _saveAzimuth : _saveElevation;
        saveFunc(rotatorModel, beginValue, endValue, speed);
      }

      SavePreferenceCommand().run();
    }
  }

  void _saveAzimuth(RotatorModel rotatorModel, int begin, int end, int speed) {
    rotatorModel.azimuthBegin = begin;
    rotatorModel.azimuthEnd = end;
    rotatorModel.horizontalSpeed = speed;
  }

  void _saveElevation(RotatorModel rotatorModel, int begin, int end, int speed) {
    rotatorModel.elevationBegin = begin;
    rotatorModel.elevationEnd = end;
    rotatorModel.verticalSpeed = speed;
  }

  String? _rangeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return S.of(context).fillIn;
    }
    int intValue = int.parse(value);
    int maxValue = isAzimuth ? 360 : 90;

    if (intValue > maxValue || intValue < 0) {
      return S.of(context).outOfRange;
    }
    return null;
  }
}
