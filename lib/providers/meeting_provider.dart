import 'package:flutter/material.dart';

class Meeting {
  int id;
  String title;
  String date;
  String type;
  int maxAttendees;

  Meeting({
    required this.id,
    required this.title,
    required this.date,
    required this.type,
    required this.maxAttendees,
  });
}

class MeetingProvider extends ChangeNotifier {
  List<Meeting> _meetings = [];
  int _nextId = 1;

  List<Meeting> get meetings => _meetings;

  void addMeeting(String title, String date, String type, int maxAttendees) {
    _meetings.add(Meeting(
      id: _nextId++,
      title: title,
      date: date,
      type: type,
      maxAttendees: maxAttendees,
    ));
    notifyListeners();
  }

  void updateMeeting(
      int id, String title, String date, String type, int maxAttendees) {
    int index = _meetings.indexWhere((meeting) => meeting.id == id);
    if (index != -1) {
      _meetings[index] = Meeting(
        id: id,
        title: title,
        date: date,
        type: type,
        maxAttendees: maxAttendees,
      );
      notifyListeners();
    }
  }

  void deleteMeeting(int id) {
    _meetings.removeWhere((meeting) => meeting.id == id);
    notifyListeners();
  }
}
