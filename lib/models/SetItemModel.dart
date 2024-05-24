import 'package:cloud_firestore/cloud_firestore.dart';

class SetItemModel {
  final String id;
  final String text;
  final String vietnamese;
  final String vietnameseAudio;

  SetItemModel({this.id, this.text, this.vietnamese, this.vietnameseAudio});

  factory SetItemModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return SetItemModel(
      id: doc.documentID,
      text: data['text'] ?? '',
      vietnamese: data['vietnamese'] ?? '',
      vietnameseAudio: data['vietnameseAudio'] ?? '',
    );
  }

  factory SetItemModel.initialData() {
    return SetItemModel(id: '', text: '', vietnamese: '', vietnameseAudio: '');
  }
}
