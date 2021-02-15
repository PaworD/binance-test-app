import 'package:flutter/material.dart';
import './widgets/tickers.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Titillium",
          backgroundColor: Color(0xff212630),
          brightness: Brightness.dark),
      home: Scaffold(body: TickersList()),
    );
  }
}
