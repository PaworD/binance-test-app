part of 'binance_cubit.dart';

class BinanceState extends Equatable {
  final List<TickerModel> tickers;
  final String error;

  BinanceState({this.tickers, this.error});

  BinanceState.initial()
      : tickers = null,
        error = null;

  BinanceState copyWith({
    List<TickerModel> tickers,
    String error,
  }) {
    return BinanceState(
      tickers: tickers ?? this.tickers,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [tickers, error];
}
