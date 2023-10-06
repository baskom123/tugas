import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Contoh02 extends StatefulWidget {
  const Contoh02({super.key});

  @override
  State<Contoh02> createState() => _contoh2State();
}

class _contoh2State extends State<Contoh02> {
  bool isReset = false;
  bool isPlay = false;
  bool isPaused = false;
  bool isSubscribed = false;
  String desc = "";
  int percent = 100;
  int getSteam = 0;
  double circular = 1;
  late StreamSubscription _sub;
  final Stream _myStream =
      Stream.periodic(const Duration(seconds: 1), (int count) {
    return count;
  });

  String isFull(inp) {
    if (inp == 100) {
      desc = "\nFull";
    } else if (inp == 0) {
      desc = "\nEmpty";
    } else {
      desc = "";
    }
    return desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          // final double avaWidth = constraints.maxWidth;
          final double avaHeight = constraints.maxHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      percent = 100;
                      circular = percent / 100;
                      isPaused = true;
                      print(isPaused);
                    });
                  },
                  child: Text("Reset")),
              Expanded(
                  child: CircularPercentIndicator(
                header: Text(isFull(percent)),
                radius: avaHeight / 5,
                lineWidth: 10,
                percent: circular,
                center: Text("$percent%"),
              ))
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isPlay = !isPlay;
            print(isPaused);
          });

          if (isPlay) {
            if (!isSubscribed) {
              isSubscribed = true;
              _sub = _myStream.listen((event) {
                getSteam = int.parse(event.toString());
                setState(() {
                  if (percent - getSteam <= 0) {
                    isSubscribed = false;
                    percent = 0;
                    circular = 0;
                  } else {
                    percent = percent - getSteam;
                    circular = percent / 100;
                  }
                });
              });
            } else {
              isPaused = true;
              _sub.resume();
            }
          } else {
            isPaused = false;
            _sub.pause();
          }
        },
        child: !isPlay ? Icon(Icons.play_arrow) : Icon(Icons.pause),
      ),
    );
  }
}
