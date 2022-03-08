import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/services/tcp_server.dart';

import '../models/app_model.dart';

BuildContext? _buildContext;

BuildContext get context => _buildContext!;
bool get hasContext => _buildContext != null;

// Must call setContext first
void setContext(BuildContext buildContext) {
  _buildContext = buildContext;
}

class BaseCommand {

  T getProvided<T>() {
    assert(hasContext, "You must call setContext first");
    return _buildContext!.read();
  }

  TcpServer get tcpServer => getProvided();
  AppModel get appModel => getProvided();
}

