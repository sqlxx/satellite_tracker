import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:satellite_tracker/views/calibration_form.dart';

import '../generated/l10n.dart';

class CalibrationDialog extends StatelessWidget {
  const CalibrationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: const [CalibrationForm(Mode.azimuth), CalibrationForm(Mode.elevation)]),
      ),
    );
  }
}
