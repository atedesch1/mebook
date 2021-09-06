import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mebook/utils/auth_service.dart';
import 'package:mebook/screens/home_screen.dart';
import 'package:mebook/screens/schedule_screen.dart';
import 'package:mebook/screens/notes_screen.dart';
import 'package:mebook/screens/finances_screen.dart';
import 'package:mebook/screens/profile_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    ScheduleScreen(),
    NotesScreen(),
    FinancesScreen(),
    ProfileScreen(),
  ];

  final List<String> _screenName = [
    'Home',
    'Schedule',
    'Notes',
    'Finances',
    'Profile',
  ];

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      appBar: AppBar(
        title: Text(_screenName[_selectedScreenIndex]),
        actions: [
          IconButton(
              onPressed: context.read<AuthService>().signOut,
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Finances',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
