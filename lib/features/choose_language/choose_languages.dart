import 'package:flutter/material.dart';

class ChooseLanguages extends StatelessWidget {
  const ChooseLanguages({super.key});

  @override
  Widget build(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Test Dialog'),
        content: Text('This is a test dialog'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ColoredBox(color: Colors.black),
    );
  }
}
