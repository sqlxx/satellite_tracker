import 'commands.dart';

class StopSocketCommand extends BaseCommand {
  Future<void> run() async {
    await tcpServer.stop();
    tcpServerModel.statusText = "Server Stopped";
    tcpServerModel.serving = false;
  }
}
