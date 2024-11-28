import 'package:flutter/material.dart';
import 'package:netflix/screens/homescreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/screens/new_&_hot_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  // Define screens for each tab
  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('Library')),
    const NewAndHotScreen(),
    const Center(child: Text('Search')),
    const Center(child: Text('Downloads')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gamepad), label: 'Game'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined), label: 'New & Hot'),
          BottomNavigationBarItem(
              icon: Image.asset("assets/logos/profile.png"),
              label: 'My Netflix'),
        ],
      ),
    );
  }
}
