import 'dart:typed_data';

import 'package:satellite_tracker/commands/commands.dart';

class SocketDataReceivedCommand extends BaseCommand {
  void run(Uint8List data) {
    String str = String.fromCharCodes(data).trim();
    tcpServerModel.statusText = 'Data Received: $str';
  }
}
