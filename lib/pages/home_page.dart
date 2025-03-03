import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_app/providers/meeting_provider.dart';
import 'add_meeting_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final meetingProvider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("📅 งานประชุม")),
      body: meetingProvider.meetings.isEmpty
          ? const Center(
              child: Text("ไม่มีงานประชุม", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: meetingProvider.meetings.length,
              itemBuilder: (context, index) {
                final meeting = meetingProvider.meetings[index];

                return Dismissible(
                  key: Key(meeting.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Delete"),
                          content: Text(
                              "คุณแน่ใจนะว่าจะลบงานประชุม '${meeting.title}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                meetingProvider.deleteMeeting(meeting.id);
                                Navigator.of(context).pop(true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Deleted: ${meeting.title}")),
                                );
                              },
                              child: const Text("Delete",
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(meeting.title),
                      subtitle: Text(
                          "📅 ${meeting.date} | 👥 ${meeting.maxAttendees}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddMeetingPage(meeting: meeting),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMeetingPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
