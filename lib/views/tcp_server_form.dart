import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/models/tcp_server_model.dart';

import '../commands/start_socket_command.dart';
import '../commands/stop_socket_command.dart';
import '../generated/l10n.dart';

class TcpServerForm extends StatefulWidget {
  const TcpServerForm({Key? key}) : super(key: key);

  @override
  State<TcpServerForm> createState() => _TcpServerFormState();
}

class _TcpServerFormState extends State<TcpServerForm> {
  late TextEditingController _portController;

  @override
  void initState() {
    super.initState();

    _portController = TextEditingController();
  }

  @override
  void dispose() {
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TcpServerModel _serverModel = context.watch<TcpServerModel>();
    _portController.text = _serverModel.port.toString();

    return Form(
        key: _formKey,
        child: Row(children: [
          Text(S.of(context).port + ": ", style: Theme.of(context).textTheme.titleLarge),
          SizedBox(
              width: 80,
              child: TextFormField(
                controller: _portController,
                decoration: InputDecoration(hintText: S.of(context).port),
                textAlign: TextAlign.right,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                enabled: !_serverModel.serving,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).inputRequired;
                  } else {
                    int? intValue = int.tryParse(value);
                    if (intValue! > 65535 || intValue < 1024) {
                      return S.of(context).useCorrectPort;
                    }
                  }

                  return null;
                },
              )),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (!_serverModel.serving) {
                    _serverModel.port = int.tryParse(_portController.text);
                    await StartSocketCommand().run();
                  } else {
                    await StopSocketCommand().run();
                  }
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //             title: const Text('Server Started'),
                  //             content: Text('TCP Server started on ${_portController.text}'),
                  //             actions: <Widget>[
                  //               TextButton(
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: const Text('OK'),
                  //               ),
                  //             ]);
                  //       });
                  //   // Start the server
                }
              },
              child: Text(_serverModel.serving ? S.of(context).stop : S.of(context).start)),
          Text("Command: ${_serverModel.statusText}"),
        ]));
  }
}
