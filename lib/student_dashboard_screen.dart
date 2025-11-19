import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan ini untuk Consumer
import 'profile_model.dart'; // Tambahkan ini untuk mengakses ProfileModel
import 'join_class_modal.dart';
import 'class_details_screen.dart'; // Import halaman detail kelas
import 'edit_profile_screen.dart'; // ✅ Import benar
import 'settings_screen.dart';     // ✅ Import benar

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileModel>(context); // Ambil instance ProfileModel

    return Scaffold(
      appBar: AppBar(
        // Gunakan Consumer untuk memperbarui judul secara otomatis
        title: Consumer<ProfileModel>(
          builder: (context, profile, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, ${profile.name}'), // Nama dinamis dari model
                Text(
                  'Student Dashboard',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()), // Tambahkan const
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()), // Tambahkan const
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
                      builder: (context) => const JoinClassModal(),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Tampilkan daftar kelas atau pesan "No classes yet"
            if (profile.joinedClasses.isEmpty)
              Expanded(
                child: Center(
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
                        'Join a class using the code from your teacher',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: profile.joinedClasses.length,
                  itemBuilder: (context, index) {
                    final cls = profile.joinedClasses[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.menu_book_outlined, color: Colors.green),
                        ),
                        title: Text(cls.name),
                        subtitle: Text('Code: ${cls.code} • ${cls.questionCount} questions'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          // Buka halaman detail kelas
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClassDetailsScreen(
                                className: cls.name,
                                classCode: cls.code,
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