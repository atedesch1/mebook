import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:provider/provider.dart';

import 'package:mebook/res/theme.dart';
import 'package:mebook/services/auth_service.dart';
import 'package:mebook/screens/splash_screen.dart';
import 'package:mebook/screens/auth_screen.dart';
import 'package:mebook/screens/welcome_screen.dart';
import 'package:mebook/screens/navigation_overlay.dart';

class MebookApp extends StatefulWidget {
  @override
  _MebookAppState createState() => _MebookAppState();
}

class _MebookAppState extends State<MebookApp> {
  final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInit,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(
                  FirebaseAuth.instance,
                  GoogleSignIn(scopes: <String>[
                    'email',
                    CalendarApi.calendarScope
                  ]),
                ),
              ),
              StreamProvider(
                create: (context) =>
                    context.read<AuthService>().authStateChanges,
                initialData: null,
              ),
            ],
            child: MaterialApp(
              title: 'Mebook App',
              theme: MebookTheme().themeData,
              home: AuthWrapper(),
              routes: {
                '/auth': (ctx) => AuthScreen(),
                '/nav': (ctx) => NavigationOverlay(),
              },
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            theme: MebookTheme().themeData,
            home: Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            ),
          );
        }
        return MaterialApp(
          theme: MebookTheme().themeData,
          home: SplashScreen(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  // FIX: Need to pop screens after build, for now simple delay works...

  Future<void> popScreens(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (Navigator.of(context).canPop()) popScreens(context);

    if (firebaseUser != null) {
      return NavigationOverlay();
    }

    return WelcomeScreen();
  }
}
