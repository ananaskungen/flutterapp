import 'package:flutter/material.dart';
import 'home.dart';
import 'play.dart';
import 'leaderboard.dart';
import 'shop.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/play': (context) => PlayScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/shop': (context) => ShopScreen(),
      },
    );
  }
}