import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // <- added

import '../lessons/lesson_menu_page.dart';
import '../auth/login_page.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List courses = [];
  bool loading = true;

  Future<void> fetchCourses() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/course/get_courses.php'),
    );

    final data = jsonDecode(response.body);
    setState(() {
      courses = data['courses'];
      loading = false;
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Language"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(courses[index]['courseName']),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    final course = courses[index];
                    final int courseId =
                        int.tryParse(course['courseId'].toString()) ?? 0;

                    if (courseId == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid course ID")),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LessonMenuPage(
                          courseId: courseId,
                          courseTitle: course['name'] ?? 'Course',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
