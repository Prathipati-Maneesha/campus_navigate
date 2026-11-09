import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class AmenitiesScreen extends StatelessWidget {
  const AmenitiesScreen({super.key});

  final List<Map<String, dynamic>> amenities = const [
    {
      'title': 'Central Library',
      'category': 'Academic',
      'location': 'Central Library Building',
      'block': 'Admin Block',
      'floor': 1,
      'timing': '8:00 AM - 8:00 PM',
      'icon': Icons.local_library,
      'color': Colors.blue,
    },
    {
      'title': 'Campus Canteen & Food Court',
      'category': 'Food & Refreshment',
      'location': 'Near Sports Complex',
      'block': 'Block 3 Wing',
      'floor': 0,
      'timing': '8:30 AM - 6:30 PM',
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'title': 'Examination Section',
      'category': 'Administration',
      'location': 'Administrative Wing',
      'block': 'Admin Block',
      'floor': 1,
      'timing': '9:30 AM - 4:30 PM',
      'icon': Icons.assignment,
      'color': Colors.purple,
    },
    {
      'title': 'Training & Placement Cell',
      'category': 'Career',
      'location': 'T&P Complex, Ground Floor',
      'block': 'Block 1 Wing',
      'floor': 0,
      'timing': '9:00 AM - 5:00 PM',
      'icon': Icons.work,
      'color': Colors.teal,
    },
    {
      'title': 'Health Center & Dispensary',
      'category': 'Medical',
      'location': 'Ground Floor Medical Unit',
      'block': 'Admin Block',
      'floor': 0,
      'timing': '24/7 Service',
      'icon': Icons.local_hospital,
      'color': Colors.red,
    },
    {
      'title': 'ATM / Banking Counter',
      'category': 'Utility',
      'location': 'Main Gate Security Complex',
      'block': 'Main Entrance',
      'floor': 0,
      'timing': '24 Hours',
      'icon': Icons.atm,
      'color': Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Amenities & Utilities'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: amenities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = amenities[index];
          final Color themeColor = item['color'] as Color;

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: themeColor.withOpacity(0.15),
                        foregroundColor: themeColor,
                        radius: 22,
                        child: Icon(item['icon'] as IconData),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: themeColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item['category'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: themeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Location: ${item['location']}"),
                  Text(
                    "Hours: ${item['timing']}",
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.indigo,
                      ),
                      icon: const Icon(Icons.directions, size: 18),
                      label: const Text('Get Directions'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.mapRoute,
                          arguments: {
                            'name': item['title'],
                            'block': item['block'],
                            'floor': item['floor'],
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}