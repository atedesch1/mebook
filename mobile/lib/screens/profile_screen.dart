import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebook/widgets/misc/overlay_app_bar.dart';
import 'package:mebook/widgets/profile/simple_count_statistic.dart';
import 'package:provider/provider.dart';

import 'package:mebook/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profilePictureURL =
        context.read<AuthService>().currentUser.photoURL ?? null;

    final circleAvatar = profilePictureURL != null
        ? CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.14,
            backgroundImage: NetworkImage(profilePictureURL),
          )
        : Icon(
            Icons.account_circle,
            color: Colors.black54,
            size: MediaQuery.of(context).size.width * 0.14 * 2,
          );

    final displayName = context.read<AuthService>().currentUser.displayName;

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
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      circleAvatar,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SimpleCountStatistic(name: 'Notes', count: 32),
                            SimpleCountStatistic(
                                name: 'Transactions', count: 12),
                            SimpleCountStatistic(name: 'Events', count: 140),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: displayName == null
                      ? FutureBuilder(
                          future: context.read<AuthService>().username,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            return CircularProgressIndicator();
                          })
                      : Text(
                          displayName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
