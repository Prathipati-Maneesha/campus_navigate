import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Help Desks'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('emergency_desks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(child: Text("No emergency contacts listed."));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = docs[index].data() as Map<String, dynamic>;
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.emergency, color: Colors.white),
                  ),
                  title: Text(
                    item['title'] ?? 'Help Desk',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("${item['location'] ?? ''}\nTel: ${item['phone'] ?? ''}"),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}