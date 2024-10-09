import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider/provider.dart';
import 'package:todo/Provider/themeProvider.dart';
import 'package:todo/pages/addTodoPage.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/settingPage.dart';
import 'package:todo/pages/todoPage.dart';

void main() async {
  await Hive.initFlutter();

  // open the box
  await Hive.openBox('todoBox');
  runApp(
    ChangeNotifierProvider(
      create: (context) => Themeprovider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<Themeprovider>(context).themeData,
      home: const MainScreen(),
      routes: {
        "/addTodo": (context) => Addtodopage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

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
          const Settingpage(),
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
                  icon: Icon(Icons.edit_calendar_rounded, color: Colors.blue),
                  label: 'My Todo',
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
