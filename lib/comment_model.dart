// lib/comment_model.dart

class CommentModel {
  final String id;
  final String senderName;
  final String role; // "Teacher" atau "Student"
  final String message;
  final DateTime sendTime;

  CommentModel({
    required this.id,
    required this.senderName,
    required this.role,
    required this.message,
    required this.sendTime,
  });

  // Data demo
  static List<CommentModel> getDemoComments() {
    return [
      CommentModel(
        id: '1',
        senderName: 'Pak Agung',
        role: 'Teacher',
        message: 'Selamat dan Semangat mengerjakan anak-anak.',
        sendTime: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }
}