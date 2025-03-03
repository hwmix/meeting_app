class Meeting {
  int? id;
  String title;
  String date;
  String type;

  Meeting({
    this.id,
    required this.title,
    required this.date,
    required this.type,
  });

  // Convert Meeting Object to Map (For SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'type': type,
    };
  }

  // Convert Map to Meeting Object
  factory Meeting.fromMap(Map<String, dynamic> map) {
    return Meeting(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      type: map['type'],
    );
  }
}
