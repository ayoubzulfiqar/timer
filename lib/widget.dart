import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const ProductivityButton(
      {required this.color,
      required this.text,
      required this.onPressed,
      required this.size,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      color: color,
      // ignore: unnecessary_null_comparison
      minWidth: (size != null) ? size : 0,
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;
  final String setting;
  final CallbackSetting callback;
  const SettingsButton(
      this.color, this.text, this.value, this.setting, this.callback,
      {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0.0,
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 25)),
      onPressed: () => callback(setting, value),
      color: color,
    );
  }
}
