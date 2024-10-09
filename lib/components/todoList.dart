import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todolist extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final DateTime startTime;
  final DateTime endTime;
  final Function(bool?)? onCheck;
  final VoidCallback? onTap;

  Todolist({
    Key? key,
    required this.taskName,
    required this.isCompleted,
    required this.startTime,
    required this.endTime,
    required this.onCheck,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onCheck,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatTime(startTime)} - ${_formatTime(endTime)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
}
