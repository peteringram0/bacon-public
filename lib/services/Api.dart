import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:io';
import './../models/index.dart';
import './../utils/Auth.dart';

class Api {
  final Firestore _db = Firestore.instance;

  // Stream sets
  Stream<List<SetModel>> streamSets() {
    var ref = _db.collection('sets').where('active', isEqualTo: true);
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => SetModel.fromFirestore(doc)).toList());
  }

  // Stream set items
  Stream<List<SetItemModel>> streamSetItems(String documentId) {
    var ref = _db.collection('sets').document(documentId).collection('items');
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => SetItemModel.fromFirestore(doc)).toList());
  }

  // Stream records (users recordings)
  Stream<List<RecordModel>> getRecords() {
    var ref = _db
        .collection('users')
        .document(authService.localUser.uid)
        .collection('records');
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => RecordModel.fromFirestore(doc)).toList());
  }

  // Write data
  Future<void> createRecord(String recordId, String url) {
    var ref = _db
        .collection('users')
        .document(authService.localUser.uid)
        .collection('records');
    return ref.document(recordId).setData({"url": url});
  }

  // Write data
  Future<void> deleteRecord(String recordId) async {

    var userId = authService.localUser.uid;

    var ref = _db
        .collection('users')
        .document(authService.localUser.uid)
        .collection('records');
    var res = await ref.document(recordId).delete();

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('records/$userId/$recordId.mp4');
    storageReference.delete();

    return res;
  }

  // Upload file
  Future<String> uploadFile(String filePath, String recordId) async {

    var userId = authService.localUser.uid;

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('records/$userId/$recordId.mp4');

    final File _file = File.fromUri(Uri.parse(filePath));

    StorageUploadTask uploadTask = storageReference.putFile(_file);

    await uploadTask.onComplete;

    final url = await storageReference.getDownloadURL();

    return url;
  }

//  // Write data
//  Future<void> createReviewSet(String setId) {
//    var ref = _db
//        .collection('users')
//        .document(authService.localUser.uid)
//        .collection('sets');
//    return ref.document(setId).setData({'reviewed': false});
//  }
//
//  // Stream records (users recordings)
//  Stream<List<ReviewSetModel>> streamReviewSets() {
//    var ref = _db
//        .collection('users')
//        .document(authService.localUser.uid)
//        .collection('sets');
//    return ref.snapshots().map((list) =>
//        list.documents.map((doc) => ReviewSetModel.fromFirestore(doc)).toList());
//  }

}

final Api api = Api();
