import 'package:web_socket_channel/io.dart';

class BinanceApi {
  IOWebSocketChannel tickersChannel() {
    print('tickersChannel')     ;
    final channel = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/!miniTicker@arr',
    );
    return channel;
  }
}
