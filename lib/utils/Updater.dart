import './../services/Api.dart';
import './../utils/Auth.dart';
import './../store/Store.dart';
import 'package:firebase_auth/firebase_auth.dart';

// When the user logs in or reloads this class is responsible for keeping
// our local store updated with the users answered questions
class Updater {
  Stream _authStream = authService.user;
  Stream _recordsStream;

  // Listen for changes on the user stream
  Updater() {

    _authStream.listen((user) {
      if (user.runtimeType == FirebaseUser) {
        _loadRecords(user.uid);
      }
    });

//    api.streamReviewSets().listen((data) {
//      final allRecords = data.toList();
//      store.dispatch(AllReviewSetsAction(allRecords));
//    });

  }

  // Load all records to firebase into our store
  void _loadRecords(String userId) async {
    this._recordsStream = api.getRecords();

    this._recordsStream.listen((data) {
      final allRecords = data.toList();
      store.dispatch(AllRecordsAction(allRecords));
    });
  }

}
