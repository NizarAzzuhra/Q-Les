// lib/class_detail_teacher_screen.dart

import 'package:flutter/material.dart';
import 'comment_model.dart';

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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
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
                              senderName: 'Teacher Demo',
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