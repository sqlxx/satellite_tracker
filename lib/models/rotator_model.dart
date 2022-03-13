import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:satellite_tracker/_utils/easy_notifier.dart';

import '../commands/rotate_pan_tilt_command.dart';

class RotatorModel extends EasyNotifier {
  List<SerialPort> _availableSerialPorts = [];
  SerialPort? _connectedSerialPort;
  bool _moving = false;
  late RotatorAction _movingDirection;
  DateTime _moveStart = DateTime.now();

  int _rotatorAddr = 1;
  int _baudRate = 2400; //Not used yet

  double _currentAzimuth = 5;
  double _currentElevation = 15;

  int _azimuthBegin = 5;
  int _azimuthEnd = 355;

  int _elevationBegin = 15;
  int _elevationEnd = 85;

  bool _tracking = false;

  int _horizontalSpeed = 1; //ms per degree
  int _verticalSpeed = 1; //ms per degree

  Timer? _timer;

  bool get moving => _moving;

  set availableSerialPorts(List<SerialPort> value) {
    notify(() => _availableSerialPorts = value);
  }

  bool get isMovingAzimuth =>
      _movingDirection == RotatorAction.left ||
      _movingDirection == RotatorAction.right;

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

  void _setMoving(bool value) {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }

    if (value) {
      _moveStart = DateTime.now();
      int interval = isMovingAzimuth ? horizontalSpeed : verticalSpeed;
      debugPrint("Start timer with $interval ms");
      _timer =
          Timer.periodic(Duration(microseconds: interval * 100), _onChange);
    }
    notify(() => _moving = value);
  }

  DateTime get moveStartTime => _moveStart;

  void setAsOrigin() {
    currentAzimuth = azimuthBegin * 1.0;
    currentElevation = elevationBegin * 1.0;
    debugPrint("Azimuth $currentAzimuth, Elevation $currentElevation");
  }

  void _onChange(Timer timer) {
    switch (_movingDirection) {
      case RotatorAction.left:
        if (currentAzimuth > azimuthBegin) {
          currentAzimuth -= 0.1;
        } else {
          _setMoving(false);
        }
        break;
      case RotatorAction.right:
        if (currentAzimuth < azimuthEnd) {
          currentAzimuth += 0.1;
        } else {
          _setMoving(false);
        }
        break;
      case RotatorAction.up:
        if (currentElevation < elevationEnd) {
          currentElevation += 0.1;
        } else {
          _setMoving(false);
        }
        break;
      case RotatorAction.down:
        if (currentElevation > elevationBegin) {
          currentElevation -= 0.1;
        } else {
          _setMoving(false);
        }
        break;
      default:
        debugPrint("Do noting");
    }
  }

  void setAction(RotatorAction direction) {
    switch (direction) {
      case RotatorAction.left:
      case RotatorAction.right:
      case RotatorAction.up:
      case RotatorAction.down:
        _movingDirection = direction;
        _setMoving(true);
        break;
      default:
        _setMoving(false);
    }
  }
}
