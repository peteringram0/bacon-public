import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../../theme.dart';
import './../../utils/FadeIn.dart';
import './../../models/index.dart';
import './../../services/Api.dart';
import './../../components/setCard/CardInner.dart';

import './components/index.dart';

class Set extends StatelessWidget {
  final int num;
  final String text;
  final String documentId;

  const Set({Key key, this.num, this.text, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Hero(
        tag: "card$num",
        child: Card(
          margin: const EdgeInsets.all(0.0),
          shape: AppTheme.cardShape,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SetsItemList(documentId: this.documentId, text: text),
        ),
      ),
    ]);
  }
}

class SetsItemList extends StatelessWidget {
  final String documentId;
  final String text;
//  final GlobalKey<SubmitButtonState> _submitButtonState =
//      GlobalKey<SubmitButtonState>();

  SetsItemList({@required this.documentId, this.text});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<SetItemModel>>.value(
          value: api.streamSetItems(this.documentId),
          initialData: [],
        ),
      ],
      child: Column(
        children: <Widget>[
          CardInner(
            text: text,
            displayBack: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27.0, right: 27.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: FadeIn(
                    1,
//                    PointsCount(submitButtonState: _submitButtonState),
                    PointsCount(),
                  ),
                ),
//                FadeIn(
//                  1,
//                  new SubmitButton(key: _submitButtonState, setId: documentId),
//                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: FadeIn(
                1.5,
                SetsInner(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SetsInner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _setItems = Provider.of<List<SetItemModel>>(context);

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
//      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: _setItems.length,
      itemBuilder: (BuildContext context, int index) {
        return new RecordItem(setData: _setItems[index]);
      },
    );
  }
}
