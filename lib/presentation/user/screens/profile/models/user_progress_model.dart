class UserProgress {
  final int idiomsLearned;
  final int phrasesLearned;
  final int quizzesCompleted;
  final double averageScore;

  UserProgress({
    required this.idiomsLearned,
    required this.phrasesLearned,
    required this.quizzesCompleted,
    required this.averageScore,
  });

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      idiomsLearned: map['idioms_learned'] ?? 0,
      phrasesLearned: map['phrases_learned'] ?? 0,
      quizzesCompleted: map['quizzes_completed'] ?? 0,
      averageScore: (map['average_score'] ?? 0).toDouble(),
    );
  }
}
