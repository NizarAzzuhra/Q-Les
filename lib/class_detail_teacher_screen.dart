// lib/class_details_teacher_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan ini untuk akses ProfileModel jika diperlukan
import 'comment_model.dart';
import 'create_question_screen.dart'; // Untuk tombol "+ Add Question"
import 'question_model.dart'; // Untuk daftar kuis
// Perbaiki import di bawah ini
import 'class_member_screen.dart'; // <-- Nama file yang benar

class ClassDetailTeacherScreen extends StatefulWidget {
  final String className;
  final String classCode;

  const ClassDetailTeacherScreen({
    super.key,
    required this.className,
    required this.classCode,
  });

  @override
  State<ClassDetailTeacherScreen> createState() => _ClassDetailTeacherScreenState();
}

class _ClassDetailTeacherScreenState extends State<ClassDetailTeacherScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<CommentModel> _comments = CommentModel.getDemoComments();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data kuis demo
    final questions = QuestionModel.getDemoQuestions();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.className),
            Text(
              'Code: ${widget.classCode}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol "+ Add Question"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateQuestionScreen(
                          className: widget.className,
                          classCode: widget.classCode,
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
                  icon: const Icon(Icons.add),
                  label: const Text(
                    '+ Add Question',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Daftar Kuis
              if (questions.isNotEmpty)
                ...questions.map((question) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                child: const Icon(Icons.question_mark, color: Colors.blue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      question.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          '${question.options.length} option',
                                          style: const TextStyle(color: Colors.blue),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          '${question.correctAnswers.length} correct answer',
                                          style: const TextStyle(color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Edit soal — bisa navigasi ke CreateQuestionScreen dengan data soal
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Edit ${question.title}')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              const SizedBox(height: 20),

              // Bagian Komentar
              const Text(
                'Comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: comment.role == 'Teacher'
                          ? Colors.blue[50]
                          : Colors.grey[50],
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.brown,
                                  child: Text(
                                    comment.senderName[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: comment.senderName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: ' • ',
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: comment.role,
                                              style: TextStyle(
                                                color: comment.role == 'Teacher'
                                                    ? Colors.green
                                                    : Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'send ${_formatTimeAgo(comment.sendTime)}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              comment.message,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Input Komentar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Add class comments...',
                          filled: true,
                          fillColor: Colors.blue[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton.small(
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          setState(() {
                            _comments.add(
                              CommentModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                senderName: 'Teacher Demo', // Ganti dengan nama dari ProfileModel jika diperlukan
                                role: 'Teacher',
                                message: _commentController.text,
                                sendTime: DateTime.now(),
                              ),
                            );
                            _commentController.clear();
                          });
                        }
                      },
                      backgroundColor: Colors.indigo,
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Tambahkan ikon orang di pojok kanan bawah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Perbaiki pemanggilan kelas di bawah ini
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassMembersScreen( // <-- Nama kelas yang benar
                className: widget.className,
                classCode: widget.classCode,
              ),
            ),
          );
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.people, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}