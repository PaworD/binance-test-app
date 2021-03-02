import 'package:binance_test_task/src/blocs/binance_cubit.dart';
import 'package:binance_test_task/src/resources/binance_api_provider.dart';
import 'package:binance_test_task/src/widgets/ticker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TickersList extends StatefulWidget {
  @override
  _TickersListState createState() => _TickersListState();
}

class _TickersListState extends State<TickersList> {
  var _search = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BinanceCubit>(
      create: (context) => BinanceCubit(
        api: context.read<BinanceApi>(),
      )..onScreenCreated(),
      child: BlocBuilder<BinanceCubit, BinanceState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Container(
                      child: TextField(
                        autocorrect: true,
                        maxLines: 1,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(.2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          hintText: 'Search coin pairs',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(.2),
                          ),
                          filled: true,
                          fillColor: Color(0xff29303D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) => setState(() => _search = v),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _tickersList(state),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tickersList(BinanceState state) {
    print('_tickersList - ${state.tickers}');
    if (state.tickers != null && state.tickers.isNotEmpty) {
      print('here');
      final tickers = _search.isEmpty
          ? state.tickers
          : state.tickers.where(
              (t) => t.tickerName.toLowerCase().contains(_search),
            );
      return Column(
        children: [
          for (var t in tickers)
            Ticker(
              difference: t.difference,
              tickerName: t.tickerName,
              value: t.currentValue,
              volume: t.volume,
            )
        ],
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
