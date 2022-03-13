import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:satellite_tracker/commands/socket_client_connection_command.dart';
import 'package:satellite_tracker/commands/socket_client_error_command.dart';
import 'package:satellite_tracker/commands/socket_data_received_command.dart';

class TcpServer {
  ServerSocket? _serverSocket;
  Socket? _client;

  Future<ServerSocket?> start(int port) async {
    _serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    if (_serverSocket != null) {
      _serverSocket!.listen(_onConnect);
    }
    return _serverSocket;
  }

  _onConnect(Socket client) {
    if (_client == null) {
      _client = client;
      SocketClientConnectionCommand().run(client, true);
      client.listen((Uint8List event) {
        SocketDataReceivedCommand().run(event);
      }, onDone: () {
        SocketClientConnectionCommand().run(client, false);
        _client = null;
      }, onError: (Object error, StackTrace stackTrace) {
        SocketClientErrorCommand().run(error, stackTrace);
      });
    } else {
      client.close();
      debugPrint("Only allow one connection");
    }
  }

  Future<void> stop() async {
    await _serverSocket?.close();
    if (_client != null) {
      await _client!.close();
    }
    _serverSocket = null;
    _client = null;
    debugPrint("Tcp Server stopped");
  }
}
