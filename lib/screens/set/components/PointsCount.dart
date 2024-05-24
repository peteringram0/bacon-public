//import 'package:Bacon/screens/set/components/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';

import './../../../theme.dart';
import './../../../models/index.dart';
import './../../../store/Store.dart';

class PointsCount extends StatelessWidget {

//  final GlobalKey<SubmitButtonState> submitButtonState;

//  PointsCount({Key key, @required this.submitButtonState}) : super(key: key);
  PointsCount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _setItems = Provider.of<List<SetItemModel>>(context);

    if (_setItems.isNotEmpty) {
      return new StoreConnector<AppState, int>(
        converter: (store) {
          try {
            return store.state.getCountOfSet(_setItems);
          } catch (error) {
            return 0;
          }
        },
        builder: (context, int recordedCount) {

//          Future.delayed(const Duration(milliseconds: 50), () {
//            submitButtonState.currentState.setDisabled(recordedCount == _setItems.length ? false : true);
//          });

          return Text(
            recordedCount.toString() + '/' + _setItems.length.toString(),
            style: AppTheme.largeDarkText,
          );

        },
      );
    } else {
      return const Text('');
    }
  }
}