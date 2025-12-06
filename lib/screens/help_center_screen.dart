import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqItems = [
      {
        'q': 'ทำไม EcoCoin ของฉันไม่เพิ่มทันที?',
        'a':
            'ในเวอร์ชันจริง คะแนนอาจใช้เวลาสักครู่ในการประมวลผล หลังจากสแกนขยะหรือทำภารกิจสำเร็จ',
      },
      {
        'q': 'ถ้าสแกนขยะแล้วประเภทไม่ถูกต้องควรทำอย่างไร?',
        'a':
            'คุณสามารถเลือกประเภทขยะด้วยตัวเอง และในอนาคตระบบ AI จะเรียนรู้ให้แม่นยำขึ้น',
      },
      {
        'q': 'ข้อมูลส่วนตัวของฉันถูกเก็บอย่างไร?',
        'a':
            'แอปจะใช้ข้อมูลเท่าที่จำเป็นเพื่อให้บริการ ในเวอร์ชันจริงจะมีนโยบายความเป็นส่วนตัวอย่างชัดเจน',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppBar(
        title: const Text('ศูนย์ช่วยเหลือ'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            const Text(
              'คำถามที่พบบ่อย',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            ...faqItems.map(
              (item) => Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['q'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['a'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ติดต่อทีมงาน ReLeaf',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: Color(0xFF2E7D32),
                ),
              ),
              title: const Text('อีเมล'),
              subtitle: const Text('support@releaf.app (สมมติ)'),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Color(0xFF2E7D32),
                ),
              ),
              title: const Text('แชทกับทีมงาน'),
              subtitle: const Text('เปิดหน้าต่างแชท (ตัวอย่าง)'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
