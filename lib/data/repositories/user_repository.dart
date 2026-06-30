import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

/// Persists user profiles in Firestore under `users/{uid}`.
class UserRepository {
  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  Future<void> upsert(UserModel user) async {
    await _users.doc(user.uid).set({
      ...user.toJson(),
      'updatedAt': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<UserModel?> fetch(String uid) async {
    final snap = await _users.doc(uid).get();
    final data = snap.data();
    if (data == null) return null;
    return UserModel.fromJson({...data, 'uid': uid});
  }
}
