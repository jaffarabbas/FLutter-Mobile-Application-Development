import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextEditingController player1 = TextEditingController();
  // TextEditingController player2 = TextEditingController();
  double player1value = 0.0;
  double player2value = 0.0;
  double increment = 0.4;
  String won = "";
  @override
  Widget build(BuildContext context) {
    void update(double value, double value2) {
      setState(() {
        if (player1value < 1.0 && player2value < 1.0) {
          player1value += value;
          player2value += value2;
        }
      });
    }

    void startRace() async {
      setState(() async {
        while (player1value <= 1.0 && player2value <= 1.0) {
          await Future.delayed(Duration(milliseconds: 200));
          double player1score = Random().nextDouble() * increment;
          double player2score = Random().nextDouble() * increment;
          update(player1score, player2score);
        }
        if (player1value > 1.0) {
          player1value = 1.0;
        } else if (player2value > 1.0) {
          player2value = 1.0;
        }
        if (player1value > player2value) {
          won = "Player 1 Won";
        } else {
          won = "Player 2 Won";
        }
      });
    }

    void reset() {
      setState(() {
        player1value = 0.0;
        player2value = 0.0;
        won = "";
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Race App'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Run a Race',
                style: TextStyle(fontSize: 30),
              ),
              won != ""
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
              Text(
                won,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.all(20),
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Player 1',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    LinearBar(vlaue: player1value),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60),
                width: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '${(player1value * 100).toStringAsFixed(2)}%',
                      '${(player1value).toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.all(20),
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Player 2',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    LinearBar(vlaue: player2value),
                    // Container(
                    //   width: 250,
                    //   child: LinearProgressIndicator(
                    //     value: player2value, // a value between 0 and 1
                    //     backgroundColor: Colors.grey,
                    //     minHeight: 30,
                    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    //   ),
                    //
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60),
                width: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '${((player2value * 100).toStringAsFixed(2))}%',
                      '${((player2value).toStringAsFixed(2))}%',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // startRace();
                          //  setState(() {
                          startRace();
                          //  Timer.periodic(Duration(seconds: 1), (timer) => startRace());
                          //  });
                        },
                        child: Text('Start'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          reset();
                        },
                        child: Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinearBar extends StatelessWidget {
  double vlaue;
  LinearBar({super.key, required this.vlaue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: LinearProgressIndicator(
        value: vlaue, // a value between 0 and 1
        backgroundColor: Colors.grey,
        minHeight: 30,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}
