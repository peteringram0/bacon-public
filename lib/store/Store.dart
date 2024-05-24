import 'package:redux/redux.dart';
import './../models/index.dart';

// Store actions
class AllRecordsAction {
  final List<RecordModel> records;

  AllRecordsAction(this.records);
}

//// Store actions
//class AllReviewSetsAction {
//  final List<ReviewSetModel> reviewSets;
//
//  AllReviewSetsAction(this.reviewSets);
//}

// STATE
class AppState {
  List<RecordModel> _records;
//  List<ReviewSetModel> _reviewSets;

  int get counter => _records.length;

  List<RecordModel> get records => _records;

  int getCountOfSet(List<SetItemModel> records) {
    int _count = 0;
    records.forEach((i) {
      var _item = _records.singleWhere((o) => o.id == i.id, orElse: () => null);
      if (_item != null) {
        _count++;
      }
    });
    return _count;
  }

  RecordModel getById(String id) {
    if (id != '' && _records.length > 0) {
      return _records.firstWhere((record) => record.id == id);
    } else {
      return throw ('no records');
    }
  }

//  ReviewSetModel getReviewSetById(String id) {
//    if (id != '' && _reviewSets.length > 0) {
//      return _reviewSets.firstWhere((record) => record.id == id);
//    } else {
//      return throw ('no records');
//    }
//  }

//  AppState(this._records, this._reviewSets);
  AppState(this._records);
}

// REDUCER
AppState reducer(AppState prev, dynamic action) {
  switch (action.runtimeType) {
    case AllRecordsAction:
      return new AppState(action.records);
//      return new AppState(action.records, prev._reviewSets);
      break;
//    case AllReviewSetsAction:
//      return new AppState(prev.records, action.reviewSets);
//      break;
  }

  return prev;
}

// STORE
final store = Store<AppState>(
  reducer,
  initialState: new AppState(
    new List(),
//    new List(),
  ),
);
