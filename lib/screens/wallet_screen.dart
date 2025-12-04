import 'package:flutter/material.dart';
import '../services/mock_api.dart';

typedef ExchangeCallback = void Function(int delta);

class WalletScreen extends StatefulWidget {
  final ExchangeCallback? onExchange;
  const WalletScreen({super.key, this.onExchange});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int balance = 120; // ตัวอย่าง
  final TextEditingController _amountCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _exchange() {
    final val = int.tryParse(_amountCtrl.text) ?? 0;
    if (val <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('กรุณาใส่จำนวนที่ถูกต้อง')));
      return;
    }

    showDialog<void>(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));
    MockApi.exchangeEcoCoin(userId: 'user-1', amount: val).then((res) {
      Navigator.pop(context);
      if (res['status'] == 'ok') {
        setState(() => balance = res['remaining'] as int);
        widget.onExchange?.call(-val);
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('แลก EcoCoin สำเร็จ'),
            content: Text('คุณได้แลก $val EcoCoin แล้ว'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ปิด'))],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? 'ข้อผิดพลาด')));
      }
    }).catchError((_) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('เกิดข้อผิดพลาดในการแลก')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แลก EcoCoin'), backgroundColor: const Color(0xFF4CAF50)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ยอดคงเหลือ: $balance EcoCoin', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'จำนวน EcoCoin ที่ต้องการแลก', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              ),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _exchange, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)), child: const Text('แลก')),
              const SizedBox(height: 20),
              const Text('ตัวอย่างช่องทางแลก', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Card(child: ListTile(title: const Text('คูปองร้านค้า'), subtitle: const Text('แลก 100 EcoCoin ได้คูปอง 50 บาท'))),
              Card(child: ListTile(title: const Text('พืช/ต้นไม้'), subtitle: const Text('แลกเพื่อรับต้นไม้ฟรี (ต้องมีคะแนนสะสม)'))),
            ],
          ),
        ),
      ),
    );
  }
}
