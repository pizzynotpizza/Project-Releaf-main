import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cashRewards = [
      {
        'title': 'แลกเป็นเงินโอน 50 บาท',
        'points': 500,
        'desc': 'โอนเข้าบัญชีธนาคารที่ผูกไว้ (ตัวอย่าง)',
      },
      {
        'title': 'แลกเป็นเงินโอน 100 บาท',
        'points': 1000,
        'desc': 'โอนเข้าบัญชีธนาคารที่ผูกไว้ (ตัวอย่าง)',
      },
    ];

    final itemRewards = [
      {
        'title': 'โค้ดส่วนลดร้านสะดวกซื้อ 30 บาท',
        'points': 250,
        'desc': 'ใช้ได้กับร้านพาร์ทเนอร์ที่ร่วมรายการ',
      },
      {
        'title': 'ถุงผ้ารักษ์โลก ReLeaf Edition',
        'points': 600,
        'desc': 'จำนวนจำกัด 1 ใบต่อบัญชี',
      },
      {
        'title': 'แก้วน้ำพกพา ReLeaf',
        'points': 800,
        'desc': 'ช่วยลดการใช้แก้วพลาสติกแบบครั้งเดียวทิ้ง',
      },
    ];

    void redeemReward(Map<String, dynamic> reward) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('ยืนยันการแลกของรางวัล'),
            content: Text(
              'นี่เป็นหน้าจอจำลองสำหรับการแลกจริง\n\n'
              'รายการ: ${reward['title']}\n'
              'ใช้ ${reward['points']} EcoCoin',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('ยกเลิก'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'แลกของรางวัลสำเร็จ (ตัวอย่าง ยังไม่เชื่อม Backend)',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F9D58),
                  foregroundColor: Colors.white,
                ),
                child: const Text('ยืนยัน'),
              ),
            ],
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6F4),
        appBar: AppBar(
          title: const Text(
            'แลกของรางวัล',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color(0xFF0F9D58),
            labelColor: Color(0xFF0F9D58),
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: 'แลกเป็นเงิน'),
              Tab(text: 'ของรางวัล'),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Color(0xFF2E7D32),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'คุณมี 1,250 EcoCoin\n'
                          'ประมาณ 125 บาท (ตัวอย่าง)',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: TabBarView(
                  children: [
                    // tab แลกเป็นเงิน
                    ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: cashRewards.length,
                      itemBuilder: (ctx, index) {
                        final r = cashRewards[index];
                        return _RewardCard(
                          title: r['title'] as String,
                          points: r['points'] as int,
                          description: r['desc'] as String,
                          leadingIcon: Icons.payments_rounded,
                          onRedeem: () => redeemReward(r),
                        );
                      },
                    ),

                    // tab ของรางวัล
                    ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: itemRewards.length,
                      itemBuilder: (ctx, index) {
                        final r = itemRewards[index];
                        return _RewardCard(
                          title: r['title'] as String,
                          points: r['points'] as int,
                          description: r['desc'] as String,
                          leadingIcon: Icons.card_giftcard_rounded,
                          onRedeem: () => redeemReward(r),
                        );
                      },
                    ),
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

class _RewardCard extends StatelessWidget {
  final String title;
  final int points;
  final String description;
  final IconData leadingIcon;
  final VoidCallback onRedeem;

  const _RewardCard({
    required this.title,
    required this.points,
    required this.description,
    required this.leadingIcon,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              leadingIcon,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$points EcoCoin',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onRedeem,
            child: const Text(
              'แลกเลย',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F9D58),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
