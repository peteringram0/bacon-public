import 'package:flutter/material.dart';
import './../../screens/set/Set.dart';
import './../../theme.dart';
import './../../models/index.dart';
import './CardInner.dart';

class SetCard extends StatelessWidget {
  final int num;
  final SetModel setData;

  const SetCard({Key key, this.num, this.setData}) : super(key: key);

  // Clickable area over the top of the card
  Widget _clickArea(BuildContext context) {
    return Positioned(
      left: 0.0,
      top: 0.0,
      bottom: 0.0,
      right: 0.0,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                // transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => new Set(
                  num: this.num,
                  text: this.setData.text,
                  documentId: this.setData.id,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "card$num",
      child: Card(
        shape: AppTheme.cardShape,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            CardInner(
              text: this.setData.text,
              displayBack: false,
            ),
            _clickArea(context)
          ],
        ),
      ),
    );
  }
}
