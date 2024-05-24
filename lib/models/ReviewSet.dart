import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewSetModel {
  final String id;
  final bool reviewed;

  ReviewSetModel({this.id, this.reviewed});

  factory ReviewSetModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return ReviewSetModel(
      id: doc.documentID,
      reviewed: data['reviewed'] ?? false,
    );
  }

  factory ReviewSetModel.initialData() {
    return ReviewSetModel(reviewed: false);
  }
}
