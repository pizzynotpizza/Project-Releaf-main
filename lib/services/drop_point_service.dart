// lib/services/drop_point_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class DropPoint {
  final String id;
  final String name;
  final String description;
  final double lat;
  final double lng;
  final List<String> typesAccepted;

  DropPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.lat,
    required this.lng,
    required this.typesAccepted,
  });

  factory DropPoint.fromMap(String id, Map<String, dynamic> data) {
    return DropPoint(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      typesAccepted: List<String>.from(data['typesAccepted'] ?? []),
    );
  }
}

class DropPointService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<DropPoint>> streamDropPoints() {
    return _db.collection('drop_points').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => DropPoint.fromMap(doc.id, doc.data()))
          .toList();
    });
  }
}
