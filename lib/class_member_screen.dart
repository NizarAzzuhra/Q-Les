// lib/class_members_screen.dart

import 'package:flutter/material.dart';

class ClassMembersScreen extends StatelessWidget {
  final String className;
  final String classCode;

  const ClassMembersScreen({
    super.key,
    required this.className,
    required this.classCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Class Name + Member
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.people, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Member',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Bagian Teacher
              const Text(
                'Teacher',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: const Text('A', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    const Text('Pak Agung'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bagian Student
              const Text(
                'Student',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  children: [
                    ..._getStudentList().map((name) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _getColorForName(name),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: _getColorForName(name),
                              child: Text(
                                name[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(name),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getStudentList() {
    return [
      'Aurelia', 'Samuel', 'Amad', 'Awa', 'Denis', 'Nizar', 'Reina', 'Fazle',
      'Nesya', 'Azkya', 'Naswa', 'Julio', 'Chikal', 'Syafira', 'Zafar', 'Khanza'
    ];
  }

  Color _getColorForName(String name) {
    final hash = name.hashCode % 10;
    final colors = [
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blue,
      Colors.teal,
      Colors.brown,
      Colors.amber,
      Colors.red,
      Colors.indigo,
      Colors.pink,
    ];
    return colors[hash];
  }
}