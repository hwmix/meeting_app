import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_app/providers/meeting_provider.dart';

class AddMeetingPage extends StatefulWidget {
  final Meeting? meeting;

  const AddMeetingPage({this.meeting, super.key});

  @override
  _AddMeetingPageState createState() => _AddMeetingPageState();
}

class _AddMeetingPageState extends State<AddMeetingPage> {
  final _titleController = TextEditingController();
  final _attendeesController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedType = 'Online';

  @override
  void initState() {
    super.initState();
    if (widget.meeting != null) {
      _titleController.text = widget.meeting!.title;
      _selectedDate = DateTime.parse(widget.meeting!.date);
      _selectedType = widget.meeting!.type;
      _attendeesController.text = widget.meeting!.maxAttendees.toString();
    }
  }

  void _saveMeeting() {
    if (_titleController.text.isEmpty ||
        _selectedDate == null ||
        _attendeesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณาเลือกวันที่จะประชุม")),
      );
      return;
    }

    final provider = Provider.of<MeetingProvider>(context, listen: false);
    int maxAttendees = int.tryParse(_attendeesController.text) ?? 1;

    if (widget.meeting == null) {
      provider.addMeeting(
        _titleController.text,
        _selectedDate!.toLocal().toString().split(' ')[0],
        _selectedType,
        maxAttendees,
      );
    } else {
      provider.updateMeeting(
        widget.meeting!.id,
        _titleController.text,
        _selectedDate!.toLocal().toString().split(' ')[0],
        _selectedType,
        maxAttendees,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.meeting == null
              ? "เพิ่มงานประชุม"
              : "แก้ไขรายละเอียดงานประชุม")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "ชื่องานประชุม",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() => _selectedDate = pickedDate);
                    }
                  },
                  child: Text(_selectedDate == null
                      ? "เลือกวันที่"
                      : "📅เลือกวันที่: ${_selectedDate!.toLocal()}"
                          .split(' ')[0]),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.category),
                  ),
                  onChanged: (value) {
                    setState(() => _selectedType = value!);
                  },
                  items: ['Online', 'Offline']
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _attendeesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "จำนวนผู้เข้าร่วมทั้งหมด",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveMeeting,
                  child: const Text("Save Meeting"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
