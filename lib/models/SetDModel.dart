import 'package:cloud_firestore/cloud_firestore.dart';

class SetModel {
  final String id;
  final String text;
  final String vietnamese;

  SetModel({this.id, this.text, this.vietnamese});

  factory SetModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return SetModel(
      id: doc.documentID,
      text: data['text'] ?? '',
      vietnamese: data['vietnamese'] ?? '',
    );
  }

  factory SetModel.initialData() {
    return SetModel(id: '', text: '', vietnamese: '');
  }
}
