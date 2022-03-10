import 'dart:io';

import 'package:satellite_tracker/commands/commands.dart';

class SocketClientConnectionCommand extends BaseCommand {
  void run(Socket client, bool isConnect) {
    if (isConnect) {
      tcpServerModel.statusText = 'Connected from ${client.remoteAddress.address}:${client.remotePort} ';
    } else {
      tcpServerModel.statusText = 'client disconnected.';
    }
  }
}
