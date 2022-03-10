// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("Satellite Tracker"),
        "autoCalibrate": MessageLookupByLibrary.simpleMessage("Auto Calibrate"),
        "azimuth": MessageLookupByLibrary.simpleMessage("Azimuth"),
        "calibrate": MessageLookupByLibrary.simpleMessage("Calibrate"),
        "connect": MessageLookupByLibrary.simpleMessage("Connect"),
        "disconnect": MessageLookupByLibrary.simpleMessage("Disconnect"),
        "down": MessageLookupByLibrary.simpleMessage("DOWN"),
        "elevation": MessageLookupByLibrary.simpleMessage("Elevation"),
        "inputRequired": MessageLookupByLibrary.simpleMessage("Please input"),
        "left": MessageLookupByLibrary.simpleMessage("LEFT"),
        "port": MessageLookupByLibrary.simpleMessage("Port"),
        "reset": MessageLookupByLibrary.simpleMessage("RESET"),
        "right": MessageLookupByLibrary.simpleMessage("RIGHT"),
        "serialPortLists":
            MessageLookupByLibrary.simpleMessage("Serial Ports: "),
        "setZero": MessageLookupByLibrary.simpleMessage("Set Zero"),
        "start": MessageLookupByLibrary.simpleMessage("Start"),
        "startTracking": MessageLookupByLibrary.simpleMessage("Start Tracking"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "stopTracking": MessageLookupByLibrary.simpleMessage("Stop Tracking"),
        "up": MessageLookupByLibrary.simpleMessage("UP"),
        "useCorrectPort": MessageLookupByLibrary.simpleMessage(
            "Port number should between 1024 & 65535")
      };
}
