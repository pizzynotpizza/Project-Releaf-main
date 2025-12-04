import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../services/mock_api.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  String? lastScan;
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleBarcode(String code) async {
    if (_isProcessing) return;
    _isProcessing = true;
    _controller.stop();

    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
    try {
      final res = await MockApi.scanSaLeng(qrData: code);
      Navigator.pop(context); // close loading
      if (res['status'] == 'ok') {
        setState(() => lastScan = res['salengId'] as String);
        await showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('สแกนสำเร็จ'),
            content: Text('สแกน QR ของซาเล้งเรียบร้อย: ${res['salengId']}'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ปิด'))],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('สแกนล้มเหลว')));
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาดในการสแกน')));
    }

    _isProcessing = false;
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สแกน QR ซาเล้ง'), backgroundColor: const Color(0xFF4CAF50)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      MobileScanner(
                        controller: _controller,
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isEmpty) return;
                          final String? raw = barcodes.first.rawValue;
                          if (raw != null) _handleBarcode(raw);
                        },
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.flash_on, color: Colors.white),
                              onPressed: () => _controller.toggleTorch(),
                            ),
                            IconButton(
                              icon: const Icon(Icons.cameraswitch, color: Colors.white),
                              onPressed: () => _controller.switchCamera(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ชี้กล้องไปที่ QR โค้ดของซาเล้งเพื่อสแกน', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    if (lastScan != null) Text('ล่าสุด: $lastScan', style: const TextStyle(color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
