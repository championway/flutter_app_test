import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      }
    });
  }

  void stopTimer(){
    timer?.cancel();
  }

  void resetTimer(){
    setState(() {
      seconds = maxSeconds;
    });
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimer(),
          const SizedBox(
            height: 80,
          ),
          buildStartButtons(),
          buildPauseButtons(),
          buildResetButtons()
        ],
      )),
    );
  }

  Widget buildStartButtons() {
    return ElevatedButton(
      onPressed: () {
        startTimer();
      },
      child: Text("Start"),
    );
  }

  Widget buildPauseButtons() {
    return ElevatedButton(
      onPressed: () {
        stopTimer();
      },
      child: Text("Pause"),
    );
  }

  Widget buildResetButtons() {
    return ElevatedButton(
      onPressed: () {
        resetTimer();
      },
      child: Text("Reset"),
    );
  }

  Widget buildTime() {
    return Text(
      "$seconds",
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 80),
    );
  }

  Widget buildTimer(){
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
            strokeWidth: 12,
            backgroundColor: Colors.grey,
          ),
          Center(
            child: buildTime(),
          )
        ],
      ),
    );
  }
}
