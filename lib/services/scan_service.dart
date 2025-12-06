// lib/services/scan_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> saveScan({
    required String uid,
    required String wasteType,
    required double confidence,
    String? imageUrl,
    String? dropPointId,
    required int ecoCoinEarned,
  }) async {
    final scanRef =
        _db.collection('users').doc(uid).collection('scans').doc();

    await scanRef.set({
      'wasteType': wasteType,
      'confidence': confidence,
      'imageUrl': imageUrl,
      'dropPointId': dropPointId,
      'ecoCoinEarned': ecoCoinEarned,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // เพิ่มตัวนับจำนวนสแกน
    final userRef = _db.collection('users').doc(uid);
    await userRef.update({
      'totalScans': FieldValue.increment(1),
    });

    return scanRef.id;
  }
}
