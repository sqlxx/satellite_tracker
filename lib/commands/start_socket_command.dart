import 'package:satellite_tracker/commands/commands.dart';

class StartSocketCommand extends BaseCommand {
  Future<void> run() async {
    await tcpServer.start();
  }
}
