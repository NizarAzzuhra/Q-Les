// lib/teacher_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan import provider untuk ProfileModel
import 'add_class_model.dart'; // Pastikan nama file benar (bukan add_class_model)
import 'class_detail_teacher_screen.dart'; // Ganti ke file yang baru
import 'class_model.dart';
import 'settings_teacher_screen.dart'; // Import halaman settings guru
import 'edit_profile_teacher_screen.dart'; // Import halaman edit profil guru
import 'profile_model.dart'; // Import ProfileModel

class TeacherDashboardScreen extends StatefulWidget {
  const TeacherDashboardScreen({super.key});

  @override
  State<TeacherDashboardScreen> createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  final List<ClassModel> _classes = ClassModel.getDemoClasses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProfileModel>( // Gunakan Consumer untuk menampilkan nama dari ProfileModel
              builder: (context, profile, child) {
                return Text('Hello, ${profile.name}');
              },
            ),
            Text(
              'Teacher Dashboard',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              // Buka profile screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileTeacherScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Navigasi ke SettingsTeacherScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Classes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddClassModal(
                        onAddClass: (newClass) {
                          setState(() {
                            _classes.add(newClass);
                          });
                        },
                      ),
                    );
                  },
                  backgroundColor: Colors.indigo,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _classes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu_book_outlined,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No classes yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create your first class to start teaching',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _classes.length,
                      itemBuilder: (context, index) {
                        final classData = _classes[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo[100],
                              child: Icon(
                                Icons.menu_book_outlined,
                                color: Colors.indigo[800],
                              ),
                            ),
                            title: Text(classData.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Code: ${classData.code}'),
                                Text(
                                  '${classData.questionCount} questions',
                                  style: const TextStyle(color: Colors.indigo),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClassDetailTeacherScreen(
                                    className: classData.name,
                                    classCode: classData.code,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}