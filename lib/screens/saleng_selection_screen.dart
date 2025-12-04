import 'package:flutter/material.dart';
import '../services/mock_api.dart';
import '../widgets/placeholder_map.dart';
import 'tracking_screen.dart';

class SaLengSelectionScreen extends StatefulWidget {
  final String jobId;
  const SaLengSelectionScreen({super.key, required this.jobId});

  @override
  State<SaLengSelectionScreen> createState() => _SaLengSelectionScreenState();
}

class _SaLengSelectionScreenState extends State<SaLengSelectionScreen> {
  late Future<List<Map<String, dynamic>>> _salengs;
  String? _selectedSaLengId;

  @override
  void initState() {
    super.initState();
    _salengs = _loadSaLengs();
  }

  Future<List<Map<String, dynamic>>> _loadSaLengs() async {
    final res = await MockApi.getAvailableSaLengs();
    if (res['status'] == 'ok') {
      return List<Map<String, dynamic>>.from(res['salengs'] ?? []);
    }
    return [];
  }

  void _handleSelectSaLeng(String salengId) async {
    setState(() => _selectedSaLengId = salengId);
    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
    try {
      final res = await MockApi.selectSaLeng(userId: 'user-1', salengId: salengId);
      Navigator.pop(context); // close loading
      if (mounted && res['status'] == 'ok') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TrackingScreen(jobId: res['jobId'], salengId: salengId),
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาด')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapHeight = screenHeight * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('เลือกรถซาเล้ง'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // แผนที่ 40%
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _salengs,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: mapHeight,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return Container(
                  height: mapHeight,
                  child: PlaceholderMap(label: 'เลือกซาเล้ง'),
                );
              },
            ),
            // รายการซาเล้ง 60%
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _salengs,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final salengs = snapshot.data ?? [];
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: salengs.length,
                    itemBuilder: (context, index) {
                      final s = salengs[index];
                      final isSelected = _selectedSaLengId == s['id'];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        color: isSelected ? Colors.green.shade50 : Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: const Icon(Icons.directions_car, color: Colors.green),
                          ),
                          title: Text(s['driver'], style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text('${s['rating']}'),
                            ],
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : null,
                          onTap: () => _handleSelectSaLeng(s['id']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
