import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LessonReadingPage extends StatefulWidget {
  final int courseId;
  final String courseTitle;

  const LessonReadingPage({
    super.key,
    required this.courseId,
    required this.courseTitle,
  });

  @override
  State<LessonReadingPage> createState() => _LessonReadingPageState();
}

class _LessonReadingPageState extends State<LessonReadingPage> {
  List readings = [];
  int currentIndex = 0;
  bool loading = true;

  Future<void> loadReadings() async {
    final response = await http.get(
      Uri.parse(
        'http://127.0.0.1:8000/course/get_course_details.php'
        '?courseId=${widget.courseId}&type=reading',
      ),
    );

    final data = jsonDecode(response.body);

    setState(() {
      readings = data['data'] ?? [];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadReadings();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final current = readings[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              current['text'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Text(
              "${currentIndex + 1} / ${readings.length}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: Text(
                currentIndex == readings.length - 1 ? "Finish" : "Next",
              ),
              onPressed: () {
                if (currentIndex < readings.length - 1) {
                  setState(() => currentIndex++);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
