// lib/class_details_student_screen.dart

import 'package:flutter/material.dart';
import 'comments_screen.dart'; // Untuk tombol komentar
import 'class_member_student_screen.dart'; // Untuk tombol daftar member

class ClassDetailsStudentScreen extends StatelessWidget {
  final String className;
  final String classCode;

  const ClassDetailsStudentScreen({
    super.key,
    required this.className,
    required this.classCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(className),
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
              // Informasi kelas
              Text(
                'Class Code: $classCode',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),

              // Tombol "View Comments"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          className: className,
                          classCode: classCode,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text(
                    'View Comments',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Area "No questions yet"
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.question_mark,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No question yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your teacher hasn\'t added any question yet',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Ikon orang di pojok kanan bawah
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    // Navigasi ke ClassMembersStudentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassMembersStudentScreen(
                          className: className,
                          classCode: classCode,
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.indigo,
                  child: const Icon(Icons.people, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}