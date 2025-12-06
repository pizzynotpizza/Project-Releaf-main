// lib/services/user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserIfNotExists(User firebaseUser) async {
    final userRef = _db.collection('users').doc(firebaseUser.uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      await userRef.set({
        'email': firebaseUser.email,
        'displayName': firebaseUser.displayName ?? '',
        'photoUrl': firebaseUser.photoURL ?? '',
        'ecoCoinBalance': 0,
        'totalScans': 0,
        'totalDrops': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    } else {
      await userRef.update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<AppUser?> streamUser(String uid) {
    final userRef = _db.collection('users').doc(uid);
    return userRef.snapshots().map((doc) {
      if (!doc.exists) return null;
      return AppUser.fromMap(doc.id, doc.data()!);
    });
  }

  Future<AppUser?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.id, doc.data()!);
  }
}
