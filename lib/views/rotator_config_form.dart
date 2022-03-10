import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/commands/list_serial_ports_command.dart';
import 'package:satellite_tracker/commands/serial_connect_command.dart';
import 'package:satellite_tracker/models/rotator_model.dart';

import '../generated/l10n.dart';

class RotatorConfigForm extends StatefulWidget {
  const RotatorConfigForm({Key? key}) : super(key: key);

  @override
  State<RotatorConfigForm> createState() => _RotatorConfigFormState();
}

class _RotatorConfigFormState extends State<RotatorConfigForm> {
  SerialPort? _selectedSerialPort;
  List<SerialPort>? _availableSerialPorts;
  bool _connected = false;
  bool _tracking = false;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() => ListSerialPortsCommand().run());
  }

  @override
  Widget build(BuildContext context) {
    _availableSerialPorts = context.select((RotatorModel m) => m.availableSerialPorts);
    _tracking = context.select((RotatorModel m) => m.tracking);
    return Form(
      child: Row(
        children: [
          Text(S.of(context).serialPortLists, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: 15),
          SizedBox(
            width: 230,
            child: DropdownButtonFormField(
              items: _availableSerialPorts!.map((SerialPort e) {
                return DropdownMenuItem(value: e, child: Text(e.description!));
              }).toList(),
              onChanged: (SerialPort? selected) {
                setState(() {
                  _selectedSerialPort = selected;
                });
              },
              value: _selectedSerialPort,
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: _selectedSerialPort == null
                  ? null
                  : () {
                      if (_selectedSerialPort != null) {
                        if (SerialConnectCommand().run(_selectedSerialPort!)) {
                          _connected = true;
                        } else {
                          debugPrint("Open serial port ${_selectedSerialPort!.name} failed");
                        }
                      }
                    },
              child: _connected ? Text(S.of(context).disconnect) : Text(S.of(context).connect)),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: !_connected
                  ? null
                  : () {
                      _tracking = !_tracking;
                    },
              child: _tracking ? Text(S.of(context).stopTracking) : Text(S.of(context).startTracking))
        ],
      ),
    );
  }
}
