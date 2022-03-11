import 'package:shared_preferences/shared_preferences.dart';

import '../_utils/preference_util.dart';
import 'commands.dart';

class LoadPreferenceCommand extends BaseCommand {
  void run() async {
    final prefs = await SharedPreferences.getInstance();
    rotatorModel.azimuthBegin = _default(prefs.getInt(PreferenceKeys.azimuthBegin), 5);
    rotatorModel.azimuthEnd = _default(prefs.getInt(PreferenceKeys.azimuthEnd), 355);
    rotatorModel.elevationBegin = _default(prefs.getInt(PreferenceKeys.elevationBegin), 15);
    rotatorModel.elevationEnd = _default(prefs.getInt(PreferenceKeys.elevationEnd), 84);
    rotatorModel.horizontalSpeed = _default(prefs.getInt(PreferenceKeys.horizontalSpeed), 100);
    rotatorModel.verticalSpeed = _default(prefs.getInt(PreferenceKeys.verticalSpeed), 100);
    rotatorModel.rotatorAddr = _default(prefs.getInt(PreferenceKeys.rotatorAddr), 1);
    rotatorModel.baudRate = _default(prefs.getInt(PreferenceKeys.baudRate), 1200);
    rotatorModel.currentAzimuth = _default(prefs.getDouble(PreferenceKeys.currentAzimuth), 5.0);
    rotatorModel.currentElevation = _default(prefs.getDouble(PreferenceKeys.currentElevation), 15.0);

    tcpServerModel.port = _default(prefs.getInt(PreferenceKeys.tcpPort), 9900);
  }

  _default(value, defaultValue) {
    return value ?? defaultValue;
  }
}
