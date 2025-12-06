// lib/services/eco_coin_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class EcoCoinService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEcoCoins({
    required String uid,
    required int amount,
    required String reason,
    String? relatedScanId,
    String? relatedDropPointId,
  }) async {
    final userRef = _db.collection('users').doc(uid);
    final txRef = userRef.collection('eco_transactions').doc();

    await _db.runTransaction((transaction) async {
      final userSnapshot = await transaction.get(userRef);
      final currentBalance =
          (userSnapshot.data()?['ecoCoinBalance'] ?? 0) as int;
      final newBalance = currentBalance + amount;

      transaction.update(userRef, {
        'ecoCoinBalance': newBalance,
      });

      transaction.set(txRef, {
        'type': amount >= 0 ? 'earn' : 'spend',
        'amount': amount,
        'reason': reason,
        'relatedScanId': relatedScanId,
        'relatedDropPointId': relatedDropPointId,
        'createdAt': FieldValue.serverTimestamp(),
        'balanceAfter': newBalance,
      });
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ecoTransactionsStream(
      String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('eco_transactions')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
