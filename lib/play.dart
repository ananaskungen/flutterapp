import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;


class PlayScreen extends StatefulWidget {
  @override
  _PlayScreenState createState() => _PlayScreenState();
}
class _PlayScreenState extends State<PlayScreen> {
  int score = 0;
  int consecutiveMisses = 0;
  bool dotVisible = false;
  final ImageProvider redDotImage = AssetImage('assets/reddot.png');
  Timer? gameTimer;
  Timer? hideTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    hideTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    gameTimer = Timer(Duration(seconds: Random().nextInt(3) + 1), () {
      if (mounted) {
        setState(() {
          dotVisible = true;
        });
        hideTimer = Timer(Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              if (dotVisible) {
                consecutiveMisses++;
              }
              dotVisible = false;
              if (score == 0 || consecutiveMisses >= 2) {
                goToHomePage();
              } else {
                startGame();
              }
            });
          }
        });
      }
    });
  }

  void incrementScore() {
    setState(() {
      score++;
      consecutiveMisses = 0;
    });
  }

  void goToHomePage() {
    Navigator.pop(context);
  }

  void onTapScreen() {
    if (!dotVisible) {
      goToHomePage();
    }
  }

  void onTapDot() {
    if (dotVisible) {
      incrementScore();
      hideTimer?.cancel();
      setState(() {
        dotVisible = false;
      });
      startGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play'),
      ),
      body: GestureDetector(
        onTap: onTapScreen,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: onTapDot,
                child: Container(
                  width: 100,
                  height: 100,
                  child: dotVisible ? Image(image: redDotImage) : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
