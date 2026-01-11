import 'package:flutter/material.dart';
import '../lessons/lesson_menu_page.dart';

class ResultPage extends StatelessWidget {
  final int courseId;
  final String courseTitle;
  final int totalQuestions;
  final int correct;
  final int mistakes;

  const ResultPage({
    super.key,
    required this.courseId,
    required this.courseTitle,
    required this.totalQuestions,
    required this.correct,
    required this.mistakes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$courseTitle - Quiz Result"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => LessonMenuPage(
                  courseId: courseId,
                  courseTitle: courseTitle,
                ),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Quiz Completed!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text("Total Questions: $totalQuestions",
                style: const TextStyle(fontSize: 18)),
            Text("Correct Answers: $correct",
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            Text("Mistakes: $mistakes",
                style: const TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Back to Lesson"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LessonMenuPage(
                      courseId: courseId,
                      courseTitle: courseTitle,
                    ),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
