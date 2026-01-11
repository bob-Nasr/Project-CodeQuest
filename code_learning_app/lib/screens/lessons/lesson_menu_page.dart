import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../home/main_menu_page.dart';
import '../reading/reading_page.dart';
import '../quiz/quiz_page.dart';

class LessonMenuPage extends StatefulWidget {
  final int courseId;
  final String courseTitle;

  const LessonMenuPage({
    super.key,
    required this.courseId,
    required this.courseTitle,
  });

  @override
  State<LessonMenuPage> createState() => _LessonMenuPageState();
}

class _LessonMenuPageState extends State<LessonMenuPage> {
  List objectives = [];
  List results = [];
  bool loading = true;

  Future<void> loadObjectives() async {
    final response = await http.get(
      Uri.parse(
        'http://127.0.0.1:8000/course/get_course_details.php'
        '?courseId=${widget.courseId}&type=objective',
      ),
    );

    final data = jsonDecode(response.body);

    setState(() {
      objectives = data['data'] ?? [];
      loading = false;
    });
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> loadResults() async {
    final userId = await getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    final response = await http.get(
      Uri.parse(
        'http://127.0.0.1:8000/course/get_results.php?courseId=${widget.courseId}&userId=$userId',
      ),
    );

    final data = jsonDecode(response.body);
    setState(() {
      results = data['data'] ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    loadObjectives();
    loadResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainMenuPage()),
              (route) => false,
            );
          },
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Objectives",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...objectives.map(
                    (o) => ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(o['text'] ?? ''),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (results.isNotEmpty) ...[
                    const Text(
                      "Latest Results",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...results.map((r) => ListTile(
                          leading: const Icon(Icons.emoji_events),
                          title: Text("Score: ${r['result']}"),
                          subtitle: Text("Date: ${r['timestamp']}"),
                        )),
                    const SizedBox(height: 20),
                  ],
                  const Spacer(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.menu_book),
                    label: const Text("Start Reading"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonReadingPage(
                            courseId: widget.courseId,
                            courseTitle: widget.courseTitle,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.quiz),
                    label: const Text("Start Quiz"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonQuizPage(
                            courseId: widget.courseId,
                            courseTitle: widget.courseTitle,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
