// lib/question_model.dart

class QuestionModel {
  final String id;
  final String title;
  final String questionText;
  final String? imageUrl;
  final List<AnswerOption> options;
  final List<int> correctAnswers; // Index dari opsi yang benar

  QuestionModel({
    required this.id,
    required this.title,
    required this.questionText,
    this.imageUrl,
    required this.options,
    required this.correctAnswers,
  });

  // Untuk simulasi, kita buat beberapa soal demo
  static List<QuestionModel> getDemoQuestions() {
    return [
      QuestionModel(
        id: '1',
        title: 'Math Quiz', // Diubah sesuai gambar
        questionText: 'What is 1 + 3?', // Diubah sesuai gambar
        imageUrl: null,
        options: [
          AnswerOption(text: '2', index: 0),
          AnswerOption(text: '4', index: 1), // Jawaban benar
          AnswerOption(text: '5', index: 2),
          AnswerOption(text: '6', index: 3),
        ],
        correctAnswers: [1], // Jawaban B (indeks 1)
      ),
    ];
  }
}

class AnswerOption {
  final String text;
  final int index;

  AnswerOption({required this.text, required this.index});
}