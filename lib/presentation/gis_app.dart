import 'package:flutter/material.dart';
import 'package:gold_india_stocks/common/constants.dart';
import 'package:gold_india_stocks/presentation/deals_tab_view.dart';

class GISApp extends StatefulWidget {
  const GISApp({Key? key}) : super(key: key);

  @override
  _GISAppState createState() => _GISAppState();
}

class _GISAppState extends State<GISApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DealsTabView(),
      theme: ThemeData(
        textTheme: const TextTheme(
          caption: TextStyle(
            color: Constants.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyText1: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          subtitle1: TextStyle(
            color: Constants.green,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          subtitle2: TextStyle(
            color: Constants.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
