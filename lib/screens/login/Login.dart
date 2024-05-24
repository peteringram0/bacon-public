import './../../utils/Auth.dart';
import 'package:flutter/material.dart';
import './../../theme.dart';
import './components/index.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBlue,
      body: Center(
        child: GoogleBtn(
          onPressed: () async {
            await authService.googleSignIn();
            return true;
//            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
