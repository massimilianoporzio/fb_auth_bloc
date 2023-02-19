import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            'Oooops\nTry again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
