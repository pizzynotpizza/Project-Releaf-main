import 'dart:async';

class SaLeng {
  final String id;
  final double latitude;
  final double longitude;
  final String driver;
  final double rating;

  SaLeng({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.driver,
    required this.rating,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'latitude': latitude,
    'longitude': longitude,
    'driver': driver,
    'rating': rating,
  };
}

class MockApi {
  // ตำแหน่งผู้ใช้ตัวอย่าง (กรุงเทพ)
  static const double userLat = 13.7563;
  static const double userLng = 100.5018;

  // เรียกดูซาเล้งทั้งหมด
  static Future<Map<String, dynamic>> getAvailableSaLengs() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final salengs = [
      SaLeng(id: 'SALENG-001', latitude: 13.7500, longitude: 100.5050, driver: 'สมชาย ใจดี', rating: 4.8),
      SaLeng(id: 'SALENG-002', latitude: 13.7600, longitude: 100.4900, driver: 'กมล บ้านสวน', rating: 4.5),
      SaLeng(id: 'SALENG-003', latitude: 13.7400, longitude: 100.5100, driver: 'ประยุทธ ขยันเรียน', rating: 4.9),
      SaLeng(id: 'SALENG-004', latitude: 13.7550, longitude: 100.5200, driver: 'สายรุ่ง ส่งของ', rating: 4.6),
    ];
    return {'status': 'ok', 'salengs': salengs.map((s) => s.toMap()).toList()};
  }

  // เลือกซาเล้ง
  static Future<Map<String, dynamic>> selectSaLeng({required String userId, required String salengId}) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'status': 'ok',
      'jobId': 'PICKUP-${DateTime.now().millisecondsSinceEpoch}',
      'salengId': salengId,
    };
  }

  // ติดตามรถซาเล้ง (ตำแหน่งเรียลไทม์จำลอง)
  static Future<Map<String, dynamic>> trackSaLeng({required String jobId, required String salengId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // จำลองการเคลื่อนไหว (ค่อยๆ เข้าใกล้ผู้ใช้)
    final elapsed = DateTime.now().millisecond % 1000;
    final progress = elapsed / 1000.0;
    return {
      'status': 'ok',
      'jobId': jobId,
      'salengId': salengId,
      'latitude': userLat + (13.7500 - userLat) * progress,
      'longitude': userLng + (100.5050 - userLng) * progress,
      'eta_minutes': max(1, 15 - (progress * 15).toInt()),
    };
  }

  // จำลองเรียกซาเล้ง: รอ 2 วินาที แล้วส่งผลสำเร็จ
  static Future<Map<String, dynamic>> requestPickup({required String userId}) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'status': 'ok',
      'jobId': 'PICKUP-${DateTime.now().millisecondsSinceEpoch}',
      'eta_minutes': 25,
    };
  }

  // ดึงข้อมูลผู้ใช้ตัวอย่าง
  static Future<Map<String, dynamic>> getProfile({required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return {
      'id': userId,
      'name': 'ผู้ใช้ ตัวอย่าง',
      'email': 'user@example.com',
      'address': '123/45 ถนนต้นไม้ เขตเมือง',
      'lastPickup': '2025-11-30',
    };
  }

  // แลก EcoCoin: ตรวจสอบและคืนยอดใหม่ (จำลอง)
  static Future<Map<String, dynamic>> exchangeEcoCoin({required String userId, required int amount}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (amount <= 0) {
      return {'status': 'error', 'message': 'จำนวนไม่ถูกต้อง'};
    }
    // ใน mock นี้ สมมติผู้ใช้มี 120 ตามตัวอย่าง
    final remaining = 120 - amount;
    if (remaining < 0) {
      return {'status': 'error', 'message': 'ยอดไม่พอ'};
    }
    return {'status': 'ok', 'remaining': remaining, 'exchanged': amount};
  }

  // สแกนซาเล้ง: คืน id ของซาเล้งที่สแกน
  static Future<Map<String, dynamic>> scanSaLeng({required String qrData}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return {'status': 'ok', 'salengId': qrData, 'accepted': true};
  }
}

int max(int a, int b) => a > b ? a : b;
