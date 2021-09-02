import 'package:flutter/material.dart';
import 'package:mebook/utils/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Logout'),
              onPressed: context.read<AuthService>().signOut,
            ),
            Text('Home'),
          ],
        ),
      ),
    );
  }
}
