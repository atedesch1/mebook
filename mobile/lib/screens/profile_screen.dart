import 'package:flutter/material.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:provider/provider.dart';

import 'package:mebook/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          OverlayAppBar(
            title: 'Profile',
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
