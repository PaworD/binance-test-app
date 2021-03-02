import 'package:flutter/cupertino.dart';

import '../models/ticker_model.dart';
import '../resources/binance_api_provider.dart';

import 'dart:convert';

@deprecated
class BinanceBloc {
  BinanceApi binanceApiProvider = BinanceApi();

  Stream get getTickers => connection();

  Stream connection() {
    final stream = binanceApiProvider.tickersChannel().stream.map((event) {
      return jsonDecode(event);
    });

    return stream;
  }

  List<TickerModel> tickersList(AsyncSnapshot snapshot) {
    List<TickerModel> tickersList = List<TickerModel>();
    final btc =
        snapshot.data.where((element) => element['s'] == "BTCUSDT").toList();
    final eth =
        snapshot.data.where((element) => element['s'] == "ETHUSDT").toList();
    final xrp =
        snapshot.data.where((element) => element['s'] == "XRPUSDT").toList();
    final bnb =
        snapshot.data.where((element) => element['s'] == "BNBUSDT").toList();

    // If more tickers required it's better to write helper function which return ticker model from given list.
    // As long as required tickers are 4 , I went with this approach

    // P.S Also loop through Map type List to add this tickers and map() them to convert to TickerModel

    var btcTicker = TickerModel.fromJson(btc[0]);
    var ethTicker = TickerModel.fromJson(eth[0]);
    var xrpTicker = TickerModel.fromJson(xrp[0]);
    var bnbTicker = TickerModel.fromJson(bnb[0]);

    tickersList.addAll([btcTicker, ethTicker, xrpTicker, bnbTicker]);

    return tickersList;
  }

  void dispose() {
    binanceApiProvider.tickersChannel().sink.close();
  }
}

final bloc = BinanceBloc();
