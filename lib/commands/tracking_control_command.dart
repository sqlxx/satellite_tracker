import 'commands.dart';

class TrackingControlCommand extends BaseCommand {
  void run(bool start) {
     rotatorModel.tracking = start;
  }
}
