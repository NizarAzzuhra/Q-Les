// lib/class_model.dart

class ClassModel {
  final String id;
  final String name;
  final String code;
  final int questionCount;

  ClassModel({
    required this.id,
    required this.name,
    required this.code,
    this.questionCount = 0,
  });

  // Data demo untuk kelas guru
  static List<ClassModel> getDemoClasses() {
    return [
      ClassModel(id: '1', name: 'Class 10A', code: 'ABC123', questionCount: 0),
      ClassModel(id: '2', name: 'Class 11B', code: 'XYZ789', questionCount: 0),
    ];
  }
}