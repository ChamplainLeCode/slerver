library slerver;

import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:get_ip/get_ip.dart';

import 'SlerverRouter.dart';


/// This class is used to create and manage our servers. As interfaces, it offers the possibility to create a server by the `createServer` method, also the possibility to access the router of this server in order to define the resources available and offered via the `router` getter. To find out the network interface of the smartphone, you will have to use the `getIP` getter.
class Slerver {

  /// Map of servers registered where keys are formatted as ip:port
  final Map<String, ServerSocket> serverSockets = {};
  /// Instance of logger see also [Logger]{https://pub.dev/packages/logger}
  final Logger l = Logger(printer: PrettyPrinter(methodCount: 0, errorMethodCount: 8, lineLength: 120, colors: true, printEmojis: true, printTime: false));
  
  final StreamController<Map<Symbol, Object>> _dataStream = StreamController();
  /// Create Slerver instance from ip address and server port
  factory Slerver(String address, int port) => Slerver._internal(address, port);

  Slerver._internal(String address, int port)
      : assert(address != null && port != null) {
    _initServer(address, port);
  }

  Slerver._empty();

  /// Get new instance of router attached to this Slerver instance
  SlerverRouter get router => SlerverRouter(this);

  /// Static way to create instance of Slerver, can be use many times with differents (ip,port)
  static Future<Slerver> createServer(String address, int port) async {
    assert(address != null && port != null);
    return await Slerver._empty()._initServer(address, port);
  }


  Future<Slerver> _initServer(String address, int port) async {
    String serverCode = Slerver.hashAddress(address, port);
    ServerSocket serv;
    if (!serverSockets.containsKey(serverCode))
      serverSockets[serverCode] = serv = await ServerSocket.bind(address, port);
    else
      serv = serverSockets[serverCode];
    l.d('Server start at ${serv.address.host} port ${serv.port} ');
    return this;
  }

  /// Get the internal ip address of ths phone
  Future<String> get getIP => GetIp.ipAddress;

  /// Get StreamController use as data input stream of this server
  StreamController<Map<Symbol, Object>> get controller => _dataStream;

  /// Because this Slerver can register many Server, this is a way to
  /// to get specific server ip address and port number
  ServerSocket getServer([String address, int port]) {
    if (address == null || port == null) {
      if (serverSockets.length > 0) {
        return serverSockets.entries.map((entry) => entry.value).first;
      }
      return null;
    }
    return serverSockets[Slerver.hashAddress(address, port)];
  }

  /// Function used to close specific
  void close([String address, int port]) {
    ServerSocket server = getServer(address, port);
    // server?.forEach((cli) {
    //   cli.close();
    //   cli.destroy();
    // });
    server?.close();
    _dataStream?.close();
  }

  /// Function used to codify server ip address and port
  static String hashAddress(String address, int port) {
    assert(address != null && port != null, 'Address or port cannot be null');
    return '$address:$port';
  }
}
