import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class Todolist extends StatefulWidget {
  final String taskName;
  final String description;
  final bool isCompleted;
  final DateTime? startTime;
  final DateTime? endTime;
  final String priority;
  final Function(bool?)? onCheck;
  final VoidCallback? onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const Todolist({
    Key? key,
    required this.taskName,
    required this.description,
    required this.isCompleted,
    this.startTime,
    this.endTime,
    required this.priority,
    required this.onCheck,
    required this.onDelete,
    required this.onEdit,
    this.onTap,
  }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  bool _isExpanded = false;

  Color _getPriorityColor() {
    switch (widget.priority.toLowerCase()) {
      case 'high':
        return Colors.red.shade200;
      case 'medium':
        return Colors.orange.shade200;
      case 'low':
        return Colors.green.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.taskName),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => widget.onDelete(),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color:
                      widget.isCompleted ? Colors.grey.shade100 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: widget.isCompleted,
                      onChanged: widget.onCheck,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.taskName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: widget.isCompleted
                                        ? Colors.grey[600]
                                        : Colors.black,
                                    decoration: widget.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  widget.priority.tr(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.isCompleted
                                  ? Colors.grey
                                  : Colors.grey[700],
                            ),
                            maxLines: _isExpanded ? null : 2,
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          if (widget.startTime != null &&
                              widget.endTime != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  '${_formatTime(widget.startTime!)} - ${_formatTime(widget.endTime!)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: widget.isCompleted
                                        ? Colors.grey
                                        : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: widget.onEdit,
                    ),
                  ],
                ),
              ),
              if (_isExpanded && widget.description.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[50],
                  child: Text(
                    widget.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
}
