import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meeting_app/pages/home_page.dart';
import 'package:meeting_app/providers/meeting_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MeetingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meeting App',
        theme: ThemeData(
          primarySwatch: Colors.blue, // สีหลักของแอป
          fontFamily: 'Arial', // ตั้งค่าฟอนต์เริ่มต้น
          brightness: Brightness.light, // ธีมโหมดสว่าง
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark, // รองรับ Dark Mode
        ),
        themeMode: ThemeMode.system, // เปลี่ยนตามระบบของมือถือ
        home: const HomePage(),
      ),
    );
  }
}
