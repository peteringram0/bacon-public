import 'package:flutter/material.dart';
import './../../../utils/auth.dart';
import './../../../theme.dart';

class Name extends StatelessWidget {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  String name(String displayName) => capitalize(displayName.split(" ")[0]);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Hello, ' + name(snapshot.data.displayName),
              style: AppTheme.largeText,
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}
