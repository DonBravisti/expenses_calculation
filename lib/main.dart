import 'package:flutter/material.dart';

final splashPageBackColor = Colors.green[900];
const mainColorDark = Color.fromARGB(255, 9, 42, 0);
const mainColorLight = Color.fromARGB(255, 0, 139, 69);
const widgetBackColor = Color.fromARGB(255, 27, 58, 36);
const iconColor = Color.fromARGB(255, 251, 205, 1);

const appIcon = Icons.attach_money;

const totalMoney = "10 000";

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashPage(),
  ));
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 2), () {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => const MoneyApp()));
    // });

    return Container(
      color: splashPageBackColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 200),
              child: const Icon(
                appIcon,
                size: 100.0,
                color: iconColor,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: const CircularProgressIndicator())),
        ],
      ),
    );
  }
}

