// lib/models/app_user.dart
class AppUser {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final int ecoCoinBalance;
  final int totalScans;
  final int totalDrops;

  AppUser({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.ecoCoinBalance = 0,
    this.totalScans = 0,
    this.totalDrops = 0,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> data) {
    return AppUser(
      uid: uid,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      ecoCoinBalance: (data['ecoCoinBalance'] ?? 0) as int,
      totalScans: (data['totalScans'] ?? 0) as int,
      totalDrops: (data['totalDrops'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'ecoCoinBalance': ecoCoinBalance,
      'totalScans': totalScans,
      'totalDrops': totalDrops,
    };
  }
}
