import 'package:flutter/material.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/settingsPage.dart';
import 'package:todo/pages/todoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      theme: ThemeData.light(), // Using light theme by default
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Homepage(onGetStarted: () => _onItemTapped(1)),
          const Todopage(),
          const Settingspage(),
        ],
      ),
      bottomNavigationBar: _selectedIndex != 0
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.blue),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box, color: Colors.blue),
                  label: 'Add New Task',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings, color: Colors.blue),
                  label: 'Settings',
                ),
              ],
            )
          : null,
    );
  }
}
