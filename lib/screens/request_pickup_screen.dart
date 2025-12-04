import 'package:flutter/material.dart';
import '../services/mock_api.dart';
import '../widgets/placeholder_map.dart';
import 'saleng_selection_screen.dart';

class RequestPickupScreen extends StatefulWidget {
  const RequestPickupScreen({super.key});

  @override
  State<RequestPickupScreen> createState() => _RequestPickupScreenState();
}

class _RequestPickupScreenState extends State<RequestPickupScreen> {
  bool _isLoading = false;

  void _handleRequestPickup() async {
    setState(() => _isLoading = true);
    try {
      final res = await MockApi.requestPickup(userId: 'user-1');
      setState(() => _isLoading = false);
      if (mounted && res['status'] == 'ok') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SaLengSelectionScreen(jobId: res['jobId']),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาด')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final mapHeight = screenHeight * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('เรียกรถซาเล้ง'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // แผนที่ 40%
            Container(
              height: mapHeight,
              child: PlaceholderMap(label: 'ตำแหน่งของคุณ'),
            ),
            // เนื้อหา 60%
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'พร้อมเรียกรถซาเล้งหรือ?',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'เรียกรถเพื่อมารับขยะที่บ้านคุณ',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleRequestPickup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(color: Colors.white),
                            )
                          : const Text('เรียกรถซาเล้ง', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
