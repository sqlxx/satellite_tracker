import 'dart:io';

import 'package:satellite_tracker/models/tcp_server_model.dart';

class TcpServer {
  final TcpServerModel _serverModel;
  ServerSocket? _serverSocket;

  TcpServer(this._serverModel);

  Future<void> start() async {
    _serverSocket ??= await ServerSocket.bind(InternetAddress.anyIPv4, _serverModel.port);
    if (_serverSocket == null) {
      _serverModel.serving = false;
      _serverModel.statusText = "Listening failed";
    } else {
      _serverModel.statusText = 'Listening on ${_serverSocket!.address.address}:${_serverModel.port}';
      _serverModel.serving = true;
      _serverSocket!.listen(_onConnect);
    }
  }

  _onConnect(Socket client) {
    _serverModel.statusText = 'Connected from ${client.remoteAddress.address}:${client.remotePort}';
  }

  Future<void> stop() async {
    await _serverSocket?.close();
    _serverSocket = null;
  }
}