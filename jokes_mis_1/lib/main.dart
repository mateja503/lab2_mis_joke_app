import 'package:flutter/material.dart';
import 'package:jokes_mis/screens/home.dart';
import 'package:jokes_mis/screens/jokes_type_list.dart';
import 'package:jokes_mis/screens/random_joke.dart';
import 'package:jokes_mis/widgets/type_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/details': (context) => JokeTypeList(),
        '/random': (context) => const RandomJoke(),
      },
    );
  }
}
