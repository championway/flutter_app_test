import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  int showMinute = 0;
  int showSecond = 0;

  DateTime currentTime = DateTime.now();

  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void setUITime(){
    showMinute = seconds ~/ 60;
    showSecond = seconds - showMinute*60;
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds = maxSeconds - DateTime.now().difference(currentTime).inSeconds;
      print(seconds);
      if (seconds >= 0) {
        setState(() {
          setUITime();
        });
      }
      else{
        stopTimer();
      }

//      if (seconds > 0) {
//        setState(() {
//          seconds--;
//        });
//      }
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
//          buildPauseButtons(),
//          buildResetButtons(),
          buildGetTimeButtons()
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

  Widget buildGetTimeButtons() {
    return ElevatedButton(
      onPressed: () {
        currentTime = DateTime.now();
        print(currentTime);
      },
      child: Text("Get Time"),
    );
  }

  Widget buildTime() {
    return Text(
      "${showMinute.toString().padLeft(2, "0")} : ${showSecond.toString().padLeft(2, "0")}",
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
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
            value: seconds / maxSeconds,
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
