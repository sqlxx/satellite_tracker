import 'package:satellite_tracker/_utils/preference_util.dart';
import 'package:satellite_tracker/commands/commands.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePreferenceCommand extends BaseCommand {
  Future<void> run() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(PreferenceKeys.azimuthBegin, rotatorModel.azimuthBegin);
    prefs.setInt(PreferenceKeys.azimuthEnd, rotatorModel.azimuthEnd);
    prefs.setInt(PreferenceKeys.elevationBegin, rotatorModel.elevationBegin);
    prefs.setInt(PreferenceKeys.elevationEnd, rotatorModel.elevationEnd);
    prefs.setInt(PreferenceKeys.horizontalSpeed, rotatorModel.horizontalSpeed);
    prefs.setInt(PreferenceKeys.verticalSpeed, rotatorModel.verticalSpeed);
    prefs.setInt(PreferenceKeys.rotatorAddr, rotatorModel.rotatorAddr);
    prefs.setInt(PreferenceKeys.baudRate, rotatorModel.baudRate);
    prefs.setInt(PreferenceKeys.currentAzimuth, rotatorModel.currentAzimuth);
    prefs.setInt(PreferenceKeys.currentElevation, rotatorModel.currentElevation);
    prefs.setInt(PreferenceKeys.tcpPort, tcpServerModel.port);
  }
}
