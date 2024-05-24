import 'package:flutter/material.dart';
import './../../theme.dart';

class CardInner extends StatelessWidget {
  final String text;
  final bool displayBack;

  CardInner({@required this.text, @required this.displayBack});

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width,
      // height: 255.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0, bottom: 60.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            displayBack
                ? const Positioned(
                    child: IconTheme(
                        data: IconThemeData(color: AppTheme.colorGreen),
                        child: BackButton()),
                  )
                : const Text(''),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    child: Text(
                      (text.isEmpty) ? '' : capitalize(text),
                      style: AppTheme.cardText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
