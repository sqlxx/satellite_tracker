// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("卫星追踪"),
        "azimuth": MessageLookupByLibrary.simpleMessage("方位角"),
        "connect": MessageLookupByLibrary.simpleMessage("连接"),
        "disconnect": MessageLookupByLibrary.simpleMessage("断开"),
        "down": MessageLookupByLibrary.simpleMessage("下"),
        "elevation": MessageLookupByLibrary.simpleMessage("仰角"),
        "inputRequired": MessageLookupByLibrary.simpleMessage("请输入"),
        "left": MessageLookupByLibrary.simpleMessage("左"),
        "port": MessageLookupByLibrary.simpleMessage("端口"),
        "reset": MessageLookupByLibrary.simpleMessage("重置"),
        "right": MessageLookupByLibrary.simpleMessage("右"),
        "serialPortLists": MessageLookupByLibrary.simpleMessage("串口:"),
        "setZero": MessageLookupByLibrary.simpleMessage("设置零点"),
        "start": MessageLookupByLibrary.simpleMessage("启动"),
        "startTracking": MessageLookupByLibrary.simpleMessage("开始追踪"),
        "stop": MessageLookupByLibrary.simpleMessage("停止"),
        "stopTracking": MessageLookupByLibrary.simpleMessage("停止追踪"),
        "up": MessageLookupByLibrary.simpleMessage("上"),
        "useCorrectPort":
            MessageLookupByLibrary.simpleMessage("端口号是介于1024和65535之间的数字")
      };
}
