import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:satellite_tracker/models/rotator_model.dart';
import 'package:satellite_tracker/models/tcp_server_model.dart';
import 'package:satellite_tracker/services/serial_service.dart';
import 'package:satellite_tracker/services/tcp_server.dart';
import 'package:satellite_tracker/views/rotator_config_form.dart';
import 'package:satellite_tracker/views/rotator_control_panel.dart';
import 'package:satellite_tracker/views/tcp_server_form.dart';
import "package:satellite_tracker/commands/commands.dart" as commands;

import 'generated/l10n.dart';
import 'views/tcp_server_form.dart';

void main() {
  RotatorModel rotatorModel = RotatorModel();
  TcpServerModel tcpServerModel = TcpServerModel();
  TcpServer tcpServer = TcpServer();
  SerialService serialService = SerialService();

  runApp(MultiProvider(providers: [
    Provider.value(value: tcpServer),
    Provider.value(value: serialService),
    ChangeNotifierProvider.value(value: rotatorModel),
    ChangeNotifierProvider.value(value: tcpServerModel),
  ], child: const SatelliteTrackerApp()));
}

class SatelliteTrackerApp extends StatelessWidget {
  const SatelliteTrackerApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    commands.setContext(context);
    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              TcpServerForm(),
              SizedBox(height: 20),
              RotatorConfigForm(),
              SizedBox(height: 50),
              RotatorControlPanel()
            ],
          ),
        ),
      ),
    );
  }
}
