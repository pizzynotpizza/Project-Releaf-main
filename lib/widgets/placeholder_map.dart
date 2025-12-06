// lib/widgets/placeholder_map.dart
import 'package:flutter/material.dart';

/// แผนที่จำลอง (Mock) ไว้ใช้โชว์ UI ก่อนต่อ Google Maps จริง
///
/// ใช้ได้ทั้งใน MapScreen / TrackingScreen
class PlaceholderMap extends StatelessWidget {
  final double aspectRatio;
  final bool showUserMarker;
  final bool showSalengMarker;
  final String? userLabel;
  final String? salengLabel;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onRecenter;

  const PlaceholderMap({
    super.key,
    this.aspectRatio = 16 / 9,
    this.showUserMarker = true,
    this.showSalengMarker = false,
    this.userLabel,
    this.salengLabel,
    this.margin,
    this.onRecenter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final container = AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(22),
          image: const DecorationImage(
            image: AssetImage('assets/images/mock_map_bg.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ป้ายหัวด้านบน
            Positioned(
              left: 16,
              top: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.map_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'แผนที่จำลอง (ยังไม่เชื่อมต่อ Google Maps)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ปุ่ม recenter มุมขวาบน
            Positioned(
              right: 14,
              top: 14,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 3,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onRecenter,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.my_location_rounded,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            // Marker ผู้ใช้
            if (showUserMarker)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 34,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          userLabel ?? 'ตำแหน่งของคุณ',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Marker ซาเล้ง
            if (showSalengMarker)
              Positioned(
                left: 32,
                top: 32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.pedal_bike_rounded,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        salengLabel ?? 'ซาเล้ง',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );

    if (margin != null) {
      return Container(
        margin: margin,
        child: container,
      );
    }
    return container;
  }
}
