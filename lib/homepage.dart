import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timer/setting.dart';
import 'package:timer/timer.dart';
import 'package:timer/timer_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    final CountDownTimer timer = CountDownTimer();
    timer.stratWork();
    const String _title = 'Timer';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _title,
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (value) {
              if (value == 'Setting') {
                toGoSetting(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        // final double availableWidth = constraints.maxWidth;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.black,
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      timer.stratWork();
                    },
                    child: const Text(
                      'Work',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.black,
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      timer.startBreak(true);
                    },
                    child: const Text(
                      'Short Break',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: Colors.black,
                      minimumSize: const Size(100, 50),
                    ),
                    onPressed: () {
                      timer.startBreak(false);
                    },
                    child: const Text(
                      'Long Break',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder(
              initialData: 0.0,
              stream: timer.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                TimerModel timer = (snapshot.data == '00:00')
                    ? TimerModel('00:00', 1)
                    : snapshot.data;
                return Expanded(
                  flex: 5,
                  child: CircularPercentIndicator(
                    radius: 150.0,
                    animation: true,
                    animationDuration: 900,
                    addAutomaticKeepAlive: true,
                    lineWidth: 25.0,
                    // ignore: unnecessary_null_comparison
                    percent: (timer.percent == null) ? 1 : timer.percent,
                    center: Text(
                      // ignore: unnecessary_null_comparison
                      (timer.time == null) ? '00:00' : timer.time,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 40.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,

                    backgroundColor: Colors.black,
                    progressColor: Colors.blue,
                  ),
                );
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          elevation: 0.0,
                          minimumSize: const Size(130, 50),
                        ),
                        onPressed: () {
                          timer.stopTimer();
                        },
                        child: const Text(
                          'Stop',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          primary: Colors.black,
                          minimumSize: const Size(130, 50),
                        ),
                        onPressed: () {
                          timer.startTimer();
                        },
                        child: const Text(
                          'Restart',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void toGoSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }
}
