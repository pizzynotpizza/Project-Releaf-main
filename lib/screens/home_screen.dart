import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'wallet_screen.dart';
import 'scan_screen.dart';
import 'request_pickup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int ecoCoinBalance = 120; // ตัวอย่างยอดเงิน

  void _requestPickup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RequestPickupScreen()),
    );
  }

  Widget _buildMenuCard({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: color ?? Colors.green.shade100, child: Icon(icon, color: Colors.green.shade800)),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        title: const Text('ReLeaf'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text('สวัสดี, ผู้ใช้', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // EcoCoin Display
            Container(
              height: 120,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green.shade400, Colors.green.shade600],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, size: 44, color: Colors.white),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$ecoCoinBalance', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      const Text('EcoCoin', style: TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Menu grid fills remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.05,
                  children: [
                    _buildMenuCard(
                      icon: Icons.local_shipping_outlined,
                      title: 'เรียกรถซาเล้ง',
                      color: Colors.orange.shade100,
                      onTap: _requestPickup,
                    ),
                    _buildMenuCard(
                      icon: Icons.account_box_outlined,
                      title: 'ข้อมูลผู้ใช้',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
                    ),
                    _buildMenuCard(
                      icon: Icons.monetization_on_outlined,
                      title: 'แลก EcoCoin',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WalletScreen(onExchange: (delta) {
                        setState(() {
                          ecoCoinBalance += delta;
                        });
                      }))),
                    ),
                    _buildMenuCard(
                      icon: Icons.qr_code_scanner,
                      title: 'สแกน QR ซาเล้ง',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen())),
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
