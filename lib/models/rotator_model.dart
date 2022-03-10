import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:satellite_tracker/_utils/easy_notifier.dart';

class RotatorModel extends EasyNotifier {
  List<SerialPort> _availableSerialPorts = [];
  SerialPort? _connectedSerialPort;

  int _rotatorAddr = 1;
  int _baudRate = 1200;

  double _currentAzimuth = 5;
  double _currentElevation = 15;
  bool _tracking = false;

  int _horizontalSpeed = 1; //ms per degree
  int _verticalSpeed = 1; //ms per degree

  set availableSerialPorts(List<SerialPort> value) {
    notify(() => _availableSerialPorts = value);
  }

  List<SerialPort> get availableSerialPorts => _availableSerialPorts;

  set connectedSerialPort(SerialPort? value) {
    notify(() => _connectedSerialPort = value);
  }

  SerialPort? get connectedSerialPort => _connectedSerialPort;

  set rotatorAddr(int value) {
    notify(() => _rotatorAddr = value);
  }

  int get rotatorAddr => _rotatorAddr;

  set currentAzimuth(double value) {
    notify(() => _currentAzimuth = value);
  }

  double get currentAzimuth => _currentAzimuth;

  set currentElevation(double value) {
    notify(() => _currentElevation = value);
  }

  double get currentElevation => _currentElevation;

  set baudRate(int value) {
    notify(() => _baudRate = value);
  }

  int get baudRate => _baudRate;

  set tracking(bool value) {
    notify(() => _tracking = value);
  }

  bool get tracking => _tracking;

  set verticalSpeed(value) {
    notify(() => _verticalSpeed = value);
  }

  int get verticalSpeed => _verticalSpeed;

  set horizontalSpeed(value) {
    notify(() => _horizontalSpeed = value);
  }

  int get horizontalSpeed => _horizontalSpeed;
}
