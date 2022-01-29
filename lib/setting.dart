import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer/widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

TextEditingController txtWork = TextEditingController();
TextEditingController txtShort = TextEditingController();
TextEditingController txtLong = TextEditingController();

class _SettingScreenState extends State<SettingScreen> {
  // ignore: constant_identifier_names

  final TextStyle textStyle =
      const TextStyle(fontSize: 28, fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TextEditingController txtWork = TextEditingController();
    // TextEditingController txtShort = TextEditingController();
    // TextEditingController txtLong = TextEditingController();
    // txtWork;
    // txtShort;
    // txtLong;
    readSettings();
    super.initState();
  }

  // ignore: constant_identifier_names
  static const String WORKTIME = "workTime";
  // ignore: constant_identifier_names
  static const String LONGBREAK = "longBreak";
  // ignore: constant_identifier_names
  static const String SHORTBREAK = "shortBreak";
  int? longBreak;
  int? shortBreak;
  int? workTime;
  late SharedPreferences prefs;
  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        int? workTime = prefs.getInt(WORKTIME);
        if (workTime != null) {
          workTime += value;
        }
        if (workTime! >= 1 && workTime <= 180) {
          prefs.setInt(WORKTIME, workTime);
          setState(() {
            txtWork.text = workTime.toString();
          });
        }
        break;
      case SHORTBREAK:
        int? short = prefs.getInt(SHORTBREAK);
        if (short != null) {
          short += value;
        }
        if (short! >= 1 && short <= 120) {
          prefs.setInt(SHORTBREAK, short);
          setState(() {
            txtShort.text = short.toString();
          });
        }
        break;
      case LONGBREAK:
        int? long = prefs.getInt(LONGBREAK);
        if (long != null) {
          long += value;
        }
        if (long! >= 1 && long <= 180) {
          prefs.setInt(SHORTBREAK, long);
          setState(() {
            txtLong.text = long.toString();
          });
        }
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        elevation: 0.0,
        title: const Text(
          'Add Timer',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        // centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 150),
          child: GridView.count(
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20),
            children: [
              Text("Work", style: textStyle),
              const Text(""),
              const Text(""),
              SettingsButton(
                  const Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
              TextField(
                  controller: txtWork,
                  style: textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(
                  const Color(0xff009688), '+', 1, LONGBREAK, updateSetting),
              Text("Short", style: textStyle),
              const Text(""),
              const Text(""),
              SettingsButton(
                  const Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
              TextField(
                  controller: txtShort,
                  style: textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(
                const Color(0xff009688),
                "+",
                1,
                SHORTBREAK,
                updateSetting,
              ),
              Text(
                "Long",
                style: textStyle,
              ),
              const Text(""),
              const Text(""),
              SettingsButton(
                  const Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
              TextField(
                  controller: txtLong,
                  style: textStyle,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number),
              SettingsButton(
                  const Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
            ],
          ),
        ),
      ),
    );
  }
}
