// lib/create_question_screen.dart

import 'package:flutter/material.dart';
import 'question_model.dart';

class CreateQuestionScreen extends StatefulWidget {
  final String className;
  final String classCode;

  const CreateQuestionScreen({
    super.key,
    required this.className,
    required this.classCode,
  });

  @override
  State<CreateQuestionScreen> createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  // Daftar semua soal yang sedang dibuat
  final List<QuestionData> _questions = [
    QuestionData(
      titleController: TextEditingController(),
      questionController: TextEditingController(),
      imageUrl: null,
      options: [
        AnswerOption(text: 'Option A', index: 0),
        AnswerOption(text: 'Option B', index: 1),
      ],
      correctAnswers: [],
    ),
  ];

  @override
  void dispose() {
    for (var q in _questions) {
      q.titleController.dispose();
      q.questionController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Question'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Render setiap soal
              for (int i = 0; i < _questions.length; i++)
                _buildQuestionCard(i),

              const SizedBox(height: 20),

              // Tombol "Add Another Question"
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _questions.add(
                        QuestionData(
                          titleController: TextEditingController(),
                          questionController: TextEditingController(),
                          imageUrl: null,
                          options: [
                            AnswerOption(text: 'Option A', index: 0),
                            AnswerOption(text: 'Option B', index: 1),
                          ],
                          correctAnswers: [],
                        ),
                      );
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.indigo),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '+ Add Another Question',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol "Save All Questions"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_questions.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No questions to save')),
                      );
                      return;
                    }

                    bool isValid = true;
                    for (var q in _questions) {
                      if (q.titleController.text.isEmpty || q.questionController.text.isEmpty) {
                        isValid = false;
                        break;
                      }
                      if (q.correctAnswers.isEmpty) {
                        isValid = false;
                        break;
                      }
                    }

                    if (!isValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields and mark correct answers')),
                      );
                      return;
                    }

                    // Simulasikan simpan semua soal
                    for (var q in _questions) {
                      final newQuestion = QuestionModel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: q.titleController.text,
                        questionText: q.questionController.text,
                        imageUrl: q.imageUrl,
                        options: q.options,
                        correctAnswers: q.correctAnswers,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Saved: ${newQuestion.title}')),
                      );
                    }

                    // Reset form jika ingin tambah soal lagi
                    setState(() {
                      _questions.clear();
                      _questions.add(
                        QuestionData(
                          titleController: TextEditingController(),
                          questionController: TextEditingController(),
                          imageUrl: null,
                          options: [
                            AnswerOption(text: 'Option A', index: 0),
                            AnswerOption(text: 'Option B', index: 1),
                          ],
                          correctAnswers: [],
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save All Questions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = _questions[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header "Question X"
            Text(
              'Question ${index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 8),

            // Title Input
            TextField(
              controller: question.titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'e.g., Math Quiz #1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Question Input
            const Text(
              'Question',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: question.questionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter your question here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Image Upload
            const Text(
              'Image (Optional)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  question.imageUrl = 'https://via.placeholder.com/300.png?text=Uploaded+Image';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image uploaded')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.upload_file, color: Colors.indigo),
              label: const Text(
                'Upload Image',
                style: TextStyle(color: Colors.indigo),
              ),
            ),
            if (question.imageUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.network(
                      question.imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 40);
                      },
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Answer Options Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Answer Options',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      question.options.add(
                        AnswerOption(
                          text: 'Option ${String.fromCharCode(65 + question.options.length)}',
                          index: question.options.length,
                        ),
                      );
                    });
                  },
                  child: const Text(
                    '+ Add Option',
                    style: TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Daftar Opsi Jawaban
            // PERBAIKAN #1: Menghapus variabel 'option' yang tidak digunakan
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: question.options.length,
              itemBuilder: (context, optIndex) {
                return Row(
                  children: [
                    Text('${String.fromCharCode(65 + optIndex)}.'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            question.options[optIndex] = AnswerOption(text: value, index: optIndex);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Option ${String.fromCharCode(65 + optIndex)}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Checkbox(
                      value: question.correctAnswers.contains(optIndex),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            question.correctAnswers.add(optIndex);
                          } else {
                            question.correctAnswers.remove(optIndex);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        if (question.options.length > 2) {
                          setState(() {
                            question.options.removeAt(optIndex);
                            question.correctAnswers.removeWhere((i) => i == optIndex);
                            // Perbarui index semua opsi setelahnya
                            for (int i = optIndex; i < question.options.length; i++) {
                              question.options[i] = AnswerOption(
                                text: question.options[i].text,
                                index: i,
                              );
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Minimum 2 options required')),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),

            // Info: Tap the ✓ icon
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Tap the ✓ icon to mark correct answer(s)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class untuk menyimpan data satu soal
class QuestionData {
  final TextEditingController titleController;
  final TextEditingController questionController;
  String? imageUrl;
  List<AnswerOption> options;
  List<int> correctAnswers;

  QuestionData({
    required this.titleController,
    required this.questionController,
    required this.imageUrl,
    required this.options,
    required this.correctAnswers,
  });
}