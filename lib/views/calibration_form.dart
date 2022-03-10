import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../generated/l10n.dart';

enum Mode { azimuth, elevation }

class CalibrationForm extends StatefulWidget {
  final Mode _mode;

  const CalibrationForm(this._mode, {Key? key}) : super(key: key);

  @override
  State<CalibrationForm> createState() => _CalibrationFormState();
}

class _CalibrationFormState extends State<CalibrationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: 110,
                  child: Text(isAzimuth() ? S.of(context).azimuthRange : S.of(context).elevationRange,
                      style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: S.of(context).begin),
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  )),
              const Text("°"),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: S.of(context).end),
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  )),
              const Text("°"),
            ],
          ),
          Row(
            children: [
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: null,
                      child: Text(isAzimuth() ? S.of(context).horizontalReset : S.of(context).verticalReset))),
              const SizedBox(width: 10),
              SizedBox(width: 200, child: ElevatedButton(onPressed: null, child: Text(S.of(context).startCalibrate))),
              const SizedBox(width: 10),
              SizedBox(
                  width: 120,
                  child: Text(isAzimuth() ? S.of(context).horizontalSpeed : S.of(context).verticalSpeed,
                      style: Theme.of(context).textTheme.titleSmall)),
              const SizedBox(width: 10),
              SizedBox(
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                  )),
              const Text("ms/°"),
            ],
          )
        ],
      ),
    );
  }

  bool isAzimuth() => widget._mode == Mode.azimuth;
}
