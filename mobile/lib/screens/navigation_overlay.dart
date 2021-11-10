import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mebook/utils/auth_service.dart';
import 'package:mebook/screens/home_screen.dart';
import 'package:mebook/screens/schedule_screen.dart';
import 'package:mebook/screens/notes_screen.dart';
import 'package:mebook/screens/finances_screen.dart';
import 'package:mebook/screens/profile_screen.dart';

class NavigationOverlay extends StatefulWidget {
  @override
  _NavigationOverlayState createState() => _NavigationOverlayState();
}

class _NavigationOverlayState extends State<NavigationOverlay> {
  final List<Map<String, Object>> _screens = [
    {
      'name': 'Home',
      'screen': HomeScreen(),
    },
    {
      'name': 'Schedule',
      'screen': ScheduleScreen(),
    },
    {
      'name': 'Notes',
      'screen': NotesScreen(),
    },
    {
      'name': 'Finances',
      'screen': FinancesScreen(),
    },
    {
      'name': 'Profile',
      'screen': ProfileScreen(),
    },
  ];

  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profilePictureURL =
        context.read<AuthService>().currentUser.photoURL ?? null;

    final circleAvatar = profilePictureURL != null
        ? CircleAvatar(
            radius: 13,
            backgroundImage: NetworkImage(profilePictureURL),
          )
        : null;

    return Scaffold(
      body: _screens[_selectedScreenIndex]['screen'],
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
            icon: profilePictureURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      ),
                      child: circleAvatar,
                    ),
                  )
                : Icon(Icons.person),
            activeIcon: circleAvatar,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
