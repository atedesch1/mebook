import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mebook/utils/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return Future<void>.value();
            },
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: context.read<AuthService>().signOut,
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
