import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../quiz/result_page.dart';

class LessonQuizPage extends StatefulWidget {
  final int courseId;
  final String courseTitle;

  const LessonQuizPage({
    super.key,
    required this.courseId,
    required this.courseTitle,
  });

  @override
  State<LessonQuizPage> createState() => _LessonQuizPageState();
}

class _LessonQuizPageState extends State<LessonQuizPage> {
  List questions = [];
  int index = 0;
  int mistakes = 0;
  int correct = 0;
  bool loading = true;

  Future<void> loadQuiz() async {
    final response = await http.get(
      Uri.parse(
        'http://127.0.0.1:8000/course/get_course_details.php'
        '?courseId=${widget.courseId}&type=question',
      ),
    );

    final data = jsonDecode(response.body);
    List all = data['data'] ?? [];

    all.shuffle(Random());

    setState(() {
      questions = all.take(5).toList();
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.courseTitle)),
        body: const Center(
          child: Text("No quiz questions available."),
        ),
      );
    }

    final q = questions[index];
    final choices = jsonDecode(q['choices']);
    final correctIndex = int.parse(q['answer'].toString());

    Future<int?> getUserId() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('userId');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text("Mistakes: $mistakes/3"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              q['text'],
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Add buttons with spacing
            ...choices.map<Widget>(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  child: Text(c),
                  onPressed: () async {
                    final selectedIndex = choices.indexOf(c);
                    if (selectedIndex != correctIndex) {
                      mistakes++;
                    } else {
                      correct++;
                    }

                    if (mistakes >= 3 || index == questions.length - 1) {
                      // Insert result into DB
                      final userId = await getUserId();

                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User not logged in")),
                        );
                        return;
                      }
                      final response = await http.post(
                        Uri.parse(
                            'http://127.0.0.1:8000/course/insert_result.php'),
                        headers: {'Content-Type': 'application/json'},
                        body: jsonEncode({
                          'courseId': widget.courseId,
                          'userId': userId,
                          'result': correct,
                        }),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultPage(
                            courseId: widget.courseId,
                            courseTitle: widget.courseTitle,
                            totalQuestions: questions.length,
                            correct: correct,
                            mistakes: mistakes,
                          ),
                        ),
                      );
                    } else {
                      setState(() => index++);
                    }
                  },
                ),
              ),
            ),
            const Spacer(),
            LinearProgressIndicator(
              value: (index + 1) / questions.length,
            ),
          ],
        ),
      ),
    );
  }
}
