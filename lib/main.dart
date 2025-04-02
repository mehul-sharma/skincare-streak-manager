import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase
import 'screens/daily_skincare_page.dart';
import 'screens/streak_manager_page.dart';
import 'widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDcoAOnEpHKP5wuo8yA9s33pASrXAe1ZIs",
          authDomain: "skincare-streak-manager.firebaseapp.com",
          projectId: "skincare-streak-manager",
          storageBucket: "skincare-streak-manager.firebasestorage.app",
          messagingSenderId: "938149549428",
          appId: "1:938149549428:web:35db1b6ddc5ac45c3a4821",
          measurementId: "G-WF9M5X04E2"
      ),
    );
    print("✅ Firebase initialized successfully!");
  }
  catch (e) {
    print("❌ Firebase initialization failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of Screens
  final List<Widget> _screens = [
    DailySkincareScreen(),
    StreakManagerScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],  // Display selected screen
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
