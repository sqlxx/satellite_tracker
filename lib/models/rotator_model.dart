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

  int _currentAzimuth = 5;
  int _currentElevation = 7;

  int _azimuthBegin = 5;
  int _azimuthEnd = 355;

  int _elevationBegin = 7;
  int _elevationEnd = 60;

  bool _tracking = false;

  int _horizontalSpeed = 72; //ms per degree
  int _verticalSpeed = 580; //ms per degree

  Timer? _timer;

  bool get moving => _moving;

  set availableSerialPorts(List<SerialPort> value) {
    notify(() => _availableSerialPorts = value);
  }

  bool get isMovingAzimuth => _movingDirection == RotatorAction.left || _movingDirection == RotatorAction.right;

  List<SerialPort> get availableSerialPorts => _availableSerialPorts;

  set connectedSerialPort(SerialPort? value) {
    notify(() => _connectedSerialPort = value);
  }

  SerialPort? get connectedSerialPort => _connectedSerialPort;

  bool get isConnected => _connectedSerialPort != null && _connectedSerialPort!.isOpen;

  set rotatorAddr(int value) {
    notify(() => _rotatorAddr = value);
  }

  int get rotatorAddr => _rotatorAddr;

  set currentAzimuth(int value) {
    if (value > azimuthEnd) {
      value = azimuthEnd;
    }

    if (value < azimuthBegin) {
      value = azimuthBegin;
    }

    notify(() => _currentAzimuth = value);
  }

  int get currentAzimuth => _currentAzimuth;

  set currentElevation(int value) {
    if (value > elevationEnd) {
      value = elevationEnd;
    }

    if (value < elevationBegin) {
      value = elevationBegin;
    }
    notify(() => _currentElevation = value);
  }

  int get currentElevation => _currentElevation;

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
      _timer = Timer.periodic(Duration(milliseconds: interval), _onChange);
    }
    notify(() => _moving = value);
  }

  DateTime get moveStartTime => _moveStart;

  void setAsOrigin() {
    _setMoving(false);
    currentAzimuth = azimuthBegin;
    currentElevation = elevationBegin;
    debugPrint("Azimuth $currentAzimuth, Elevation $currentElevation");
  }

  void _onChange(Timer timer) {
    switch (_movingDirection) {
      case RotatorAction.left:
        if (currentAzimuth > azimuthBegin) {
          currentAzimuth -= 1;
        } else {
          currentAzimuth = azimuthBegin;
          _setMoving(false);
        }
        break;
      case RotatorAction.right:
        if (currentAzimuth < azimuthEnd) {
          currentAzimuth += 1;
        } else {
          currentAzimuth = azimuthEnd;
          _setMoving(false);
        }
        break;
      case RotatorAction.up:
        if (currentElevation < elevationEnd) {
          currentElevation += 1;
        } else {
          currentElevation = elevationEnd;
          _setMoving(false);
        }
        break;
      case RotatorAction.down:
        if (currentElevation > elevationBegin) {
          currentElevation -= 1;
        } else {
          currentElevation = elevationBegin;
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
