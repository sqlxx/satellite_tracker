import 'package:flutter/cupertino.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:satellite_tracker/_utils/easy_notifier.dart';
import 'package:satellite_tracker/views/calibration_form.dart';

class RotatorModel extends EasyNotifier {
  List<SerialPort> _availableSerialPorts = [];
  SerialPort? _connectedSerialPort;
  bool _moving = false;
  DateTime _moveStart = DateTime.now();

  int _rotatorAddr = 1;
  int _baudRate = 1200;

  double _currentAzimuth = 5;
  double _currentElevation = 15;

  int _azimuthBegin = 5;
  int _azimuthEnd = 355;

  int _elevationBegin = 15;
  int _elevationEnd = 85;

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

  bool get isConnected =>
      _connectedSerialPort != null && _connectedSerialPort!.isOpen;

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

  set verticalSpeed(int value) {
    notify(() => _verticalSpeed = value);
  }

  int get verticalSpeed => _verticalSpeed;

  set horizontalSpeed(int value) {
    notify(() => _horizontalSpeed = value);
  }

  int get horizontalSpeed => _horizontalSpeed;

  int get azimuthBegin => _azimuthBegin;
  int get azimuthEnd => _azimuthEnd;
  int get azimuthRange => _azimuthEnd - _azimuthBegin;

  int get elevationBegin => _elevationBegin;
  int get elevationEnd => _elevationEnd;
  int get elevationRange => _elevationEnd - _elevationBegin;

  set azimuthBegin(int value) {
    notify(() => _azimuthBegin = value);
  }

  set azimuthEnd(int value) {
    notify(() => _azimuthEnd = value);
  }

  set elevationBegin(int value) {
    notify(() => _elevationBegin = value);
  }

  set elevationEnd(int value) {
    notify(() => _elevationEnd = value);
  }

  bool get moving => _moving;
  set moving(bool value) {
    _moveStart = DateTime.now();
    notify(() => _moving = value);
  }

  DateTime get moveStartTime => _moveStart;

  void setCurrentAsOrigin() {
    currentAzimuth = azimuthBegin * 1.0;
    currentElevation = elevationBegin * 1.0;
    debugPrint("Azimuth $currentAzimuth, Elevation $currentElevation");
  }
}
