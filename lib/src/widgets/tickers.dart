import 'package:binance_test_task/src/models/ticker_model.dart';
import 'package:binance_test_task/src/widgets/ticker.dart';
import 'package:flutter/material.dart';
import '../blocs/binance_bloc.dart';
import 'dart:convert';

class TickersList extends StatefulWidget {
  @override
  _TickersListState createState() => _TickersListState();
}

class _TickersListState extends State<TickersList> {
  TextEditingController _searchController = new TextEditingController();
  List<TickerModel> _searches = [];
  List<TickerModel> _tickers = [];

  @override
  void didChangeDependencies() {
    bloc.getTickers;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  onSearchBegin(String search) async {
    _searches.clear();
    if (search.isEmpty) {
      setState(() {});
      return;
    }

    _tickers.forEach((ticker) {
      if (ticker.tickerName.toLowerCase().contains(search)) {
        _searches.add(ticker);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                child: TextField(
                  controller: _searchController,
                  autocorrect: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.search, color: Colors.white.withOpacity(.2)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    hintText: 'Search coin pairs',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(.2)),
                    filled: true,
                    fillColor: Color(0xff29303D),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: onSearchBegin,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  initialData: [],
                  stream: bloc.getTickers,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      _tickers = bloc.tickersList(snapshot);
                      return SingleChildScrollView(
                        child: _searches.length != 0
                            ? Ticker(
                                difference: _searches[0].difference,
                                tickerName: _searches[0].tickerName,
                                value: _searches[0].currentValue,
                                volume: _searches[0].volume,
                              )
                            : Column(
                                children: _tickers.map((ticker) {
                                return Ticker(
                                  difference: ticker.difference,
                                  tickerName: ticker.tickerName,
                                  value: ticker.currentValue,
                                  volume: ticker.volume,
                                );
                              }).toList()),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(snapshot.error.toString());
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
