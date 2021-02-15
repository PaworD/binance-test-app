import 'package:flutter/material.dart';

class Ticker extends StatelessWidget {
  final tickerName;
  final volume;
  final value;
  final difference;

  Ticker({
    this.tickerName,
    this.volume,
    this.value,
    this.difference,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = ((double.parse(value) - double.parse(difference)) /
        double.parse(difference) *
        100);
    return Container(
      padding: EdgeInsets.all(20),
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(tickerName.toString().substring(0, 3),
                            style: TextStyle(
                              fontSize: 22,
                            )),
                        Text("/ " + tickerName.toString().substring(3),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffffffff).withOpacity(.4),
                            )),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Vol " + double.parse(volume).toStringAsFixed(2) + "M",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffffffff).withOpacity(.4),
                      ),
                    )
                  ],
                )),
              ),
              Expanded(
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      double.parse(value)
                          .toString()
                          .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), ""),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 0.2,
                        color: double.parse(value) > double.parse(difference)
                            ? Color(0xff2DBD85)
                            : Color(0xffE44358),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      double.parse(difference)
                              .toString()
                              .replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "") +
                          ' \$',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: Color(0xffffffff).withOpacity(.4),
                      ),
                    )
                  ],
                )),
              )
            ]),
          ),
          Container(
              margin: EdgeInsets.all(5),
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: percentage.isNegative
                    ? Color(0xffE44358)
                    : Color(0xff2DBD85),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                  child: Text(
                percentage.toStringAsFixed(2) + "%",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )))
        ],
      ),
    );
  }
}
