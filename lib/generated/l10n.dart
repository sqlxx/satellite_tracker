// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Satellite Tracker`
  String get appName {
    return Intl.message(
      'Satellite Tracker',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Port`
  String get port {
    return Intl.message(
      'Port',
      name: 'port',
      desc: '',
      args: [],
    );
  }

  /// `Please input`
  String get inputRequired {
    return Intl.message(
      'Please input',
      name: 'inputRequired',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Port number should between 1024 & 65535`
  String get useCorrectPort {
    return Intl.message(
      'Port number should between 1024 & 65535',
      name: 'useCorrectPort',
      desc: '',
      args: [],
    );
  }

  /// `Serial Ports`
  String get serialPortLists {
    return Intl.message(
      'Serial Ports',
      name: 'serialPortLists',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Start Tracking`
  String get startTracking {
    return Intl.message(
      'Start Tracking',
      name: 'startTracking',
      desc: '',
      args: [],
    );
  }

  /// `Stop Tracking`
  String get stopTracking {
    return Intl.message(
      'Stop Tracking',
      name: 'stopTracking',
      desc: '',
      args: [],
    );
  }

  /// `Azimuth`
  String get azimuth {
    return Intl.message(
      'Azimuth',
      name: 'azimuth',
      desc: '',
      args: [],
    );
  }

  /// `Elevation`
  String get elevation {
    return Intl.message(
      'Elevation',
      name: 'elevation',
      desc: '',
      args: [],
    );
  }

  /// `Set Zero`
  String get setZero {
    return Intl.message(
      'Set Zero',
      name: 'setZero',
      desc: '',
      args: [],
    );
  }

  /// `Calibrate`
  String get calibrate {
    return Intl.message(
      'Calibrate',
      name: 'calibrate',
      desc: '',
      args: [],
    );
  }

  /// `Up`
  String get up {
    return Intl.message(
      'Up',
      name: 'up',
      desc: '',
      args: [],
    );
  }

  /// `Down`
  String get down {
    return Intl.message(
      'Down',
      name: 'down',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get left {
    return Intl.message(
      'Left',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get right {
    return Intl.message(
      'Right',
      name: 'right',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Begin`
  String get begin {
    return Intl.message(
      'Begin',
      name: 'begin',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Horizontal Speed`
  String get horizontalSpeed {
    return Intl.message(
      'Horizontal Speed',
      name: 'horizontalSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Horizontal Reset`
  String get horizontalReset {
    return Intl.message(
      'Horizontal Reset',
      name: 'horizontalReset',
      desc: '',
      args: [],
    );
  }

  /// `Vertical Speed`
  String get verticalSpeed {
    return Intl.message(
      'Vertical Speed',
      name: 'verticalSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Vertical Reset`
  String get verticalReset {
    return Intl.message(
      'Vertical Reset',
      name: 'verticalReset',
      desc: '',
      args: [],
    );
  }

  /// `Azimuth Range`
  String get azimuthRange {
    return Intl.message(
      'Azimuth Range',
      name: 'azimuthRange',
      desc: '',
      args: [],
    );
  }

  /// `Elevation Range`
  String get elevationRange {
    return Intl.message(
      'Elevation Range',
      name: 'elevationRange',
      desc: '',
      args: [],
    );
  }

  /// `Start Calibrate`
  String get startCalibrate {
    return Intl.message(
      'Start Calibrate',
      name: 'startCalibrate',
      desc: '',
      args: [],
    );
  }

  /// `Status: `
  String get status {
    return Intl.message(
      'Status: ',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Out of Range`
  String get outOfRange {
    return Intl.message(
      'Out of Range',
      name: 'outOfRange',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Value`
  String get invalidValue {
    return Intl.message(
      'Invalid Value',
      name: 'invalidValue',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in`
  String get fillIn {
    return Intl.message(
      'Please fill in',
      name: 'fillIn',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
