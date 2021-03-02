class TickerModel {
  String _tickerName;
  double _currentValue;
  double _difference;
  double _volume;

  TickerModel.fromJson(dynamic parsedJson) {
    _tickerName = parsedJson['s'];
    _currentValue = double.tryParse(parsedJson['c']) ?? 0.0;
    _difference = double.tryParse(parsedJson['o']) ?? 0.0;
    _volume = double.tryParse(parsedJson['q']) ?? 0.0;
  }

  String get tickerName => _tickerName;

  double get currentValue => _currentValue;

  double get difference => _difference;

  double get volume => _volume;
}
