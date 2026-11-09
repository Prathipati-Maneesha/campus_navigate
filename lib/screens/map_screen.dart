import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  final String? destinationName;
  final String? destinationBlock;
  final int? floor;

  const MapScreen({
    super.key,
    this.destinationName,
    this.destinationBlock,
    this.floor,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late String startingPoint;
  late String destinationPoint;

  // Master list of all navigable campus locations
  final List<String> allCampusLocations = [
    'Main Gate 1',
    'Administrative Block',
    'Central Library',
    'Campus Canteen',
    'Block 1 (CSE Wing)',
    'Block 2 (EEE & AIML Wing)',
    'Block 3 (Mechanical Wing)',
    'Block 4 (ECE & AI&DS Wing)',
    'Block 5 (IT & MBA Wing)',
  ];

  @override
  void initState() {
    super.initState();
    startingPoint = 'Main Gate 1';

    // Auto-select initial destination if passed from another screen
    final incomingBlock = widget.destinationBlock ?? '';
    if (incomingBlock.contains('1')) {
      destinationPoint = 'Block 1 (CSE Wing)';
    } else if (incomingBlock.contains('2')) {
      destinationPoint = 'Block 2 (EEE & AIML Wing)';
    } else if (incomingBlock.contains('3')) {
      destinationPoint = 'Block 3 (Mechanical Wing)';
    } else if (incomingBlock.contains('4')) {
      destinationPoint = 'Block 4 (ECE & AI&DS Wing)';
    } else if (incomingBlock.contains('5')) {
      destinationPoint = 'Block 5 (IT & MBA Wing)';
    } else {
      destinationPoint = 'Block 5 (IT & MBA Wing)';
    }
  }

  // Swap starting point and destination
  void _swapPoints() {
    setState(() {
      final temp = startingPoint;
      startingPoint = destinationPoint;
      destinationPoint = temp;
    });
  }

  // Generate dynamic directions based on any start and end point
  List<Map<String, dynamic>> _getDynamicRouteSteps() {
    if (startingPoint == destinationPoint) {
      return [
        {
          'title': 'You are already at $startingPoint',
          'subtitle': 'Origin and destination points are the same.',
          'icon': Icons.check_circle,
          'done': true,
        }
      ];
    }

    return [
      {
        'title': 'Start at $startingPoint',
        'subtitle': 'Locate the nearest exit/walkway sign to proceed',
        'icon': Icons.my_location,
        'done': true,
      },
      {
        'title': 'Walk via Central Campus Boulevard',
        'subtitle': 'Follow the tree-lined central avenue towards Central Library & Garden',
        'icon': Icons.directions_walk,
        'done': true,
      },
      {
        'title': 'Approach $destinationPoint',
        'subtitle': 'Take the main entry ramp or north staircase',
        'icon': Icons.stairs,
        'done': false,
      },
      {
        'title': 'Arrive at $destinationPoint',
        'subtitle': widget.destinationName != null
            ? 'Proceed to ${widget.destinationName} on Floor ${widget.floor ?? 1}'
            : 'You have reached your designated campus target.',
        'icon': Icons.pin_drop,
        'done': false,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getDynamicRouteSteps();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        title: const Text('Interactive Campus Route Planner'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Dynamic Origin & Destination Selection Card
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
              children: [
                // Starting Point Selector
                Row(
                  children: [
                    const Icon(Icons.radio_button_checked, color: Colors.green, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: startingPoint,
                        decoration: InputDecoration(
                          labelText: 'Starting Point (Origin)',
                          labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        items: allCampusLocations.map((loc) {
                          return DropdownMenuItem<String>(
                            value: loc,
                            child: Text(loc, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => startingPoint = val);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Swap Button
                Row(
                  children: [
                    const SizedBox(width: 32),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    IconButton(
                      icon: const Icon(Icons.swap_vert, color: Colors.indigo),
                      tooltip: 'Swap Origin and Destination',
                      onPressed: _swapPoints,
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),

                const SizedBox(height: 2),

                // Destination Point Selector
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: destinationPoint,
                        decoration: InputDecoration(
                          labelText: 'Destination (Ending Point)',
                          labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        items: allCampusLocations.map((loc) {
                          return DropdownMenuItem<String>(
                            value: loc,
                            child: Text(loc, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => destinationPoint = val);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 2D Custom Painted Vector Route Map
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo.shade100, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 240),
                    painter: DynamicCampusMapPainter(
                      origin: startingPoint,
                      destination: destinationPoint,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.route, color: Colors.greenAccent, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            '$startingPoint  ➔  $destinationPoint',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Turn-by-Turn Stepper Instructions
          const Text(
            'Walking Directions & Route Cues',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 10),

          ...steps.map((item) {
            final isDone = item['done'] as bool;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: isDone ? Colors.indigo.shade200 : Colors.grey.shade300,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isDone ? Colors.indigo : Colors.grey.shade200,
                  foregroundColor: isDone ? Colors.white : Colors.black54,
                  child: Icon(item['icon'] as IconData, size: 20),
                ),
                title: Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDone ? Colors.indigo.shade900 : Colors.black87,
                  ),
                ),
                subtitle: Text(item['subtitle'] as String),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Custom Painter to draw direct paths between chosen Origin and Destination
class DynamicCampusMapPainter extends CustomPainter {
  final String origin;
  final String destination;

  DynamicCampusMapPainter({
    required this.origin,
    required this.destination,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFF1F4F9);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    // Green Campus Central Lawn
    final gardenPaint = Paint()..color = Colors.green.shade50;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.28, size.height * 0.25, size.width * 0.44, size.height * 0.50),
        const Radius.circular(16),
      ),
      gardenPaint,
    );

    // Map Coordinates for all nodes
    final Map<String, Offset> nodeCoordinates = {
      'Main Gate 1': Offset(size.width * 0.15, size.height * 0.85),
      'Administrative Block': Offset(size.width * 0.50, size.height * 0.80),
      'Central Library': Offset(size.width * 0.50, size.height * 0.50),
      'Campus Canteen': Offset(size.width * 0.15, size.height * 0.30),
      'Block 1 (CSE Wing)': Offset(size.width * 0.82, size.height * 0.20),
      'Block 2 (EEE & AIML Wing)': Offset(size.width * 0.82, size.height * 0.38),
      'Block 3 (Mechanical Wing)': Offset(size.width * 0.82, size.height * 0.56),
      'Block 4 (ECE & AI&DS Wing)': Offset(size.width * 0.82, size.height * 0.72),
      'Block 5 (IT & MBA Wing)': Offset(size.width * 0.82, size.height * 0.90),
    };

    final pMainGate = nodeCoordinates['Main Gate 1']!;
    final pAdmin = nodeCoordinates['Administrative Block']!;
    final pLibrary = nodeCoordinates['Central Library']!;
    final pCanteen = nodeCoordinates['Campus Canteen']!;
    final pB1 = nodeCoordinates['Block 1 (CSE Wing)']!;
    final pB5 = nodeCoordinates['Block 5 (IT & MBA Wing)']!;

    // Background Road Network
    canvas.drawLine(pMainGate, pAdmin, roadPaint);
    canvas.drawLine(pAdmin, pLibrary, roadPaint);
    canvas.drawLine(pLibrary, pCanteen, roadPaint);
    canvas.drawLine(pLibrary, nodeCoordinates['Block 2 (EEE & AIML Wing)']!, roadPaint);
    canvas.drawLine(pAdmin, nodeCoordinates['Block 4 (ECE & AI&DS Wing)']!, roadPaint);
    canvas.drawLine(pB1, pB5, roadPaint..strokeWidth = 10);

    // Look up start and end coordinates
    final startPos = nodeCoordinates[origin] ?? pMainGate;
    final endPos = nodeCoordinates[destination] ?? pB5;

    // Active Route Path
    if (origin != destination) {
      final activeRoutePaint = Paint()
        ..color = Colors.indigo.shade600
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final path = Path()
        ..moveTo(startPos.dx, startPos.dy)
        ..lineTo(pLibrary.dx, pLibrary.dy)
        ..lineTo(endPos.dx, endPos.dy);

      canvas.drawPath(path, activeRoutePaint);
    }

    // Draw all landmark nodes
    nodeCoordinates.forEach((key, pos) {
      if (key.startsWith('Block')) {
        final bNum = key.split(' ')[1];
        _drawBlockNode(canvas, pos, 'B$bNum', destination == key);
      } else {
        _drawNode(canvas, pos, key.split(' ')[0], Colors.grey.shade700);
      }
    });

    // Draw Origin Green Pin
    canvas.drawCircle(startPos, 10, Paint()..color = Colors.green);
    canvas.drawCircle(startPos, 4, Paint()..color = Colors.white);

    // Draw Destination Red Pin
    canvas.drawCircle(endPos, 10, Paint()..color = Colors.red);
    canvas.drawCircle(endPos, 4, Paint()..color = Colors.white);
  }

  void _drawNode(Canvas canvas, Offset offset, String label, Color color) {
    canvas.drawCircle(offset, 13, Paint()..color = color);

    final textSpan = TextSpan(
      text: label,
      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
    );
    final tp = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(offset.dx - (tp.width / 2), offset.dy - (tp.height / 2)));
  }

  void _drawBlockNode(Canvas canvas, Offset offset, String label, bool isTarget) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: offset, width: 28, height: 22),
      const Radius.circular(6),
    );
    canvas.drawRRect(rrect, Paint()..color = isTarget ? Colors.red : Colors.indigo.shade800);

    final textSpan = TextSpan(
      text: label,
      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
    );
    final tp = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(offset.dx - (tp.width / 2), offset.dy - (tp.height / 2)));
  }

  @override
  bool shouldRepaint(covariant DynamicCampusMapPainter oldDelegate) {
    return oldDelegate.origin != origin || oldDelegate.destination != destination;
  }
}