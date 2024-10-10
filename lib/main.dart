import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/themeProvider.dart';
import 'package:todo/pages/addTodoPage.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/settingPage.dart';
import 'package:todo/pages/todoPage.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fr'), Locale('sw')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
        create: (context) => Themeprovider(),
        child: const MyApp(),
      ),
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
        "/addTodo": (context) => const Addtodopage(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
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
          Settingpage(),
        ],
      ),
      bottomNavigationBar: _selectedIndex != 0
          ? LocalizedBottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            )
          : null,
    );
  }
}

class LocalizedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const LocalizedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, color: Colors.blue),
          label: 'home'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.edit_calendar_rounded, color: Colors.blue),
          label: 'my_todo'.tr(),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings, color: Colors.blue),
          label: 'settings'.tr(),
        ),
      ],
    );
  }
}
