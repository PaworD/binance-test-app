import 'dart:async';
import 'package:web_socket_channel/io.dart';
import '../models/ticker_model.dart';

class BinanceApiProvider {
  IOWebSocketChannel subscribeToTickers() {
    final channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/!miniTicker@arr');
    return channel;
  }
}
