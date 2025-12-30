import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUser {
  String email;
  String uid;
  String userName;

  FirestoreUser({
    required this.email,
    required this.uid,
    required this.userName,
  });

  factory FirestoreUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return FirestoreUser(
      email: data['email'] as String? ?? '',
      uid: data['uid'] as String? ?? '',
      userName: data['username'] as String? ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirestoreUser &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          uid == other.uid &&
          userName == other.userName;

  @override
  int get hashCode => Object.hash(email, uid, userName);
}
