import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/bookmark_provider.dart';
import '../routes/app_routes.dart';
import 'room_status_sheet.dart';

class FacultyDetailScreen extends StatelessWidget {
  final String deptId;
  final Map<String, dynamic>? deptData;

  const FacultyDetailScreen({
    super.key,
    required this.deptId,
    this.deptData,
  });

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final String deptName = deptData?['name'] ?? 'Department Details';
    final String blockName = deptData?['block'] ?? 'Campus';
    final int floor = deptData?['floor'] ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(deptName),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              bookmarkProvider.isBookmarked(deptId)
                  ? Icons.bookmark
                  : Icons.bookmark_border,
            ),
            onPressed: () {
              bookmarkProvider.toggleBookmark(
                BookmarkItem(
                  id: deptId,
                  title: deptName,
                  subtitle: blockName,
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('faculty')
            .where('deptId', isEqualTo: deptId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: Colors.indigo.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deptName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text("Location: $blockName, Floor $floor"),
                      const SizedBox(height: 4),
                      Text("${deptData?['description'] ?? ''}"),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.directions, size: 18),
                        label: const Text('Get Walking Directions'),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.mapRoute,
                            arguments: {
                              'name': deptName,
                              'block': blockName,
                              'floor': floor,
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Faculty & Staff Directory",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (docs.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text("No faculty records linked to this branch yet."),
                  ),
                )
              else
                ...docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final bool isAvail = data['isAvailable'] ?? false;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(data['name'] ?? ''),
                      subtitle: Text(
                        "${data['designation'] ?? ''}\nRoom: ${data['roomNumber'] ?? 'N/A'}",
                      ),
                      isThreeLine: true,
                      trailing: Chip(
                        label: Text(
                          isAvail ? 'Available' : 'Busy',
                          style: TextStyle(
                            fontSize: 11,
                            color: isAvail
                                ? Colors.green.shade800
                                : Colors.red.shade800,
                          ),
                        ),
                        backgroundColor:
                            isAvail ? Colors.green.shade100 : Colors.red.shade100,
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.meeting_room),
        label: const Text('Live Room Tracker'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (ctx) => FractionallySizedBox(
              heightFactor: 0.65,
              child: RoomStatusSheet(
                deptId: deptId,
                deptName: deptName,
              ),
            ),
          );
        },
      ),
    );
  }
}