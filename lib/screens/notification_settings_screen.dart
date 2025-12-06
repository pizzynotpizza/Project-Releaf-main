import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool missionNoti = true;
  bool rewardNoti = true;
  bool newsNoti = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppBar(
        title: const Text('การแจ้งเตือน'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const Text(
              'ตั้งค่าการแจ้งเตือนจาก ReLeaf',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('แจ้งเตือนภารกิจและ EcoCoin'),
              subtitle: const Text('แจ้งเมื่อภารกิจสำเร็จหรือได้รับคะแนน'),
              value: missionNoti,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => missionNoti = v),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('แจ้งเตือนเมื่อมีของรางวัลใหม่'),
              subtitle: const Text('โปรโมชั่น / ของรางวัล / ส่วนลดใหม่ ๆ'),
              value: rewardNoti,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => rewardNoti = v),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('แจ้งเตือนข่าวสารและอัปเดตแอป'),
              subtitle: const Text('ข่าวอัปเดตแอป ReLeaf และบทความสิ่งแวดล้อม'),
              value: newsNoti,
              activeColor: const Color(0xFF0F9D58),
              onChanged: (v) => setState(() => newsNoti = v),
            ),
            const SizedBox(height: 24),
            const Text(
              'ตอนนี้เป็นการตั้งค่าจำลอง\nในอนาคตจะเชื่อมกับระบบแจ้งเตือนจริง (Firebase Cloud Messaging)',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
