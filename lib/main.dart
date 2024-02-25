import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF2D28D3),
        scaffoldBackgroundColor: Color(0xFFE7E1D1),
      ),
      home: PriceScreen(),
    );
  }
}

//Color(0xFF303030)
// Color(0xFFF44835)
// Color(0xFF2D28D3)
