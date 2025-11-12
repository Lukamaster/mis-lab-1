import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget {
  const ExamListScreen({super.key});

  List<Exam> _getExams() {
    final now = DateTime.now();
    return [
      // Past exams
      Exam(
        subjectName: 'Програмирање',
        dateTime: DateTime(now.year, now.month, now.day - 5, 9, 0),
        rooms: ['101', '102'],
      ),
      Exam(
        subjectName: 'Калкулус',
        dateTime: DateTime(now.year, now.month, now.day - 3, 10, 30),
        rooms: ['Амфитеатар 1'],
      ),
      Exam(
        subjectName: 'Бази на податоци',
        dateTime: DateTime(now.year, now.month, now.day - 2, 14, 0),
        rooms: ['203', '204'],
      ),
      Exam(
        subjectName: 'Веб дизајн',
        dateTime: DateTime(now.year, now.month, now.day - 1, 11, 0),
        rooms: ['Лабораторија 3'],
      ),
      // Future exams
      Exam(
        subjectName: 'Оперативни системи',
        dateTime: DateTime(now.year, now.month, now.day + 2, 9, 0),
        rooms: ['Амфитеатар 2'],
      ),
      Exam(
        subjectName: 'Компјутерски мрежи',
        dateTime: DateTime(now.year, now.month, now.day + 3, 13, 30),
        rooms: ['301', '302'],
      ),
      Exam(
        subjectName: 'Софтверско инженерство',
        dateTime: DateTime(now.year, now.month, now.day + 5, 10, 0),
        rooms: ['Лабораторија 1', 'Лабораторија 2'],
      ),
      Exam(
        subjectName: 'Алгоритми и податочни структури',
        dateTime: DateTime(now.year, now.month, now.day + 7, 14, 30),
        rooms: ['Амфитеатар 1'],
      ),
      Exam(
        subjectName: 'Управување со ИКТ проекти',
        dateTime: DateTime(now.year, now.month, now.day + 10, 9, 30),
        rooms: ['201'],
      ),
      Exam(
        subjectName: 'Машинско учење',
        dateTime: DateTime(now.year, now.month, now.day + 12, 11, 0),
        rooms: ['Лабораторија 4'],
      ),
      Exam(
        subjectName: 'Мобилни информациски системи',
        dateTime: DateTime(now.year, now.month, now.day + 15, 13, 0),
        rooms: ['Амфитеатар 3'],
      ),
      Exam(
        subjectName: 'Дискретна математика',
        dateTime: DateTime(now.year, now.month, now.day + 18, 10, 0),
        rooms: ['102', '103'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final exams = _getExams();

    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Распоред за испити - 191572'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(
                  exam: exams[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamDetailScreen(exam: exams[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Center(
              child: Chip(
                label: Text(
                  'Вкупно испити: ${exams.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

