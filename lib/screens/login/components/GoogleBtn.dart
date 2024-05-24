import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './../../../theme.dart';

class GoogleBtn extends StatelessWidget {
  final Function onPressed;

  GoogleBtn({@required this.onPressed}) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 35.0,
      onPressed: onPressed,
      color: AppTheme.colorGoogleBlue,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 2,
          maxHeight: 50.0,
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: const Icon(
                  FontAwesomeIcons.google,
                  color: AppTheme.colorWhite,
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign in with Google',
                    style: AppTheme.standardText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
