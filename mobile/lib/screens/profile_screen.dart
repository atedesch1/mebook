import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mebook/models/note_model.dart';
import 'package:mebook/models/transaction_model.dart';
import 'package:mebook/services/calendar_service.dart';
import 'package:mebook/services/finances_service.dart';
import 'package:mebook/services/notes_service.dart';
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

    final today = DateTime.now();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: circleAvatar,
                ),
                displayName == null
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StreamBuilder<List<Note>>(
                                stream: NotesService(context).getNotes(),
                                builder: (context, snapshot) {
                                  var count = snapshot.hasData
                                      ? snapshot.data
                                          .where((note) => !note.time
                                              .difference(DateTime(
                                                  today.year, today.month, 1))
                                              .isNegative)
                                          .toList()
                                          .length
                                      : 0;
                                  return SimpleCountStatistic(
                                      name: 'Notes', count: count);
                                }),
                            StreamBuilder<List<Transaction>>(
                                stream:
                                    FinancesService(context).getTransactions(),
                                builder: (context, snapshot) {
                                  return SimpleCountStatistic(
                                      name: 'Transactions',
                                      count: snapshot.hasData
                                          ? Transaction.filter(
                                                  transactions: snapshot.data,
                                                  month: today.month,
                                                  year: today.year)
                                              .length
                                          : 0);
                                }),
                            SimpleCountStatistic(name: 'Events', count: 0),
                          ],
                        ),
                      ),
                    ],
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
