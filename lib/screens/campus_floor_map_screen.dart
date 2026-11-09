import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class CampusFloorMapScreen extends StatefulWidget {
  final int initialBlock;
  final int initialFloor;

  const CampusFloorMapScreen({
    super.key,
    this.initialBlock = 1,
    this.initialFloor = 0,
  });

  @override
  State<CampusFloorMapScreen> createState() => _CampusFloorMapScreenState();
}

class _CampusFloorMapScreenState extends State<CampusFloorMapScreen> {
  late int selectedBlock;
  late int selectedFloor;

  final Map<int, String> blockTitles = {
    1: 'Block 1 • CSE & Computing Wing',
    2: 'Block 2 • EEE & AIML Wing',
    3: 'Block 3 • Mechanical Engineering',
    4: 'Block 4 • ECE & AI&DS Wing',
    5: 'Block 5 • IT & Management Wing',
  };

  final Map<String, Map<String, dynamic>> utilityDetails = {
    'Elevator': {
      'icon': Icons.elevator,
      'color': Colors.blue,
      'status': 'Operational',
      'location': 'North Lobby Corridor (Near Central Staircase)',
      'description': 'High-speed 13-passenger automated elevator with braille controls and wheelchair accessibility across all floors.',
      'specs': ['Load Capacity: 884 kg', 'Wheelchair Friendly: Yes', 'Power Backup: Dedicated Generator'],
    },
    'Staircase': {
      'icon': Icons.stairs,
      'color': Colors.orange,
      'status': 'Open Access',
      'location': 'Dual Stairwells: East Wing & West Wing Entrances',
      'description': 'Wide 2-meter fire-rated staircases connecting Ground Floor to Top Terrace with anti-slip nosing and dual handrails.',
      'specs': ['Width: 2.1 Meters', 'Handrail: Stainless Steel', 'Step Lighting: LED Emergency Rail'],
    },
    'Washrooms': {
      'icon': Icons.wc,
      'color': Colors.teal,
      'status': 'Sanitized & Active',
      'location': 'Behind Department Faculty Cabins (North-West Corner)',
      'description': 'Separated Men, Women, and Specially-Abled Restrooms equipped with automated sensor taps and hygiene stations.',
      'specs': ['Divisions: Gents & Ladies', 'Accessible Restroom: Ground Floor', 'Maintenance: Hourly Cleaned'],
    },
    'Fire Exit': {
      'icon': Icons.local_fire_department,
      'color': Colors.red,
      'status': 'Emergency Ready',
      'location': 'Rear Corridor Direct Exit Ramp (South Wing)',
      'description': 'Panic-push bar equipped fire evacuation door with illuminated glow-in-the-dark escape route signs and ABC dry powder extinguishers.',
      'specs': ['Extinguisher: 6kg ABC Powder', 'Door: 2-Hour Fire Resistant', 'Assembly Point: Open Ground Area'],
    },
    'Wi-Fi 6': {
      'icon': Icons.wifi,
      'color': Colors.green,
      'status': 'High Speed (Active)',
      'location': 'Dual AP Antennas along Central Walkway ceiling',
      'description': 'LBRCE Enterprise Campus Wi-Fi 6 (802.11ax) network supporting seamless roaming for faculty and student portal access.',
      'specs': ['SSID: LBRCE-CAMPUS-WIFI', 'Frequency: 2.4 GHz & 5 GHz', 'Speed: Up to 300 Mbps'],
    },
  };

  final Map<int, Map<int, List<Map<String, dynamic>>>> floorPlans = {
    1: {
      0: [
        {
          'code': '101',
          'title': 'HOD CSE Cabin',
          'type': 'Admin / Office',
          'capacity': 'Head of Dept & Staff',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.admin_panel_settings,
          'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80',
          'desc': 'Head of Department consultation room and central academic administration desk.',
        },
        {
          'code': '102',
          'title': 'CSE Faculty Lounge A',
          'type': 'Faculty Cabin',
          'capacity': '16 Senior Faculty',
          'status': 'Busy',
          'statusColor': Colors.orange,
          'icon': Icons.badge,
          'imageUrl': 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=600&q=80',
          'desc': 'Cabin spaces for professors, student counseling, and research advisory.',
        },
        {
          'code': '103',
          'title': 'Central Computer Center 1',
          'type': 'Computing Lab',
          'capacity': '72 High-End PCs',
          'status': 'Class in Session',
          'statusColor': Colors.red,
          'icon': Icons.desktop_windows,
          'imageUrl': 'https://images.unsplash.com/photo-1562774053-701939374585?auto=format&fit=crop&w=600&q=80',
          'desc': 'Primary programming & online examination center equipped with gigabit LAN.',
        },
        {
          'code': '104',
          'title': 'IoT & Embedded Research Lab',
          'type': 'R&D Lab',
          'capacity': '35 Workstations',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.memory,
          'imageUrl': 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=600&q=80',
          'desc': 'Hardware prototyping benches with Raspberry Pi, Arduino, and sensor test rigs.',
        },
      ],
      1: [
        {
          'code': '201',
          'title': 'CSE-A Smart Classroom',
          'type': 'Lecture Hall',
          'capacity': '66 Student Seats',
          'status': 'Lecture Going On',
          'statusColor': Colors.red,
          'icon': Icons.school,
          'imageUrl': 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=600&q=80',
          'desc': 'Tiered lecture theater with interactive 85" 4K smart interactive panel.',
        },
        {
          'code': '202',
          'title': 'CSE-B Lecture Theater',
          'type': 'Lecture Hall',
          'capacity': '66 Student Seats',
          'status': 'Free Slot',
          'statusColor': Colors.green,
          'icon': Icons.co_present,
          'imageUrl': 'https://images.unsplash.com/photo-1509062522246-3755977927d7?auto=format&fit=crop&w=600&q=80',
          'desc': 'Acoustically treated classroom with lecture capture and digital projection.',
        },
        {
          'code': '203',
          'title': 'Advanced Software Engg Lab',
          'type': 'Software Lab',
          'capacity': '60 Systems',
          'status': 'Lab Practical',
          'statusColor': Colors.orange,
          'icon': Icons.terminal,
          'imageUrl': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=600&q=80',
          'desc': 'Linux and cloud development workspace for software engineering curriculums.',
        },
        {
          'code': '204',
          'title': 'Student Discussion Room',
          'type': 'Seminar Space',
          'capacity': '30 Seats',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.groups,
          'imageUrl': 'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?auto=format&fit=crop&w=600&q=80',
          'desc': 'Round-table collaborative area for group projects, hackathons, and mock interviews.',
        },
      ],
      2: [
        {
          'code': '301',
          'title': 'Block 1 Main Auditorium',
          'type': 'Auditorium',
          'capacity': '200 Seats',
          'status': 'Open',
          'statusColor': Colors.green,
          'icon': Icons.theater_comedy,
          'imageUrl': 'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=600&q=80',
          'desc': 'Central air-conditioned conference venue for guest lectures and symposiums.',
        },
        {
          'code': '302',
          'title': 'Third Year CSE Lecture Hall',
          'type': 'Lecture Hall',
          'capacity': '66 Student Seats',
          'status': 'In Session',
          'statusColor': Colors.red,
          'icon': Icons.school,
          'imageUrl': 'https://images.unsplash.com/photo-1577896851231-70ef18881754?auto=format&fit=crop&w=600&q=80',
          'desc': 'Multimedia lecture hall with dual projectors and wireless mic audio system.',
        },
        {
          'code': '303',
          'title': 'Data Engineering Lab',
          'type': 'Cloud Lab',
          'capacity': '60 Systems',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.storage,
          'imageUrl': 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=600&q=80',
          'desc': 'Dedicated big-data analytics and cloud virtualization lab environment.',
        },
        {
          'code': '304',
          'title': 'Department Digital Library',
          'type': 'Library',
          'capacity': '40 Reading Desks',
          'status': 'Quiet Study',
          'statusColor': Colors.blue,
          'icon': Icons.menu_book,
          'imageUrl': 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=600&q=80',
          'desc': 'Departmental book bank, IEEE journal access terminals, and reference books.',
        },
      ],
    },
    5: {
      0: [
        {
          'code': '501',
          'title': 'IT Department Office',
          'type': 'Admin / Office',
          'capacity': 'Office Staff',
          'status': 'Open',
          'statusColor': Colors.green,
          'icon': Icons.business_center,
          'imageUrl': 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=600&q=80',
          'desc': 'Student record files, exam registration desks, and general enquiries.',
        },
        {
          'code': '502',
          'title': 'HOD IT Cabin',
          'type': 'Executive Cabin',
          'capacity': 'Head of Dept',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.account_circle,
          'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80',
          'desc': 'Office cabin of Professor & Head, Department of Information Technology.',
        },
        {
          'code': '503',
          'title': 'Programming & C-Java Lab',
          'type': 'Computing Lab',
          'capacity': '65 Workstations',
          'status': 'Lab In Progress',
          'statusColor': Colors.red,
          'icon': Icons.laptop_chromebook,
          'imageUrl': 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=600&q=80',
          'desc': 'Core programming practicals with high-speed compiler environments.',
        },
        {
          'code': '504',
          'title': 'Student Innovation Hub',
          'type': 'Incubation Lab',
          'capacity': '45 Workstations',
          'status': 'Open Workspace',
          'statusColor': Colors.blue,
          'icon': Icons.lightbulb,
          'imageUrl': 'https://images.unsplash.com/photo-1531482615713-2afd69097998?auto=format&fit=crop&w=600&q=80',
          'desc': 'Collaborative makerspace for app building, startup pitching, and hackathons.',
        },
      ],
      1: [
        {
          'code': '511',
          'title': 'IT Faculty Workstations',
          'type': 'Faculty Cabin',
          'capacity': '18 Staff Members',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.badge,
          'imageUrl': 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=600&q=80',
          'desc': 'Dedicated cubicles for Assistant and Associate Professors of IT.',
        },
        {
          'code': '512',
          'title': 'Web Technologies Lab',
          'type': 'Specialized Lab',
          'capacity': '65 Systems',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.web,
          'imageUrl': 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=600&q=80',
          'desc': 'Front-end, back-end, and mobile application engineering test facility.',
        },
        {
          'code': '513',
          'title': 'IT Final Year Classroom 513',
          'type': 'Lecture Hall',
          'capacity': '66 Student Seats',
          'status': 'Lecture Going On',
          'statusColor': Colors.orange,
          'icon': Icons.school,
          'imageUrl': 'https://images.unsplash.com/photo-1509062522246-3755977927d7?auto=format&fit=crop&w=600&q=80',
          'desc': 'Spacious classroom equipped with projector and dual PA sound system.',
        },
        {
          'code': '514',
          'title': 'Cyber Security & Network Lab',
          'type': 'Security Lab',
          'capacity': '50 Systems',
          'status': 'Available',
          'statusColor': Colors.green,
          'icon': Icons.security,
          'imageUrl': 'https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&w=600&q=80',
          'desc': 'Network simulator, firewall testbed, and penetration testing sandbox.',
        },
      ],
      2: [
        {
          'code': '521',
          'title': 'MBA Executive Conference Hall',
          'type': 'Auditorium',
          'capacity': '120 Seats',
          'status': 'Open',
          'statusColor': Colors.green,
          'icon': Icons.meeting_room,
          'imageUrl': 'https://images.unsplash.com/photo-1511578314322-379afb476865?auto=format&fit=crop&w=600&q=80',
          'desc': 'Executive boardroom style seating for corporate presentations and guest seminars.',
        },
        {
          'code': '522',
          'title': 'School of Management Office',
          'type': 'Admin / Office',
          'capacity': 'Admin Staff',
          'status': 'Open',
          'statusColor': Colors.green,
          'icon': Icons.domain,
          'imageUrl': 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=600&q=80',
          'desc': 'MBA Dean office and department administrative coordinator cabin.',
        },
        {
          'code': '523',
          'title': 'Business Analytics Lab',
          'type': 'Class / Lab',
          'capacity': '50 Systems',
          'status': 'Class in Session',
          'statusColor': Colors.red,
          'icon': Icons.query_stats,
          'imageUrl': 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=600&q=80',
          'desc': 'Financial modeling, Tableau, and business intelligence computational tools.',
        },
        {
          'code': '524',
          'title': 'Management Reference Library',
          'type': 'Reading Room',
          'capacity': '35 Seats',
          'status': 'Quiet Study',
          'statusColor': Colors.blue,
          'icon': Icons.local_library,
          'imageUrl': 'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=600&q=80',
          'desc': 'Harvard Business Review journals, economics case studies, and magazines.',
        },
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    selectedBlock = widget.initialBlock;
    selectedFloor = widget.initialFloor;
  }

  // Shows interactive details for any clicked utility (Washrooms, Elevator, etc.)
  void _showUtilityDetailSheet(String utilityName) {
    final utility = utilityDetails[utilityName];
    if (utility == null) return;

    final Color themeColor = utility['color'] as Color;
    final List<String> specs = List<String>.from(utility['specs'] as List);
    final String blockName = blockTitles[selectedBlock]?.split('•')[0].trim() ?? 'Block $selectedBlock';
    final String floorName = selectedFloor == 0 ? 'Ground Floor' : 'Floor $selectedFloor';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: themeColor.withOpacity(0.15),
                  foregroundColor: themeColor,
                  child: Icon(utility['icon'] as IconData, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            utilityName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.green.shade300),
                            ),
                            child: Text(
                              utility['status'] as String,
                              style: TextStyle(
                                color: Colors.green.shade800,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "$blockName • $floorName",
                        style: const TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // Exact Physical Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.pin_drop, size: 18, color: Colors.indigo),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    utility['location'] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Description
            Text(
              utility['description'] as String,
              style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
            ),
            const SizedBox(height: 14),

            // Features & Specs
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: specs.map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    s,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Guide me here button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.directions, size: 18),
                label: Text('Guide Me to $utilityName'),
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.mapRoute,
                    arguments: {
                      'name': "$utilityName ($floorName)",
                      'block': blockName,
                      'floor': selectedFloor,
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoomDetailSheet(Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    room['imageUrl'] as String,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Room ${room['code']}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: (room['statusColor'] as Color).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              room['status'] as String,
                              style: TextStyle(
                                color: room['statusColor'] as Color,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        room['title'] as String,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        room['type'] as String,
                        style: const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              room['desc'] as String,
              style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.people_outline, size: 16, color: Colors.indigo),
                const SizedBox(width: 6),
                Text(
                  "Capacity: ${room['capacity']}",
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Get Directions'),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.mapRoute,
                        arguments: {
                          'name': "${room['code']} • ${room['title']}",
                          'block': blockTitles[selectedBlock]?.split('•')[0].trim(),
                          'floor': selectedFloor,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeRooms = floorPlans[selectedBlock]?[selectedFloor] ?? [
      {
        'code': 'G01',
        'title': 'Standard Classroom Wing',
        'type': 'Lecture Space',
        'capacity': '60 Seats',
        'status': 'Available',
        'statusColor': Colors.green,
        'icon': Icons.school,
        'imageUrl': 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=600&q=80',
        'desc': 'General purpose academic classroom equipped with whiteboards and projection.',
      },
      {
        'code': 'G02',
        'title': 'Department Computing Center',
        'type': 'Lab Space',
        'capacity': '50 PCs',
        'status': 'Lab Practical',
        'statusColor': Colors.orange,
        'icon': Icons.desktop_windows,
        'imageUrl': 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=600&q=80',
        'desc': 'Central computer lab dedicated to regular laboratory curriculum sessions.',
      },
      {
        'code': 'G03',
        'title': 'Faculty Room & Cabins',
        'type': 'Staff Area',
        'capacity': '12 Staff',
        'status': 'Open',
        'statusColor': Colors.green,
        'icon': Icons.badge,
        'imageUrl': 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&w=600&q=80',
        'desc': 'Departmental faculty meeting and counseling cabin units.',
      },
      {
        'code': 'G04',
        'title': 'Department Administration',
        'type': 'Admin Office',
        'capacity': 'Office Desk',
        'status': 'Open',
        'statusColor': Colors.green,
        'icon': Icons.admin_panel_settings,
        'imageUrl': 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=600&q=80',
        'desc': 'Administrative staff desk for student attendance, forms, and general notice.',
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 950 ? 4 : (screenWidth > 620 ? 3 : 2);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),
      appBar: AppBar(
        title: const Text('Campus Blueprint & Visual Floor Map'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            children: [
              // Header Controls
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.apartment, color: Colors.indigo, size: 20),
                            const SizedBox(width: 8),
                            DropdownButton<int>(
                              value: selectedBlock,
                              underline: Container(),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              items: [1, 2, 3, 4, 5].map((b) {
                                return DropdownMenuItem<int>(
                                  value: b,
                                  child: Text(blockTitles[b] ?? 'Block $b'),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    selectedBlock = val;
                                    selectedFloor = 0;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "${activeRooms.length} Spaces Mapped",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0, 1, 2].map((floorNum) {
                        final isSelected = selectedFloor == floorNum;
                        final label = floorNum == 0 ? 'Ground Floor' : 'Floor $floorNum';

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ChoiceChip(
                            label: Text(label),
                            selected: isSelected,
                            selectedColor: Colors.indigo,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            onSelected: (selected) {
                              if (selected) setState(() => selectedFloor = floorNum);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Clickable Utility Toolbar
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _clickableUtilityBadge(Icons.elevator, 'Elevator', Colors.blue),
                    _clickableUtilityBadge(Icons.stairs, 'Staircase', Colors.orange),
                    _clickableUtilityBadge(Icons.wc, 'Washrooms', Colors.teal),
                    _clickableUtilityBadge(Icons.local_fire_department, 'Fire Exit', Colors.red),
                    _clickableUtilityBadge(Icons.wifi, 'Wi-Fi 6', Colors.green),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Visual Grid of Rooms
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${blockTitles[selectedBlock]} • ${selectedFloor == 0 ? 'Ground Floor' : 'Floor $selectedFloor'}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.indigo.shade900,
                                ),
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.touch_app, size: 14, color: Colors.black45),
                                  SizedBox(width: 4),
                                  Text(
                                    'Tap any card to view directions',
                                    style: TextStyle(fontSize: 11, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.88,
                            ),
                            itemCount: activeRooms.length,
                            itemBuilder: (context, index) {
                              final room = activeRooms[index];
                              final statusColor = room['statusColor'] as Color;

                              return InkWell(
                                onTap: () => _showRoomDetailSheet(room),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Colors.grey.shade200, width: 1.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              room['imageUrl'] as String,
                                              height: 105,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) => Container(
                                                height: 105,
                                                color: Colors.indigo.shade50,
                                                child: Icon(room['icon'] as IconData, size: 36, color: Colors.indigo),
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              left: 8,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo.shade900.withOpacity(0.9),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  room['code'] as String,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 8,
                                              right: 8,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.95),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(radius: 3, backgroundColor: statusColor),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      room['status'] as String,
                                                      style: TextStyle(
                                                        fontSize: 9,
                                                        fontWeight: FontWeight.bold,
                                                        color: statusColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              room['title'] as String,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              room['type'] as String,
                                              style: const TextStyle(fontSize: 10, color: Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                const Icon(Icons.people_alt_outlined, size: 11, color: Colors.grey),
                                                const SizedBox(width: 4),
                                                Expanded(
                                                  child: Text(
                                                    room['capacity'] as String,
                                                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_back, size: 14, color: Colors.black45),
                                SizedBox(width: 8),
                                Text(
                                  'Central Campus Walkway & North Corridor',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, size: 14, color: Colors.black45),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  // Clickable Utility Badge with InkWell ripple
  Widget _clickableUtilityBadge(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () => _showUtilityDetailSheet(label),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: color.withOpacity(0.12),
              foregroundColor: color,
              child: Icon(icon, size: 16),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}