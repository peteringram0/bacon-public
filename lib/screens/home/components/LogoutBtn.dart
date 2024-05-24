import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './../../../theme.dart';

class LogoutBtn extends StatelessWidget {
  final Function onPressed;

  LogoutBtn({@required this.onPressed}) : assert(onPressed != null);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(),
      padding: const EdgeInsets.all(5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      child: const Icon(
        FontAwesomeIcons.signOutAlt,
        color: AppTheme.colorWhite,
        size: 19,
      ),
    );
  }
}
