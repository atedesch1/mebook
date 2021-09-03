import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:mebook/res/theme.dart';
import 'package:mebook/utils/auth_service.dart';
import 'package:mebook/screens/splash_screen.dart';
import 'package:mebook/screens/authentication/auth_screen.dart';
import 'package:mebook/screens/home_screen.dart';
import 'package:mebook/screens/authentication/welcome_screen.dart';
import 'package:mebook/screens/menu_screen.dart';

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
                  GoogleSignIn(),
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
                '/menu': (ctx) => MenuScreen(),
                '/home': (ctx) => HomeScreen(),
              },
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Something went wrong'),
              ),
            ),
          );
        }
        return MaterialApp(
          home: SplashScreen(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  // TODO: Need to pop screens after build, for now simple delay works...

  Future<void> popScreens(BuildContext context) async {
    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return MenuScreen();
    }
    popScreens(context);
    return WelcomeScreen();
  }
}
