import 'dart:async';
import 'dart:convert';

import 'package:binance_test_task/src/models/ticker_model.dart';
import 'package:binance_test_task/src/resources/binance_api_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'binance_state.dart';

class BinanceCubit extends Cubit<BinanceState> {
  final BinanceApi api;

  StreamSubscription _subscription;

  //
  BinanceCubit({this.api}) : super(BinanceState.initial());

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  onScreenCreated() {
    try {
      _subscription = api.tickersChannel().stream.listen((event) {
        emit(state.copyWith(
          tickers: tickersList(event),
        ));
      });
    } catch (e) {
      //l('onScreenCreated', e, stack);
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  List<TickerModel> tickersList(dynamic event) {
    final object = jsonDecode(event);

    final btc = (object as List).where((e) => e['s'] == "BTCUSDT").toList();
    final eth = (object as List).where((e) => e['s'] == "ETHUSDT").toList();
    final xrp = (object as List).where((e) => e['s'] == "XRPUSDT").toList();
    final bnb = (object as List).where((e) => e['s'] == "BNBUSDT").toList();

    return [
      if (btc.isNotEmpty) TickerModel.fromJson(btc[0]),
      if (eth.isNotEmpty) TickerModel.fromJson(eth[0]),
      if (xrp.isNotEmpty) TickerModel.fromJson(xrp[0]),
      if (bnb.isNotEmpty) TickerModel.fromJson(bnb[0])
    ];
  }
}
