import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет для форматирования даты

final splashPageBackColor = Colors.green[900];
const mainColorDark = Color.fromARGB(255, 9, 42, 0);
const mainColorLight = Color.fromARGB(255, 0, 139, 69);
const widgetBackColor = Color.fromARGB(255, 27, 58, 36);
const iconColor = Color.fromARGB(255, 251, 205, 1);

const appIcon = Icons.attach_money;

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

class MoneyApp extends StatefulWidget {
  const MoneyApp({super.key});

  @override
  _MoneyAppState createState() => _MoneyAppState();
}

class _MoneyAppState extends State<MoneyApp> {
  final List<Map<String, dynamic>> _expenses = [];
  double _totalExpenses = 0.0;
  double _totalMoney = 10000.0;

  void _addExpense(String title, double amount) {
    setState(() {
      _expenses.add({'title': title, 'amount': amount});
      _totalExpenses += amount;
      _totalMoney -= amount;
    });
  }

  void _showAddExpenseDialog() {
    String title = '';
    String amount = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Добавить расход'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Название'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Сумма'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && amount.isNotEmpty) {
                  _addExpense(title, double.parse(amount));
                }
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('d MMMM').format(DateTime.now());

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTotal(totalMoney: _totalMoney),
          AppTodayExpenses(
            expenses: _expenses,
            totalExpenses: _totalExpenses,
            currentDate: currentDate,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        backgroundColor: mainColorLight,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AppTotal extends StatelessWidget {
  final double totalMoney;

  const AppTotal({super.key, required this.totalMoney});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 500,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: widgetBackColor),
          child: Text(
            "Итого: ${totalMoney.toStringAsFixed(2)} ₽",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          )),
    );
  }
}

class AppTodayExpenses extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;
  final double totalExpenses;
  final String currentDate;

  const AppTodayExpenses({super.key, required this.expenses, required this.totalExpenses, required this.currentDate});

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
              Text(
                "Сегодня, $currentDate",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    decorationThickness: 1.5),
              ),
              const SizedBox(height: 10),
              ...expenses.map((expense) {
                return ListTile(
                  title: Text(
                    "${expense['title']} - ${expense['amount']} ₽",
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              const SizedBox(height: 10),
              Text(
                "Сумма всех расходов: ${totalExpenses.toStringAsFixed(2)} ₽",
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
