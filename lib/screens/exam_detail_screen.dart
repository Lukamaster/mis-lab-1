import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({
    super.key,
    required this.exam,
  });

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day.$month.$year';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getTimeRemaining() {
    final now = DateTime.now();
    final examDateTime = exam.dateTime;

    if (examDateTime.isBefore(now)) {
      return 'Испитот е завршен';
    }

    final difference = examDateTime.difference(now);

    if (difference.inDays == 0 && difference.inHours == 0) {
      if (difference.inMinutes <= 0) {
        return 'Испитот е завршен';
      }
      return 'Испитот е денес';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;

    if (days == 0) {
      return '$hours ${hours == 1 ? 'час' : 'часа'}';
    } else if (hours == 0) {
      return '$days ${days == 1 ? 'ден' : 'дена'}';
    } else {
      return '$days ${days == 1 ? 'ден' : 'дена'}, $hours ${hours == 1 ? 'час' : 'часа'}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPast = exam.isPast();
    final cardColor = isPast ? Colors.grey[200] : Colors.blue[50];
    final textColor = isPast ? Colors.grey[700] : Colors.blue[900];
    final accentColor = isPast ? Colors.grey : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за испит'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: cardColor,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subject name - large and prominent
                  Text(
                    exam.subjectName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Date section
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 24,
                        color: accentColor,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Дата:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _formatDate(exam.dateTime),
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Time section
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 24,
                        color: accentColor,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Време:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _formatTime(exam.dateTime),
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Rooms section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 24,
                        color: accentColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Сали:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ...exam.rooms.map((room) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    '• $room',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: textColor,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Time remaining section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isPast ? Colors.grey[300] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Преостанато време:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getTimeRemaining(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

