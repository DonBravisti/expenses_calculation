import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final splashPageBackColor = Colors.green[900];
const mainColorDark = Color.fromARGB(255, 9, 42, 0);
const mainColorLight = Color.fromARGB(255, 0, 139, 69);
const widgetBackColor = Color.fromARGB(255, 27, 58, 36);
const iconColor = Color.fromARGB(255, 251, 205, 1);

const appIcon = Icons.attach_money;

const totalMoney = "10 000";
const currentDate = "12 апреля";

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
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MoneyApp()));
    });

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

class MoneyApp extends StatelessWidget {
  const MoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorDark,
      appBar: AppBar(
        backgroundColor: mainColorLight,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 65, 63, 63)),
        title: const Center(
          child: Icon(
            appIcon,
            size: 40,
            color: iconColor,
          ),
        ),
        actions: const [
          SizedBox(
            width: 60,
            height: 40,
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
            padding: const EdgeInsets.all(30),
            color: mainColorLight,
            alignment: Alignment.bottomRight,
            child: const Icon(appIcon, color: iconColor, size: 80)),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [AppTotal(), AppTodayExpenses()],
      ),
    );
  }
}

class AppTotal extends StatelessWidget {
  const AppTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 500,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: widgetBackColor),
          child: const Text(
            "Итого: $totalMoney ₽",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          )),
    );
  }
}

class AppTodayExpenses extends StatelessWidget {
  const AppTodayExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 500,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: widgetBackColor),
          child: Column(
            children: [
              const Text(
                "Сегодня, $currentDate",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 1.5),
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                child: const Text(
                  "Сегодня расходов не было",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
