import 'package:flutter/material.dart';
import 'package:image_api_create/screens/home_page.dart';
import 'package:image_api_create/screens/topheadline_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> bottomScreen = [
    const HomePage(),
    const TopHeadLineScreen(),
  ];
  void onTapChangeScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("All News"),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 65, 80, 107),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapChangeScreen,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Search detail News",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "News Headlines",
          )
        ],
      ),
      body: bottomScreen[_currentIndex],
    );
  }
}
