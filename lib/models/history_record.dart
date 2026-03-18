class HistoryRecord {
  int? id;
  String title;
  String description;
  DateTime date;
  bool isCompleted;
  String cycles;
  int totalTime;
  bool isPinned;

  HistoryRecord({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.cycles,
    required this.totalTime,
    required this.isPinned,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'isCompleted': isCompleted ? 1 : 0,
    'cycles': cycles,
    'totalTime': totalTime,
    'isPinned': isPinned ? 1 : 0,
  };

  factory HistoryRecord.fromMap(Map<String, dynamic> map) => HistoryRecord(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    date: DateTime.parse(map['date']),
    isCompleted: map['isCompleted'] == 1,
    cycles: map['cycles'],
    totalTime: map['totalTime'],
    isPinned: map['isPinned'] == 1,
  );
}
