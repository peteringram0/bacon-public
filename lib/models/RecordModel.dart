import 'package:cloud_firestore/cloud_firestore.dart';

class RecordModel {
  final String id;
  final String url;

  RecordModel({this.id, this.url});

  factory RecordModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return RecordModel(
      id: doc.documentID,
      url: data['url'] ?? '',
    );
  }

  factory RecordModel.initialData() {
    return RecordModel(id: '', url: '');
  }
}
