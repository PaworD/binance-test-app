import 'package:binance_test_task/src/models/ticker_model.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  TextEditingController _searchController = new TextEditingController();

  List<TickerModel> _searches = [];
  List<TickerModel> _tickers = [];

  List<TickerModel> get tickers => [..._tickers];
  List<TickerModel> get searches => [..._searches];

  set tickers(List<TickerModel> tickers) {
    _tickers = tickers;
  }

  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  Future onSearchBegin(String search) async {
    widget.searches.clear();
    if (search.isEmpty) {
      return;
    }

    widget.tickers.forEach((ticker) {
      if (ticker.tickerName.toLowerCase().contains(search)) {
        widget._searches.add(ticker);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._searchController,
      autocorrect: true,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(.2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        hintText: 'Search coin pairs',
        hintStyle: TextStyle(color: Colors.white.withOpacity(.2)),
        filled: true,
        fillColor: Color(0xff29303D),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide.none),
      ),
      onChanged: onSearchBegin,
    );
  }
}
