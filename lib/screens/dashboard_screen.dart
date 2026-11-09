import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes/app_routes.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LBRCE Campus Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Live Operations & Smart Wayfinding',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: 'Saved Bookmarks',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.bookmarks),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Hero Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade800, Colors.indigo.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'SMART CAMPUS HUB',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Welcome to NaviGate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Seamless navigation, floor blueprints, live room occupancy, and campus directory.',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 14),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.indigo.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(Icons.apartment, size: 18),
                            label: const Text('Explore Departments'),
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white.withOpacity(0.12),
                      child: const Icon(Icons.school, size: 40, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Campus Live Metrics
              const Text(
                'Campus Live Pulse',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _metricTile('5 Blocks', 'Academic Wings', Icons.apartment, Colors.blue),
                  const SizedBox(width: 10),
                  _metricTile('8 Branches', 'CSE, IT, ECE +', Icons.account_tree, Colors.purple),
                  const SizedBox(width: 10),
                  _metricTile('24/7 SOS', 'Ready & Active', Icons.health_and_safety, Colors.red),
                  const SizedBox(width: 10),
                  _metricTile('Wi-Fi 6', 'Full Coverage', Icons.wifi, Colors.green),
                ],
              ),

              const SizedBox(height: 24),

              // Quick Feature Launchpad
              const Text(
                'Quick Navigation Hub',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _featureCard(
                    context,
                    title: 'Floor Blueprints',
                    subtitle: 'Rooms & Layouts',
                    icon: Icons.layers_outlined,
                    color: Colors.blue,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.floorMap,
                      arguments: {'blockNumber': 1, 'floor': 0},
                    ),
                  ),
                  _featureCard(
                    context,
                    title: 'Route Planner',
                    subtitle: 'Point-to-Point Map',
                    icon: Icons.directions_walk,
                    color: Colors.orange,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.mapRoute),
                  ),
                  _featureCard(
                    context,
                    title: 'Campus Amenities',
                    subtitle: 'Canteen, Library, ATM',
                    icon: Icons.local_convenience_store_outlined,
                    color: Colors.teal,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.amenities),
                  ),
                  _featureCard(
                    context,
                    title: 'Emergency Help',
                    subtitle: 'Medical & Security',
                    icon: Icons.emergency_outlined,
                    color: Colors.red,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.emergencyDesk),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Live Room Occupancy Monitor
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Live Room & Lab Monitor',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_forward, size: 14),
                    label: const Text('View All'),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRoutes.floorMap,
                      arguments: {'blockNumber': 1, 'floor': 0},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('rooms').limit(4).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));
                  }

                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('No room statuses logged yet in Cloud Firestore.'),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final status = data['status'] ?? 'Available';
                      final isAvail = status.toString().toLowerCase() == 'available';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        elevation: 1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isAvail ? Colors.green.shade100 : Colors.red.shade100,
                            foregroundColor: isAvail ? Colors.green.shade900 : Colors.red.shade900,
                            child: Icon(isAvail ? Icons.check_circle_outline : Icons.lock_clock),
                          ),
                          title: Text(
                            data['roomNumber'] ?? 'Campus Facility',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: Text(
                            "Activity: ${data['currentActivity'] ?? 'Regular Scheduled Slot'}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Chip(
                            label: Text(
                              status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isAvail ? Colors.green.shade800 : Colors.red.shade800,
                              ),
                            ),
                            backgroundColor: isAvail ? Colors.green.shade50 : Colors.red.shade50,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricTile(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withOpacity(0.12),
              foregroundColor: color,
              child: Icon(icon, size: 16),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.12),
              foregroundColor: color,
              child: Icon(icon, size: 22),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}