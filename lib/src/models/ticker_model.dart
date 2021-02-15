class TickerModel {
  String _tickerName;
  var _currentValue;
  var _difference;
  var _volume;

  TickerModel.fromJson(dynamic parsedJson) {
    _tickerName = parsedJson['s'];
    _currentValue = parsedJson['c'];
    _difference = parsedJson['o'];
    _volume = parsedJson['q'];
  }

  String get tickerName => _tickerName;

  dynamic get currentValue => _currentValue;

  dynamic get difference => _difference;

  dynamic get volume => _volume;
}
