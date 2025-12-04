import 'package:flutter/material.dart';
import 'dart:async';
import '../services/mock_api.dart';
import '../widgets/placeholder_map.dart';

class TrackingScreen extends StatefulWidget {
  final String jobId;
  final String salengId;
  const TrackingScreen({super.key, required this.jobId, required this.salengId});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  double? _salengLat, _salengLng;
  int? _eta;
  Timer? _trackingTimer;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  void _startTracking() {
    _trackingTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
      final res = await MockApi.trackSaLeng(jobId: widget.jobId, salengId: widget.salengId);
      if (res['status'] == 'ok') {
        setState(() {
          _salengLat = res['latitude'];
          _salengLng = res['longitude'];
          _eta = res['eta_minutes'];
        });
        if (_salengLat != null) {
          setState(() {}); // Just update the UI
        }
      }
    });
  }

  @override
  void dispose() {
    _trackingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapHeight = screenHeight * 0.4;

    return WillPopScope(
      onWillPop: () async => false, // ป้องกันการกลับไป
      child: Scaffold(
        appBar: AppBar(
          title: const Text('กำลังติดตามรถซาเล้ง'),
          backgroundColor: const Color(0xFF4CAF50),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // แผนที่ 40%
              Container(
                height: mapHeight,
                child: PlaceholderMap(label: 'ติดตามรถซาเล้ง'),
              ),
              // ข้อมูลและสถานะ 60%
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        color: Colors.green.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('สถานะการเรียก', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.directions_car, color: Colors.green, size: 32),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('รถซาเล้งกำลังมุ่งหน้ามาหาคุณ', style: TextStyle(fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 4),
                                        Text(
                                          'ประมาณ ${_eta ?? '-'} นาที',
                                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('รายละเอียด', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: const Text('ตำแหน่งปัจจุบัน'),
                          subtitle: _salengLat != null
                              ? Text('${_salengLat?.toStringAsFixed(4)}, ${_salengLng?.toStringAsFixed(4)}')
                              : const Text('กำลังโหลด...'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.location_on),
                          title: const Text('ปลายทาง'),
                          subtitle: const Text('บ้านของคุณ'),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('ยกเลิกการเรียก?'),
                                content: const Text('คุณแน่ใจหรือว่าต้องการยกเลิก?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('ไม่')),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.popUntil(context, (route) => route.isFirst);
                                    },
                                    child: const Text('ยกเลิก'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text('ยกเลิกการเรียก', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
