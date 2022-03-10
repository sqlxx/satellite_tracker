import 'dart:io';

import 'package:satellite_tracker/commands/commands.dart';

class StartSocketCommand extends BaseCommand {
  Future<void> run() async {
    ServerSocket? serverSocket = await tcpServer.start(tcpServerModel.port);
    if (serverSocket == null) {
      tcpServerModel.serving = false;
      tcpServerModel.statusText = "Listening failed";
    } else {
      tcpServerModel.statusText = 'Listening on ${serverSocket.address.address}:${serverSocket.port}';
      tcpServerModel.serving = true;
    }
  }
}
