import 'package:satellite_tracker/_utils/easy_notifier.dart';

class TcpServerModel extends EasyNotifier {
  int _port = 8090;
  bool _serving = false;
  String _statusText = '';

  set port(value) {
    notify(() => _port = value);
  }

  get port => _port;

  set serving(value) {
    notify(() => _serving = value);
  }

  get serving => _serving;

  set statusText(value) {
    notify(() => _statusText = value);
  }

  get statusText => _statusText;
}
