import 'package:satellite_tracker/commands/commands.dart';

class SocketClientErrorCommand extends BaseCommand {
  void run(Object error, StackTrace stackTrace) {
    // TODO: Handle connection error
    tcpServerModel.statusText = 'Error: $error, $stackTrace';
  }
}
