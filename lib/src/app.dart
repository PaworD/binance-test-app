import 'package:binance_test_task/src/resources/binance_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './widgets/tickers.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BinanceApi>(
      create: (c) => BinanceApi(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Titillium",
          backgroundColor: Color(0xff212630),
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          body: TickersList(),
        ),
      )
    );
  }
}
