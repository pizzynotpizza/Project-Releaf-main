import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool shareStatsWithFriends = true;
  bool shareAnonymousData = true;
  bool personalizedTips = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppBar(
        title: const Text('ความเป็นส่วนตัว'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const Text(
              'ควบคุมการแชร์ข้อมูลของคุณใน ReLeaf',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('แชร์สถิติกับเพื่อน'),
              subtitle: const Text('ให้เพื่อนเห็นสถิติจำนวนขยะที่คุณรีไซเคิลได้'),
              value: shareStatsWithFriends,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => shareStatsWithFriends = v),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('ยินยอมให้ใช้ข้อมูลแบบไม่ระบุตัวตน'),
              subtitle: const Text('ช่วยให้เราพัฒนาระบบรีไซเคิลให้ดีขึ้น'),
              value: shareAnonymousData,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => shareAnonymousData = v),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('รับคำแนะนำส่วนบุคคล'),
              subtitle: const Text('ใช้ประวัติการทิ้งขยะเพื่อแนะนำคำแนะนำที่เหมาะกับคุณ'),
              value: personalizedTips,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => personalizedTips = v),
            ),
            const SizedBox(height: 24),
            const Text(
              'ตอนนี้เป็นการตั้งค่าจำลอง\nในเวอร์ชันจริงจะมีลิงก์ไปยังนโยบายความเป็นส่วนตัวฉบับเต็ม',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
