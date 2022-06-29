import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/screens/loading_screen.dart';

class Disconnected extends StatefulWidget {
  const Disconnected({Key? key}) : super(key: key);

  @override
  State<Disconnected> createState() => _DisconnectedState();
}

class _DisconnectedState extends State<Disconnected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Unable to load data',
              style: kRefreshTextStyle,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingScreen(),
                  ),
                );
              },
              child: Icon(
                color: kdefaultColor,
                Icons.refresh,
                size: 65,
              ),
            )
          ],
        ),
      ),
    );
  }
}
