import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBlockNumber = 1;

  final List<Map<String, dynamic>> campusBlocks = [
    {
      'block': 1,
      'label': 'Block 1',
      'title': 'Computer Science & Engineering Wing',
      'subtitle': 'Computing Wing',
      'depts': ['CSE'],
      'icon': Icons.computer,
      'color': Colors.blue.shade700,
      'floors': 'Ground + 3 Floors',
      'totalRooms': '32 Classrooms & Labs',
      'landmarks': 'Opposite Central Library, near North Parking',
      'facilities': [
        'Central Computing Facility (CCF)',
        'CSE HOD Office (Ground Floor)',
        'IoT & Cloud Computing Lab',
        'Restrooms (All Floors - North Wing)',
        'Elevator & Dual Staircases'
      ],
    },
    {
      'block': 2,
      'label': 'Block 2',
      'title': 'Electrical & AI Engineering Wing',
      'subtitle': 'Electrical & AI',
      'depts': ['EEE', 'AIML'],
      'icon': Icons.bolt,
      'color': Colors.lightBlue.shade700,
      'floors': 'Ground + 2 Floors',
      'totalRooms': '24 Classrooms & Labs',
      'landmarks': 'Adjacent to Block 1, near Dean Academic Office',
      'facilities': [
        'Power Systems & Simulation Lab',
        'AIML Deep Learning Research Lab',
        'Department Library (Floor 1)',
        'Staff Rooms & Seminar Hall',
        'Staircase (East & West Wings)'
      ],
    },
    {
      'block': 3,
      'label': 'Block 3',
      'title': 'Mechanical Engineering Complex',
      'subtitle': 'Mechanical Wing',
      'depts': ['MECH'],
      'icon': Icons.precision_manufacturing,
      'color': Colors.cyan.shade700,
      'floors': 'Ground + 2 Floors',
      'totalRooms': '20 Heavy Labs & Halls',
      'landmarks': 'Behind Administrative Block, near Campus Workshop',
      'facilities': [
        'Central Workshop & Foundry',
        'Thermal Engineering & CAD/CAM Lab',
        'Mechanical HOD Cabin (Floor 1)',
        'Student Project Center',
        'Ramp Access & Wide Staircase'
      ],
    },
    {
      'block': 4,
      'label': 'Block 4',
      'title': 'Electronics & Data Science Wing',
      'subtitle': 'Electronics & Data',
      'depts': ['ECE', 'AI&DS'],
      'icon': Icons.memory,
      'color': Colors.indigo.shade600,
      'floors': 'Ground + 3 Floors',
      'totalRooms': '30 Classrooms & Labs',
      'landmarks': 'Near Sports Arena & Indoor Stadium',
      'facilities': [
        'VLSI & Embedded Systems Lab',
        'Data Analytics Server Room',
        'ECE Seminar Hall (Floor 2)',
        'Faculty Cabins & Meeting Rooms',
        'Elevator & North Staircase'
      ],
    },
    {
      'block': 5,
      'label': 'Block 5',
      'title': 'Information Technology & MBA Wing',
      'subtitle': 'IT & Management',
      'depts': ['IT', 'MBA'],
      'icon': Icons.lan,
      'color': Colors.blueAccent,
      'floors': 'Ground + 2 Floors',
      'totalRooms': '22 Classrooms & Labs',
      'landmarks': 'Near Placement Cell & Student Activity Center',
      'facilities': [
        'Full-Stack & Web Technologies Lab',
        'IT Department Office & HOD Cabin (Floor 1)',
        'MBA Case Study Seminar Hall',
        'Smart Board Classrooms',
        'High-Speed Campus Wi-Fi Zone'
      ],
    },
  ];

  void _showBlockOverviewSheet(Map<String, dynamic> blockData) {
    final Color blockColor = blockData['color'] as Color;
    final List facilities = blockData['facilities'] as List;
    final List depts = blockData['depts'] as List;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => FractionallySizedBox(
        heightFactor: 0.75,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: blockColor.withValues(alpha: 0.15),
                    foregroundColor: blockColor,
                    child: Icon(blockData['icon'] as IconData, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blockData['label'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: blockColor,
                          ),
                        ),
                        Text(
                          blockData['title'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _specChip(Icons.layers, blockData['floors'].toString()),
                  _specChip(Icons.meeting_room, blockData['totalRooms'].toString()),
                  _specChip(Icons.place, blockData['landmarks'].toString()),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Departments Located Here',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: depts.map((d) {
                  return Chip(
                    backgroundColor: blockColor.withValues(alpha: 0.12),
                    label: Text(
                      d.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blockColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Block Infrastructure & Highlights',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: facilities.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, size: 16, color: blockColor),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            facilities[index].toString(),
                            style: const TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        side: const BorderSide(color: Colors.indigo),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.layers),
                      label: const Text('Floor Plan'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.floorMap,
                          arguments: {
                            'blockNumber': blockData['block'],
                            'floor': 0,
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.directions),
                      label: const Text('Get Directions'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.mapRoute,
                          arguments: {
                            'name': blockData['label'],
                            'block': blockData['subtitle'],
                            'floor': 0,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.indigo),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withValues(alpha: 0.18),
            foregroundColor: Colors.white,
            child: Icon(icon, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeBlockData = campusBlocks.firstWhere(
      (b) => b['block'] == selectedBlockNumber,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NaviGate • LBRCE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Smart Campus Wayfinder & Labs',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            tooltip: 'Saved Bookmarks',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.bookmarks),
          ),
          IconButton(
            icon: const Icon(Icons.emergency_outlined, color: Colors.white70),
            tooltip: 'Emergency SOS',
            onPressed: () => Navigator.pushNamed(context, AppRoutes.emergencyDesk),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.indigo.shade800, Colors.blue.shade600],
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.indigo),
                          const SizedBox(width: 10),
                          const Text(
                            'Search classrooms, labs, or faculty...',
                            style: TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                          const Spacer(),
                          const Icon(Icons.tune, size: 18, color: Colors.black45),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _headerAction(
                        icon: Icons.map_outlined,
                        label: 'Floor Plans',
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.floorMap,
                          arguments: {'blockNumber': selectedBlockNumber, 'floor': 0},
                        ),
                      ),
                      _headerAction(
                        icon: Icons.local_convenience_store_outlined,
                        label: 'Amenities',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.amenities),
                      ),
                      _headerAction(
                        icon: Icons.navigation_outlined,
                        label: 'Directions',
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.mapRoute,
                          arguments: {
                            'name': activeBlockData['label'].toString(),
                            'block': activeBlockData['subtitle'].toString(),
                            'floor': 0,
                          },
                        ),
                      ),
                      _headerAction(
                        icon: Icons.contact_emergency_outlined,
                        label: 'Helpline',
                        onTap: () => Navigator.pushNamed(context, AppRoutes.emergencyDesk),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: const Text(
                'Campus Blocks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: campusBlocks.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = campusBlocks[index];
                  final isSelected = selectedBlockNumber == item['block'];
                  final List depts = item['depts'] as List;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBlockNumber = item['block'] as int;
                      });
                      _showBlockOverviewSheet(item);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 190,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: isSelected ? 10 : 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  item['icon'] as IconData,
                                  color: Colors.black87,
                                  size: 22,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  item['label'].toString(),
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item['subtitle'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['title'].toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7D32C),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'BOTTOM OVERFLOWED BY ${depts.length.toString()}.4 PIXELS',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Campus Snapshot',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            title: 'Academic Blocks',
                            value: campusBlocks.length.toString(),
                            icon: Icons.school_outlined,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _statCard(
                            title: 'Amenities',
                            value: '24+',
                            icon: Icons.local_convenience_store_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigo.shade800, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.indigo.shade700),
          ),
        ],
      ),
    );
  }
}
