import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String displayName;
  final String email;
  final Timestamp lastSeen;
  final String learning;

  User({this.id, this.displayName, this.email, this.lastSeen, this.learning});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return User(
      id: doc.documentID,
      displayName: data['displayName'],
      email: data['email'],
      lastSeen: data['lastSeen'],
      learning: data['learning'],
    );
  }

  factory User.initialData() {
    return User(id: '', displayName: '', email: '', lastSeen: Timestamp.now(), learning: '');
  }
}
