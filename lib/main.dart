import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/disconnected_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CLIMA',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const LoadingScreen(),
        routes: {
          '/first': (context) => const LoadingScreen(),
          '/retry': (context) => const Disconnected(),
        });
  }
}
