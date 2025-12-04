import 'package:flutter/material.dart';
import '../services/mock_api.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? profile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() => loading = true);
    try {
      final res = await MockApi.getProfile(userId: 'user-1');
      setState(() {
        profile = res;
        loading = false;
      });
    } catch (_) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ไม่สามารถโหลดข้อมูลผู้ใช้ได้')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลผู้ใช้'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('${profile?['name']}\n${profile?['email']}', style: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: const Text('ที่อยู่'),
                        subtitle: Text('${profile?['address'] ?? '-'}'),
                        trailing: TextButton(onPressed: () {}, child: const Text('แก้ไข')),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.history_outlined),
                        title: const Text('ประวัติการเรียกซาเล้ง'),
                        subtitle: Text('เรียกเมื่อ ${profile?['lastPickup'] ?? '-'}'),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('กลับ'),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
